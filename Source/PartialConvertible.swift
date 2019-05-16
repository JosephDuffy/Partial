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
        if let value = try? self.value(for: key) {
            return Partial<Value>(backingValue: value)
        } else if let partial = values[key] as? Partial<Value> {
            return partial
        } else {
            return Partial<Value>()
        }
    }
    
    public func partialValue<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Partial<Value> where Value: PartialConvertible {
        if let value = try? self.value(for: key) {
            return Partial<Value>(backingValue: value)
        } else if let partial = values[key] as? Partial<Value> {
            return partial
        } else {
            return Partial<Value>()
        }
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
