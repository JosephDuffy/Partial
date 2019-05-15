public protocol PartialConvertible {
    
    init(partial: Partial<Self>) throws
    
}

extension Partial where Wrapped: PartialConvertible {
    
    func unwrappedValue() throws -> Wrapped {
        return try Wrapped(partial: self)
    }
    
}

extension Partial {
    
    public func value<ValueType>(for key: KeyPath<Wrapped, ValueType>) throws -> ValueType where ValueType: PartialConvertible {
        if let value = values[key] {
            if let value = value as? ValueType {
                return value
            } else if let partial = value as? Partial<ValueType> {
                return try ValueType(partial: partial)
            } else if let value = value {
                throw Error.invalidValueType(key: key, actualValue: value)
            }
        } else if let value = backingValue?[keyPath: key] {
            return value
        }
        
        throw Error.missingKey(key)
    }
    
    public func value<ValueType>(for key: KeyPath<Wrapped, ValueType?>) throws -> ValueType where ValueType: PartialConvertible {
        if let value = values[key] {
            if let value = value as? ValueType {
                return value
            } else if let partial = value as? Partial<ValueType> {
                return try ValueType(partial: partial)
            } else if let value = value {
                throw Error.invalidValueType(key: key, actualValue: value)
            }
        } else if let value = backingValue?[keyPath: key] {
            return value
        }
        
        throw Error.missingKey(key)
    }
    
    public subscript<ValueType>(key: KeyPath<Wrapped, ValueType>) -> Partial<ValueType> where ValueType: PartialConvertible {
        get {
            if let value = try? self.value(for: key) {
                return Partial<ValueType>(backingValue: value)
            } else if let partial = values[key] as? Partial<ValueType> {
                return partial
            } else {
                return Partial<ValueType>()
            }
        }
        set {
            values.updateValue(newValue, forKey: key)
        }
    }
    
    public subscript<ValueType>(key: KeyPath<Wrapped, ValueType?>) -> Partial<ValueType> where ValueType: PartialConvertible {
        get {
            if let value = try? self.value(for: key) {
                return Partial<ValueType>(backingValue: value)
            } else if let partial = values[key] as? Partial<ValueType> {
                return partial
            } else {
                return Partial<ValueType>()
            }
        }
        set {
            values.updateValue(newValue, forKey: key)
        }
    }
    
}
