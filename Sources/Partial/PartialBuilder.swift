import Foundation

/// A class that aids in the building of a partial value.
open class PartialBuilder<Wrapped>: PartialProtocol {

    public enum PropertyUpdate<Value> {
        case valueSet(_ value: Value)
        case valueRemoved
    }

    /// A closure that will be notified when any property is udpated
    public typealias UpdateListener = (_ keyPath: PartialKeyPath<Wrapped>, PartialBuilder<Wrapped>) -> Void

    /// A closure that will be notified when a key path is updated
    public typealias PropertyUpdateListener<Value> = (_ keyPath: KeyPath<Wrapped, Value>, _ update: PropertyUpdate<Value>) -> Void

    /// A closure that will be notified when a key path is updated
    public typealias OptionalPropertyUpdateListener<Value> = (_ keyPath: KeyPath<Wrapped, Value?>, _ update: PropertyUpdate<Value?>) -> Void

    /// The partial value this builder is building
    private var partial: Partial<Wrapped>

    /// A collection of objects wrapping closures that will be notified when any change occurs
    private var updateListeners: Set<Weak<UpdateCancellable>> = []

    /// A collection of objects wrapping closures that will be notified when a change to a key path occurs
    private var propertyUpdateListeners: [PartialKeyPath<Wrapped>: Set<Weak<PropertyUpdateCancellable>>] = [:]

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

    /// Add a closure that will be called when any key's value has been
    /// updated. The closure will be called with the new partial.
    ///
    /// - Parameter updateListener: A closure that will be called when a property is updated.
    /// - returns: An opaque object that represents the listener. It must be passed to `removeUpdateListener(_:)` to stop further updates.
    public func subscribeToAllChanges(updateListener: @escaping UpdateListener) -> Cancellable {
        let cancellable = UpdateCancellable(updateListener: updateListener) { [weak self] cancellable in
            self?.updateListeners.remove(Weak(cancellable))
        }
        updateListeners.insert(Weak(cancellable))
        return cancellable
    }

    /// Add a closure that will be called when the provided key path's value has been
    /// updated. The closure will be called with the new value.
    ///
    /// - Parameter keyPath: The key path to be notified of changes to
    /// - Parameter updateListener: A closure that will be called when the value of the key path is updated
    /// - Returns: An cancellable object that represents the subscription. Dealloc the object or call `cancel()` to unsubscribe from changes
    public func subscribeForChanges<Value>(
        to keyPath: KeyPath<Wrapped, Value>,
        updateListener: @escaping PropertyUpdateListener<Value>
    ) -> Cancellable {
        let wrapper = PropertyUpdateCancellable(
            keyPath: keyPath,
            updateListener: updateListener,
            cancelAction: { [weak self] cancellable in
                guard let self = self else { return }
                self.propertyUpdateListeners[keyPath]?.remove(Weak(cancellable))
            }
        )

        propertyUpdateListeners[keyPath, default: []].insert(Weak(wrapper))

        return wrapper
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
        partial.setValue(value, for: keyPath)
        notifyUpdateListeners(ofChangeTo: keyPath, newValue: value)
    }

    /// Removes the stored value for the given key path.
    ///
    /// - Parameter keyPath: The key path of the value to remove.
    public func removeValue(for keyPath: PartialKeyPath<Wrapped>) {
        partial.removeValue(for: keyPath)
        notifyUpdateListenersOfRemoval(of: keyPath)
    }

    private func notifyUpdateListeners<Value>(ofChangeTo keyPath: PartialKeyPath<Wrapped>, newValue: Value) {
        propertyUpdateListeners[keyPath]?.forEach { $0.wrapped?.notify(of: newValue) }
        updateListeners.forEach { $0.wrapped?.updateListener(keyPath, self) }
    }

    private func notifyUpdateListenersOfRemoval(of keyPath: PartialKeyPath<Wrapped>) {
        propertyUpdateListeners[keyPath]?.forEach { $0.wrapped?.notifyOfRemovable() }
        updateListeners.forEach { $0.wrapped?.updateListener(keyPath, self) }
    }

}

extension PartialBuilder where Wrapped: PartialConvertible {

    /// Attempts to initialise a new `Wrapped` with the partial
    ///
    /// Any errors thrown by `Wrapped.init(partial:)` will be rethrown
    ///
    /// - Returns: The new `Wrapped` instance
    public func unwrappedValue() throws -> Wrapped {
        return try Wrapped(partial: partial)
    }

}

extension PartialBuilder {

    private final class UpdateCancellable: Cancellable, Hashable {

        static func == (lhs: UpdateCancellable, rhs: UpdateCancellable) -> Bool {
            return lhs.uuid == rhs.uuid
        }

        fileprivate let updateListener: UpdateListener
        private let uuid = UUID()

        init(updateListener: @escaping UpdateListener, cancelAction: @escaping (UpdateCancellable) -> Void) {
            self.updateListener = updateListener

            super.init(cancelAction: { cancellable in
                guard let cancellable = cancellable as? UpdateCancellable else {
                    preconditionFailure()
                }
                cancelAction(cancellable)
            })
        }

        func hash(into hasher: inout Hasher) {
            return uuid.hash(into: &hasher)
        }

    }

    private final class PropertyUpdateCancellable: Cancellable, Hashable {

        static func == (lhs: PartialBuilder<Wrapped>.PropertyUpdateCancellable, rhs: PartialBuilder<Wrapped>.PropertyUpdateCancellable) -> Bool {
            return lhs.uuid == rhs.uuid
        }

        private let _notifyOfValue: (Any?) -> Void
        private let _notifyOfRemovable: () -> Void
        private let uuid = UUID()

        init<Value>(keyPath: KeyPath<Wrapped, Value>, updateListener: @escaping PropertyUpdateListener<Value>, cancelAction: @escaping (PropertyUpdateCancellable) -> Void) {
            self._notifyOfValue = { value in
                guard let value = value as? Value else {
                    assertionFailure("Update listener should only be called with value of type \(Value.self)")
                    return
                }
                let update = PropertyUpdate<Value>.valueSet(value)
                updateListener(keyPath, update)
            }
            self._notifyOfRemovable = {
                let update = PropertyUpdate<Value>.valueRemoved
                updateListener(keyPath, update)
            }

            super.init(cancelAction: { cancellable in
                guard let cancellable = cancellable as? PropertyUpdateCancellable else {
                    preconditionFailure()
                }
                cancelAction(cancellable)
            })
        }

        init<Value>(keyPath: KeyPath<Wrapped, Value?>, updateListener: @escaping OptionalPropertyUpdateListener<Value>, cancelAction: @escaping CancelAction) {
            self._notifyOfValue = { value in
                guard let value = value as? Value? else {
                    assertionFailure("Update listener should only be called with value of type \(Value?.self)")
                    return
                }
                let update = PropertyUpdate<Value?>.valueSet(value)
                updateListener(keyPath, update)
            }
            self._notifyOfRemovable = {
                let update = PropertyUpdate<Value?>.valueRemoved
                updateListener(keyPath, update)
            }

            super.init(cancelAction: { cancellable in
                guard let cancellable = cancellable as? PropertyUpdateCancellable else {
                    preconditionFailure()
                }
                cancelAction(cancellable)
            })
        }

        func notify(of newValue: Any?) {
            _notifyOfValue(newValue)
        }

        func notifyOfRemovable() {
            _notifyOfRemovable()
        }

        func hash(into hasher: inout Hasher) {
            return uuid.hash(into: &hasher)
        }

    }

}

extension PartialBuilder.PropertyUpdate: Equatable where Value: Equatable { }
