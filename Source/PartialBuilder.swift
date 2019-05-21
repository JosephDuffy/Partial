public final class PartialBuilder<Wrapped> {
    
    public typealias UpdateListener = (Any?) -> Void
    
    public private(set) var partial: Partial<Wrapped>
    
    private var updateListeners: [PartialKeyPath<Wrapped>: [UpdateListenerWrapper]] = [:]
    
    public init(partial: Partial<Wrapped> = Partial<Wrapped>()) {
        self.partial = partial
    }
    
    public init(backingValue: Wrapped) {
        partial = Partial(backingValue: backingValue)
    }
    
    /**
     Add a closure that will be called when the provided key's value has been
     updated. The closure will be called with the new value.
     
     - returns: An opaque object that represents the listener. It must be passed
                to `removeUpdateListener(_:)` to stop further updates
     */
    public func addUpdateListener<Value>(for key: KeyPath<Wrapped, Value>, updateListener: @escaping UpdateListener) -> AnyObject {
        let wrapper = UpdateListenerWrapper(updateListener: updateListener)
        
        if var existingListeners = updateListeners[key] {
            existingListeners += [wrapper]
            updateListeners[key] = existingListeners
        } else {
            updateListeners[key] = [wrapper]
        }
        
        return wrapper
    }
    
    public func removeUpdateListener(_ updateListener: AnyObject) {
        guard let updateListener = updateListener as? UpdateListenerWrapper else { return }
        
        for (key, wrappers) in updateListeners {
            let filteredWrappers = wrappers.filter  { $0 !== updateListener }
            if filteredWrappers.count != filteredWrappers.count {
                updateListeners[key] = filteredWrappers
                return
            }
        }
    }
    
    public func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value {
        return try partial.value(for: key)
    }
    
    public func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value {
        return try partial.value(for: key)
    }
    
    public func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value where Value: PartialConvertible {
        return try partial.value(for: key)
    }
    
    public func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value where Value: PartialConvertible {
        return try partial.value(for: key)
    }
    
    public func partialValue<Value>(for key: KeyPath<Wrapped, Value>) throws -> Partial<Value> where Value: PartialConvertible {
        return try partial.partialValue(for: key)
    }
    
    public func partialValue<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Partial<Value> where Value: PartialConvertible {
        return try partial.partialValue(for: key)
    }
    
    public func set<Value>(value: Value, for key: KeyPath<Wrapped, Value>) {
        partial.set(value: value, for: key)
        updateListeners[key]?.forEach { $0.updateListener(value as Any) }
    }
    
    public func set<Value>(value: Value?, for key: KeyPath<Wrapped, Value?>) {
        partial.set(value: value, for: key)
        updateListeners[key]?.forEach { $0.updateListener(value as Any) }
    }
    
    public func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value>) where Value: PartialConvertible {
        partial.set(value: value, for: key)
        updateListeners[key]?.forEach { $0.updateListener(value as Any) }
    }
    
    public func removeValue<Value>(for key: KeyPath<Wrapped, Value>) {
        partial.removeValue(for: key)
        updateListeners[key]?.forEach({ $0.updateListener(nil) })
    }
    
    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Value? {
        get {
            return partial[key]
        }
        set {
            partial.removeValue(for: key)
        }
    }
    
    public subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Value? {
        get {
            return partial[key]
        }
        set {
            set(value: newValue, for: key)
        }
    }
    
    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Partial<Value> where Value: PartialConvertible {
        get {
            return partial[key]
        }
        set {
            set(value: newValue, for: key)
        }
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

}
