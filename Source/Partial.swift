import Foundation

public struct Partial<Wrapped>: PartialProtocol, CustomStringConvertible, CustomDebugStringConvertible {

    public enum Error<Value>: Swift.Error {
        case missingKey(KeyPath<Wrapped, Value>)
        case invalidValue(key: KeyPath<Wrapped, Value>, actualValue: Any?)
    }

    internal var values: [PartialKeyPath<Wrapped>: Any?] = [:]

    internal var backingValue: Wrapped? = nil

    public init(backingValue: Wrapped? = nil) {
        self.backingValue = backingValue
    }

    public func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value {
        if let value = values[key] {
            if let value = value as? Value {
                return value
            } else if let value = value {
                throw Error.invalidValue(key: key, actualValue: value)
            } else {
                throw Error.invalidValue(key: key, actualValue: nil)
            }
        } else if let value = backingValue?[keyPath: key] {
            return value
        }

        throw Error.missingKey(key)
    }

    public func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value? {
        if let value = values[key] {
            if let value = value as? Value {
                return value
            } else if let value = value {
                throw Error.invalidValue(key: key, actualValue: value)
            } else {
                // Key exists, but value has been set to nil
                return nil
            }
        } else if let value = backingValue?[keyPath: key] {
            return value
        }
        
        throw Error.missingKey(key)
    }
    
    public func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value where Value: PartialConvertible {
        if let value = values[key] {
            if let value = value as? Value {
                return value
            } else if let partial = value as? Partial<Value> {
                return try Value(partial: partial)
            } else if let value = value {
                throw Error.invalidValue(key: key, actualValue: value)
            } else {
                throw Error.invalidValue(key: key, actualValue: nil)
            }
        } else if let value = backingValue?[keyPath: key] {
            return value
        }
        
        throw Error.missingKey(key)
    }
    
    public func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value? where Value: PartialConvertible {
        if let value = values[key] {
            if let value = value as? Value {
                return value
            } else if let partial = value as? Partial<Value> {
                return try Value(partial: partial)
            } else if let value = value {
                throw Error.invalidValue(key: key, actualValue: value)
            } else {
                // Key exists, but value has been set to nil
                return nil
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

    public mutating func set<Value>(value: Value, for key: KeyPath<Wrapped, Value>) {
        values[key] = value
    }

    public mutating func set<Value>(value: Value?, for key: KeyPath<Wrapped, Value?>) {
        /**
         Uses `updateValue(_:forKey:)` to ensure the value is set to `nil`, rather than
         removed from the dictionary, which would happen if the subscript were used.
         This ensures that the `backingValue`'s value will not be used when
         a `backingValue` is set and a key is explicitly set to `nil`, and also allows
         the `value(for:)` function to get a value of `nil` from the dictionary.
         */
        values.updateValue(value, forKey: key)
    }
    
    public mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value>) where Value: PartialConvertible {
        values[key] = value
    }
    
    public mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value?>) where Value: PartialConvertible {
        values[key] = value
    }

    public mutating func removeValue<Value>(for key: KeyPath<Wrapped, Value>) {
        values.removeValue(forKey: key)
    }

}

extension Partial where Wrapped: PartialConvertible {
    
    public func unwrappedValue() throws -> Wrapped {
        return try Wrapped(partial: self)
    }
    
}
