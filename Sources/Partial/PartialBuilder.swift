public final class PartialBuilder<Wrapped>: PartialProtocol {

    public typealias UpdateListener = (Partial<Wrapped>) -> Void

    public typealias PropertyUpdateListener<Value> = (Value?) -> Void

    public private(set) var partial: Partial<Wrapped>

    private var updateListeners: [UpdateListenerWrapper] = []

    private var propertyUpdateListeners: [PartialKeyPath<Wrapped>: [PropertyUpdateListenerWrapper]] = [:]

    public init(partial: Partial<Wrapped> = Partial<Wrapped>()) {
        self.partial = partial
    }

    public init(backingValue: Wrapped) {
        partial = Partial(backingValue: backingValue)
    }

    /**
     Add a closure that will be called when any key's value has been
     updated. The closure will be called with the new partial.
     
     - returns: An opaque object that represents the listener. It must be passed
     to `removeUpdateListener(_:)` to stop further updates
     */
    public func addUpdateListener(updateListener: @escaping UpdateListener) -> AnyObject {
        let wrapper = UpdateListenerWrapper(updateListener: updateListener)

        updateListeners.append(wrapper)

        return wrapper
    }

    /**
     Add a closure that will be called when the provided key's value has been
     updated. The closure will be called with the new value.
     
     - returns: An opaque object that represents the listener. It must be passed
                to `removeUpdateListener(_:)` to stop further updates
     */
    public func addUpdateListener<Value>(
        for key: KeyPath<Wrapped, Value>,
        updateListener: @escaping PropertyUpdateListener<Value>
    ) -> AnyObject {
        let wrapper = PropertyUpdateListenerWrapper(updateListener: updateListener)

        if var existingListeners = propertyUpdateListeners[key] {
            existingListeners += [wrapper]
            propertyUpdateListeners[key] = existingListeners
        } else {
            propertyUpdateListeners[key] = [wrapper]
        }

        return wrapper
    }

    public func removeUpdateListener(_ updateListener: AnyObject) {
        guard let updateListener = updateListener as? UpdateListenerWrapper else { return }

        for (key, wrappers) in propertyUpdateListeners {
            let filteredWrappers = wrappers.filter { $0 !== updateListener }
            if filteredWrappers.count != filteredWrappers.count {
                propertyUpdateListeners[key] = filteredWrappers
                return
            }
        }
    }

    public func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value {
        return try partial.value(for: key)
    }

    public func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value? {
        return try partial.value(for: key)
    }

    public func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value where Value: PartialConvertible {
        return try partial.value(for: key)
    }

    public func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value? where Value: PartialConvertible {
        return try partial.value(for: key)
    }

    public func partialValue<Value>(for key: KeyPath<Wrapped, Value>) throws -> Partial<Value> {
        return try partial.partialValue(for: key)
    }

    public func partialValue<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Partial<Value> {
        return try partial.partialValue(for: key)
    }

    public func set<Value>(value: Value, for key: KeyPath<Wrapped, Value>) {
        partial.set(value: value, for: key)
        notifyUpdateListeners(ofChangeTo: key, newValue: value)
    }

    public func set<Value>(value: Value?, for key: KeyPath<Wrapped, Value?>) {
        partial.set(value: value, for: key)
        if let value = value {
            notifyUpdateListeners(ofChangeTo: key, newValue: value)
        } else {
            notifyUpdateListeners(ofChangeTo: key, newValue: nil)
        }
    }

    public func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value>) where Value: PartialConvertible {
        partial.set(value: value, for: key)
        notifyUpdateListeners(ofChangeTo: key, newValue: value)
    }

    public func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value?>) where Value: PartialConvertible {
        partial.set(value: value, for: key)
        notifyUpdateListeners(ofChangeTo: key, newValue: value)
    }

    public func removeValue<Value>(for key: KeyPath<Wrapped, Value>) {
        partial.removeValue(for: key)
        notifyUpdateListeners(ofChangeTo: key, newValue: nil)
    }

    private func notifyUpdateListeners(ofChangeTo key: PartialKeyPath<Wrapped>, newValue: Any?) {
        propertyUpdateListeners[key]?.forEach { $0.updateListener(newValue) }
        updateListeners.forEach { $0.updateListener(partial) }
    }

}

extension PartialBuilder where Wrapped: PartialConvertible {

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
