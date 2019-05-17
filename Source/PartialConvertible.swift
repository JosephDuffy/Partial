public protocol PartialConvertible {
    
    init(partial: Partial<Self>) throws
    
}

extension Partial where Wrapped: PartialConvertible {
    
    public func unwrappedValue() throws -> Wrapped {
        return try Wrapped(partial: self)
    }
    
}

extension Partial {
    
    public func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value where Value: PartialConvertible {
        if let value = values[key] {
            if let value = value as? Value {
                return value
            } else if let partial = value as? Partial<Value> {
                return try Value(partial: partial)
            } else if let value = value {
                throw Error.invalidValue(key: key, actualValue: value)
            }
        } else if let value = backingValue?[keyPath: key] {
            return value
        }
        
        throw Error.missingKey(key)
    }
    
    public func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value where Value: PartialConvertible {
        if let value = values[key] {
            if let value = value as? Value {
                return value
            } else if let partial = value as? Partial<Value> {
                return try Value(partial: partial)
            } else if let value = value {
                throw Error.invalidValue(key: key, actualValue: value)
            }
        } else if let value = backingValue?[keyPath: key] {
            return value
        }
        
        throw Error.missingKey(key)
    }
    
    public func partialValue<Value>(for key: KeyPath<Wrapped, Value>) throws -> Partial<Value> where Value: PartialConvertible {
        if let value = values[key] {
            if let value = value as? Value {
                return Partial<Value>(backingValue: value)
            } else if let value = value as? Partial<Value> {
                return value
            } else {
                throw Error.invalidValue(key: key, actualValue: value)
            }
        } else if let value = backingValue?[keyPath: key] {
            return Partial<Value>(backingValue: value)
        }
        
        throw Error.missingKey(key)
    }
    
    public func partialValue<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Partial<Value> where Value: PartialConvertible {
        if let value = values[key] {
            if let value = value as? Value {
                return Partial<Value>(backingValue: value)
            } else if let value = value as? Partial<Value> {
                return value
            } else {
                throw Error.invalidValue(key: key, actualValue: value)
            }
        } else if let value = backingValue?[keyPath: key] {
            return Partial<Value>(backingValue: value)
        }
        
        throw Error.missingKey(key)
    }
    
    public mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value>) where Value: PartialConvertible {
        values[key] = value
        updateHandlers[key]?.forEach { $0(value as Any) }
    }
    
    public mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value?>) where Value: PartialConvertible {
        values[key] = value
        updateHandlers[key]?.forEach { $0(value as Any) }
    }
    
    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Partial<Value> where Value: PartialConvertible {
        get {
            do {
                return try self.partialValue(for: key)
            } catch {
                return Partial<Value>()
            }
        }
        set {
            set(value: newValue, for: key)
        }
    }
    
    public subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Partial<Value> where Value: PartialConvertible {
        get {
            do {
                return try self.partialValue(for: key)
            } catch {
                return Partial<Value>()
            }
        }
        set {
            set(value: newValue, for: key)
        }
    }
    
}
