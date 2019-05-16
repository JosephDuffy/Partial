import Foundation

public struct Partial<Wrapped>: CustomStringConvertible, CustomDebugStringConvertible {

    public enum Error<Value>: Swift.Error {
        case missingKey(KeyPath<Wrapped, Value>)
        case invalidValue(key: KeyPath<Wrapped, Value>, actualValue: Any?)
    }

    internal var values: [PartialKeyPath<Wrapped>: Any?] = [:]

    internal var backingValue: Wrapped? = nil

    internal var updateHandlers: [PartialKeyPath<Wrapped>: [(Any?) -> Void]] = [:]

    public init(backingValue: Wrapped? = nil) {
        self.backingValue = backingValue
    }

    public func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value {
        if let value = values[key] {
            if let value = value as? Value {
                return value
            } else if let value = value {
                throw Error.invalidValue(key: key, actualValue: value)
            }
        } else if let value = backingValue?[keyPath: key] {
            return value
        }

        throw Error.missingKey(key)
    }

    public func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value {
        if let value = values[key] {
            if let value = value as? Value {
                return value
            } else if let value = value {
                throw Error.invalidValue(key: key, actualValue: value)
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

    public mutating func set<Value>(value: Value?, for key: KeyPath<Wrapped, Value?>) {
        /**
         Uses `updateValue(_:forKey:)` to ensure the value is set to `nil`, rather than
         removed from the dictionary, which would happen if the subscript were used.
         This ensures that the `backingValue`'s value will not be used when
         a `backingValue` is set and a key is explicitly set to `nil`
         */
        values.updateValue(value, forKey: key)
        updateHandlers[key]?.forEach { $0(value as Any) }
    }

    public mutating func removeValue<Value>(for key: KeyPath<Wrapped, Value>) {
        values.removeValue(forKey: key)
        updateHandlers[key]?.forEach { $0(nil) }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Value? {
        get {
            return try? value(for: key)
        }
        set {
            values.updateValue(newValue, forKey: key)
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Value? {
        get {
            return try? value(for: key)
        }
        set {
            values.updateValue(newValue, forKey: key)
        }
    }

}
