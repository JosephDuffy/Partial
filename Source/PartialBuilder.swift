public final class PartialBuilder<Wrapped> {
    
    public private(set) var partial: Partial<Wrapped>
    
    private var updateHandlers: [PartialKeyPath<Wrapped>: [(Any?) -> Void]] = [:]
    
    public init(partial: Partial<Wrapped> = Partial<Wrapped>()) {
        self.partial = partial
    }
    
    public init(backingValue: Wrapped) {
        partial = Partial(backingValue: backingValue)
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
        updateHandlers[key]?.forEach { $0(value as Any) }
    }
    
    public func set<Value>(value: Value?, for key: KeyPath<Wrapped, Value?>) {
        partial.set(value: value, for: key)
        updateHandlers[key]?.forEach { $0(value as Any) }
    }
    
    public func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value>) where Value: PartialConvertible {
        partial.set(value: value, for: key)
        updateHandlers[key]?.forEach { $0(value as Any) }
    }
    
    public func removeValue<Value>(for key: KeyPath<Wrapped, Value>) {
        partial.removeValue(for: key)
        updateHandlers[key]?.forEach({ $0(nil) })
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
