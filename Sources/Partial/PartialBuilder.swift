import Foundation

/// A class that aids in the building of a partial value.
open class PartialBuilder<Wrapped>: PartialProtocol, CustomStringConvertible {

    /// An update to a key path
    public struct KeyPathUpdate<Value> {

        /// The kind of update that occured
        public enum Kind {
            /// The value was set to `value`
            case valueSet(_ value: Value)

            /// The value was removed
            case valueRemoved
        }

        /// The kind of update that occured to `keyPath`
        public let kind: Kind

        /// The key path that the update occured on
        public let keyPath: KeyPath<Wrapped, Value>

        /// The value before this update
        public let oldValue: Value?

        /// The value after this update
        public var newValue: Value? {
            switch kind {
            case .valueSet(let value):
                return value
            case .valueRemoved:
                return nil
            }
        }

        init(kind: Kind, keyPath: KeyPath<Wrapped, Value>, oldValue: Value?) {
            self.kind = kind
            self.keyPath = keyPath
            self.oldValue = oldValue
        }
    }

    /// A closure that will be notified when any property is udpated
    public typealias AllChangesUpdateListener = (_ keyPath: PartialKeyPath<Wrapped>, PartialBuilder<Wrapped>) -> Void

    /// A closure that will be notified when a key path is updated
    public typealias KeyPathUpdateListener<Value> = (_ update: KeyPathUpdate<Value>) -> Void

    /// A textual representation of the PartialBuilder's values.
    public var description: String {
        return "\(type(of: self))(partial: \(partial))"
    }

    /// The partial value this builder is building
    public private(set) var partial: Partial<Wrapped>

    /// A collection of objects wrapping closures that will be notified when any change occurs
    private var allChangesSubscriptions: Set<Weak<AllChangesSubscription>> = []

    /// A collection of objects wrapping closures that will be notified when a change to a key path occurs
    private var keyPathSubscriptions: [PartialKeyPath<Wrapped>: Set<Weak<KeyPathChangesSubscription>>] = [:]
    
    private var attachedSubscription: Subscription?

    /// Create an empty `PartialBuilder`.
    required public init() {
        partial = Partial<Wrapped>()
    }

    /// Create a `PartialBuilder` that starts with the provided partial.
    ///
    /// - Parameter partial: A `Partial` containing the initial values the builder should use
    public init(partial: Partial<Wrapped>) {
        self.partial = partial
    }

    /// Adds a closure that will be called when any key path has been updated. The closure will be called with the key
    /// path that was updated and this `PartialBuilder`.
    ///
    /// - Parameter updateListener: A closure that will be called when any key path is updated.
    /// - Returns: An object that represents the subscription.
    public func subscribeToAllChanges(updateListener: @escaping AllChangesUpdateListener) -> Subscription {
        let subscription = AllChangesSubscription(updateListener: updateListener) { [weak self] subscription in
            self?.allChangesSubscriptions.remove(Weak(subscription))
        }
        allChangesSubscriptions.insert(Weak(subscription))
        return subscription
    }

    /// Adds a closure that will be called when the provided key path has been updated. The closure will be called with
    /// the key value and an update that provides the change that occured.
    ///
    /// - Parameter keyPath: The key path to be notified of changes to
    /// - Parameter updateListener: A closure that will be called when the key path is updated
    /// - Returns: An object that represents the subscription.
    public func subscribeForChanges<Value>(
        to keyPath: KeyPath<Wrapped, Value>,
        updateListener: @escaping KeyPathUpdateListener<Value>
    ) -> Subscription {
        let subscription = KeyPathChangesSubscription(
            keyPath: keyPath,
            updateListener: updateListener,
            cancelAction: { [weak self] subscription in
                guard let self = self else { return }
                self.keyPathSubscriptions[keyPath]?.remove(Weak(subscription))
            }
        )

        keyPathSubscriptions[keyPath, default: []].insert(Weak(subscription))

        return subscription
    }

    /// Returns the value of the given key path, or throws an error if the value has not been set.
    ///
    /// - Parameter keyPath: A keyPath path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value.
    public func value<Value>(for keyPath: KeyPath<Wrapped, Value>) throws -> Value {
        return try partial.value(for: keyPath)
    }

