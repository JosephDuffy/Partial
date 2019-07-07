/// A class that aids in the building of a partial value. 
public final class PartialBuilder<Wrapped>: PartialProtocol {

    /// A closure that will be notified when any property is udpated
    public typealias UpdateListener = (Partial<Wrapped>) -> Void

    /// A closure that will be notified when a propertie's value is updated. The closure will
    /// receive `nil` when the value has been removed
    public typealias PropertyUpdateListener<Value> = (Value?) -> Void

    /// The partial value this builder is building
    public private(set) var partial: Partial<Wrapped>

    /// A collection of objects wrapping closures that will be notified when any change occurs
    private var updateListeners: [UpdateListenerWrapper] = []

    /// A collection of objects wrapping closures that will be notified when a change to a key path occurs
    private var propertyUpdateListeners: [PartialKeyPath<Wrapped>: [PropertyUpdateListenerWrapper]] = [:]

    /// Create an empty `PartialBuilder`.
    public init() {
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
    public func addUpdateListener(updateListener: @escaping UpdateListener) -> AnyObject {
        let wrapper = UpdateListenerWrapper(updateListener: updateListener)

        updateListeners.append(wrapper)

        return wrapper
    }

    /// Add a closure that will be called when the provided key's value has been
    /// updated. The closure will be called with the new value.
    ///
    /// - Parameter keyPath: The key path to be notified of changes to
    /// - Parameter updateListener: A closure that will be called when the value of the key path is updated
    /// - Returns: An opaque object that represents the listener. It must be passed to `removeUpdateListener(_:)` to stop further updates
    public func addUpdateListener<Value>(
        for keyPath: KeyPath<Wrapped, Value>,
        updateListener: @escaping PropertyUpdateListener<Value>
    ) -> AnyObject {
        let wrapper = PropertyUpdateListenerWrapper(updateListener: updateListener)

        if var existingListeners = propertyUpdateListeners[keyPath] {
            existingListeners += [wrapper]
            propertyUpdateListeners[keyPath] = existingListeners
        } else {
            propertyUpdateListeners[keyPath] = [wrapper]
        }

        return wrapper
    }

    /// Remove the update listener associated with the opaque object
    /// 
    /// - Parameter updateListener: The opaque object returned by `addUpdateListener(for:updateListener:)`
    ///                             or `addUpdateListener(for:)`
    public func removeUpdateListener(_ updateListener: AnyObject) {
        if let updateListener = updateListener as? UpdateListenerWrapper {
            updateListeners.removeAll { $0 === updateListener }
        } else if let updateListener = updateListener as? PropertyUpdateListenerWrapper {
            for (key, wrappers) in propertyUpdateListeners {
                let filteredWrappers = wrappers.filter { $0 !== updateListener }
                if filteredWrappers.count != filteredWrappers.count {
                    propertyUpdateListeners[key] = filteredWrappers
                    return
                }
            }
        }
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
        notifyUpdateListeners(ofChangeTo: keyPath, newValue: nil)
    }

    private func notifyUpdateListeners(ofChangeTo keyPath: PartialKeyPath<Wrapped>, newValue: Any?) {
        propertyUpdateListeners[keyPath]?.forEach { $0.updateListener(newValue) }
        updateListeners.forEach { $0.updateListener(partial) }
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

    private final class UpdateListenerWrapper {

        fileprivate let updateListener: UpdateListener

        fileprivate init(updateListener: @escaping UpdateListener) {
            self.updateListener = updateListener
        }

    }

    private final class PropertyUpdateListenerWrapper {

        fileprivate let updateListener: PropertyUpdateListener<Any>

        fileprivate init<Value>(updateListener: @escaping PropertyUpdateListener<Value>) {
            self.updateListener = { newValue in
                guard let newValue = newValue as? Value? else { return }
                updateListener(newValue)
            }
        }

    }

}
