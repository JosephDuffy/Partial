import Foundation

public struct Partial<Wrapped>: CustomStringConvertible, CustomDebugStringConvertible {
    
    public enum Error<ValueType>: Swift.Error {
        case missingKey(KeyPath<Wrapped, ValueType>)
        case invalidValueType(key: KeyPath<Wrapped, ValueType>, actualValue: Any)
    }
    
    internal private(set) var values: [PartialKeyPath<Wrapped>: Any?] = [:]
    
    internal var backingValue: Wrapped? = nil
    
    private var updateHandlers: [PartialKeyPath<Wrapped>: [(Any) -> Void]] = [:]
    
    public init(backingValue: Wrapped? = nil) {
        self.backingValue = backingValue
    }
    
    public func value<ValueType>(for key: KeyPath<Wrapped, ValueType>) throws -> ValueType {
        if let value = values[key] {
            if let value = value as? ValueType {
                return value
            } else if let value = value {
                throw Error.invalidValueType(key: key, actualValue: value)
            }
        } else if let value = backingValue?[keyPath: key] {
            return value
        }
        
        throw Error.missingKey(key)
    }
    
    public func value<ValueType>(for key: KeyPath<Wrapped, ValueType?>) throws -> ValueType {
        if let value = values[key] {
            if let value = value as? ValueType {
                return value
            } else if let value = value {
                throw Error.invalidValueType(key: key, actualValue: value)
            }
        } else if let value = backingValue?[keyPath: key] {
            return value
        }
        
        throw Error.missingKey(key)
    }
    
    public mutating func set<Value>(value: Value, for key: KeyPath<Wrapped, Value>) {
        values[key] = value
        updateHandlers[key]?.forEach { $0(value as Any) }
    }
    
    public mutating func set<Value>(value: Value?, for key: KeyPath<Wrapped, Value>) {
        /**
         Uses `updateValue(_:forKey:)` to ensure the value is set to `nil`.
         When the subscript is used the key is removed from the dictionary.
         This ensures that the `backingValue`'s value will not be used when
         a `backingValue` is set and a key is explicitly set to `nil`
         */
        values.updateValue(value, forKey: key)
        updateHandlers[key]?.forEach { $0(value as Any) }
    }
    
    public mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value>) where Value: PartialConvertible {
        values[key] = value
        updateHandlers[key]?.forEach { $0(value as Any) }
    }
    
    public mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value?>) where Value: PartialConvertible {
        values[key] = value
        updateHandlers[key]?.forEach { $0(value as Any) }
    }
    
    public subscript<ValueType>(key: KeyPath<Wrapped, ValueType>) -> ValueType? {
        get {
            return try? value(for: key)
        }
        set {
            values.updateValue(newValue, forKey: key)
        }
    }
    
    public subscript<ValueType>(key: KeyPath<Wrapped, ValueType?>) -> ValueType? {
        get {
            return try? value(for: key)
        }
        set {
            values.updateValue(newValue, forKey: key)
        }
    }
    
}