    /// Updates the stored value for the given key path.
    ///
    /// - Parameter value: The value to store against `keyPath`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    public func setValue<Value>(_ value: Value, for keyPath: KeyPath<Wrapped, Value>) {
        let oldValue = partial[keyPath]
        partial.setValue(value, for: keyPath)
        notifyUpdateListeners(ofChangeTo: keyPath, from: oldValue, to: value)
    }

    /// Removes the stored value for the given key path.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    public func removeValue<Value>(for keyPath: KeyPath<Wrapped, Value>) {
        let oldValue = partial[keyPath]
        partial.removeValue(for: keyPath)
        notifyUpdateListenersOfRemoval(of: keyPath, oldValue: oldValue)
    }

    private func notifyUpdateListeners<Value>(ofChangeTo keyPath: PartialKeyPath<Wrapped>, from oldValue: Value?, to newValue: Value) {
        keyPathSubscriptions[keyPath]?.forEach { $0.wrapped?.notifyOfUpdate(from: oldValue, to: newValue) }
        allChangesSubscriptions.forEach { $0.wrapped?.updateListener(keyPath, self) }
    }

    private func notifyUpdateListenersOfRemoval<Value>(of keyPath: KeyPath<Wrapped, Value>, oldValue: Value?) {
        keyPathSubscriptions[keyPath]?.forEach { $0.wrapped?.notifyOfRemovable(oldValue: oldValue) }
        allChangesSubscriptions.forEach { $0.wrapped?.updateListener(keyPath, self) }
    }
    
    /// Creates a `PartialBuilder` for any `PartialConvertable` field in the type. It will automatically subscribe the original `PartialBuilder` to get updates made to the field's builder.
    ///
    /// - Parameter for: The `KeyPath` to create a `PartialBuilder` for.
    ///
    /// - Returns: The attached `PartialBuilder` for the path.
    ///
    /// - SeeAlso: `detach()`
    public func builder<Value: PartialConvertible>(for keyPath: KeyPath<Wrapped, Value>) -> PartialBuilder<Value> {
        let result = PartialBuilder<Value>()
        result.attachedSubscription = result.subscribeToAllChanges { _, builder in
            do {
                try self.setValue(Value(partial: builder), for: keyPath)
            } catch {
                self.removeValue(for: keyPath)
            }
        }
        return result
    }

    /// If this `PartialBuilder` was created via `builder(for:)`, it will detach it, cancelling any further updates to the originating `PartialBuilder`.
    /// It will have no effect for root-level `PartialBuilder`s.
    public func detach() {
        attachedSubscription = nil
    }
}

extension PartialBuilder {

    private final class AllChangesSubscription: Subscription {

        typealias CancelAction = (AllChangesSubscription) -> Void

        fileprivate let updateListener: AllChangesUpdateListener
        private let cancelAction: CancelAction

        init(updateListener: @escaping AllChangesUpdateListener, cancelAction: @escaping CancelAction) {
            self.updateListener = updateListener
            self.cancelAction = cancelAction

            super.init()
        }

        override func cancel() {
            cancelAction(self)
        }

    }

    private final class KeyPathChangesSubscription: Subscription {

        typealias CancelAction = (KeyPathChangesSubscription) -> Void

        private let _notifyOfValue: (_ oldValue: Any?, _ newValue: Any?) -> Void
        private let _notifyOfRemovable: (_ oldValue: Any?) -> Void
        private let cancelAction: CancelAction

        init<Value>(keyPath: KeyPath<Wrapped, Value>, updateListener: @escaping KeyPathUpdateListener<Value>, cancelAction: @escaping CancelAction) {
            self._notifyOfValue = { oldValue, newValue in
                guard let oldValue = oldValue as? Value? else {
                    assertionFailure("Update listener should only be called with value of type \(Value?.self)")
                    return
                }
                guard let newValue = newValue as? Value else {
                    assertionFailure("Update listener should only be called with value of type \(Value.self)")
                    return
                }
                let update = KeyPathUpdate<Value>(kind: .valueSet(newValue), keyPath: keyPath, oldValue: oldValue)
                updateListener(update)
            }
            self._notifyOfRemovable = { oldValue in
                guard let oldValue = oldValue as? Value? else {
                    assertionFailure("Update listener should only be called with value of type \(Value?.self)")
                    return
                }
                let update = KeyPathUpdate<Value>(kind: .valueRemoved, keyPath: keyPath, oldValue: oldValue)
                updateListener(update)
            }
            self.cancelAction = cancelAction

            super.init()
        }

        func notifyOfUpdate<Value>(from oldValue: Value?, to newValue: Value) {
            _notifyOfValue(oldValue, newValue)
        }

        func notifyOfRemovable(oldValue: Any?) {
            _notifyOfRemovable(oldValue)
        }

        override func cancel() {
            cancelAction(self)
        }

    }

}

extension PartialBuilder.KeyPathUpdate.Kind: Equatable where Value: Equatable {}
extension PartialBuilder.KeyPathUpdate: Equatable where Value: Equatable {}
