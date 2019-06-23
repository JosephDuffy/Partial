import Foundation

/// A Partial version of the `Wrapped` type.
public struct Partial<Wrapped>: PartialProtocol {

    /// An error that can be thrown by the `value(for:)` function
    public enum Error<Value>: Swift.Error {
        /// The key path has not been set.
        case keyPathNotSet(KeyPath<Wrapped, Value>)
    }

    internal var values: [PartialKeyPath<Wrapped>: Any?] = [:]

    internal var backingValue: Wrapped?

    public init() {
        backingValue = nil
    }

    public init(backingValue: Wrapped) {
        self.backingValue = backingValue
    }

    public func value<Value>(for keyPath: KeyPath<Wrapped, Value>) throws -> Value {
        if let value = values[keyPath] {
            switch value {
            case .some(let value as Value):
                return value
            case .some(let value):
                preconditionFailure("Value has been set, but is not of type \(Value.self): \(value)")
            case .none:
                preconditionFailure("Non-optional value has been set to nil")
            }
        } else if let backingValue = backingValue {
            return backingValue[keyPath: keyPath]
        } else {
            throw Error.keyPathNotSet(keyPath)
        }
    }

    public func value<Value>(for keyPath: KeyPath<Wrapped, Value?>) throws -> Value? {
        if let value = values[keyPath] {
            switch value {
            case .some(let value as Value):
                return value
            case .some(let value):
                preconditionFailure("Value has been set, but is not of type \(Value.self): \(value)")
            case .none:
                // Value has been explicitly set to `nil`
                return nil
            }
        } else if let backingValue = backingValue {
            return backingValue[keyPath: keyPath]
        } else {
            throw Error.keyPathNotSet(keyPath)
        }
    }

    public func value<Value>(for keyPath: KeyPath<Wrapped, Value>) throws -> Value where Value: PartialConvertible {
        if let value = values[keyPath] {
            switch value {
            case .some(let value as Value):
                return value
            case .some(let partial as Partial<Value>):
                return try Value(partial: partial)
            case .some(let value):
                preconditionFailure("Value has been set, but is not of type \(Value.self) or \(Partial<Value>.self): \(value)")
            case .none:
                preconditionFailure("Non-optional value has been set to nil")
            }
        } else if let backingValue = backingValue {
            return backingValue[keyPath: keyPath]
        } else {
            throw Error.keyPathNotSet(keyPath)
        }
    }

    public func value<Value>(for keyPath: KeyPath<Wrapped, Value?>) throws -> Value? where Value: PartialConvertible {
        if let value = values[keyPath] {
            switch value {
            case .some(let value as Value):
                return value
            case .some(let partial as Partial<Value>):
                return try Value(partial: partial)
            case .some(let value):
                preconditionFailure("Value has been set, but is not of type \(Value.self) or \(Partial<Value>.self): \(value)")
            case .none:
                // Value has been explicitly set to `nil`
                return nil
            }
        } else if let backingValue = backingValue {
            return backingValue[keyPath: keyPath]
        } else {
            throw Error.keyPathNotSet(keyPath)
        }
    }

    public func partialValue<Value>(for keyPath: KeyPath<Wrapped, Value>) -> Partial<Value> {
        if let value = values[keyPath] {
            switch value {
            case .some(let value as Value):
                return Partial<Value>(backingValue: value)
            case .some(let partial as Partial<Value>):
                return partial
            case .some(let value):
                preconditionFailure("Value has been set, but is not of type \(Value.self) or \(Partial<Value>.self): \(value)")
            case .none:
                preconditionFailure("Non-optional value has been set to nil")
            }
        } else if let backingValue = backingValue {
            let value = backingValue[keyPath: keyPath]
            return Partial<Value>(backingValue: value)
        } else {
            return Partial<Value>()
        }
    }

    public func partialValue<Value>(for keyPath: KeyPath<Wrapped, Value?>) -> Partial<Value> {
        if let value = values[keyPath] {
            switch value {
            case .some(let value as Value):
                return Partial<Value>(backingValue: value)
            case .some(let partial as Partial<Value>):
                return partial
            case .some(let value):
                preconditionFailure("Value has been set, but is not of type \(Value.self) or \(Partial<Value>.self): \(value)")
            case .none:
                return Partial<Value>()
            }
        } else if let backingValue = backingValue {
            if let value = backingValue[keyPath: keyPath] {
                return Partial<Value>(backingValue: value)
            } else {
                return Partial<Value>()
            }
        } else {
            return Partial<Value>()
        }
    }

    public mutating func set<Value>(value: Value, for keyPath: KeyPath<Wrapped, Value>) {
        values[keyPath] = value
    }

    public mutating func set<Value>(value: Value?, for keyPath: KeyPath<Wrapped, Value?>) {
        /**
         Uses `updateValue(_:forKey:)` to ensure the value is set to `nil`, rather than
         removed from the dictionary, which would happen if the subscript were used.
         This ensures that the `backingValue`'s value will not be used when
         a `backingValue` is set and a key is explicitly set to `nil`, and also allows
         the `value(for:)` function to get a value of `nil` from the dictionary.
         */
        values.updateValue(value, forKey: keyPath)
    }

    public mutating func set<Value>(value: Partial<Value>, for keyPath: KeyPath<Wrapped, Value>) {
        values[keyPath] = value
    }

    public mutating func set<Value>(value: Partial<Value>, for keyPath: KeyPath<Wrapped, Value?>) {
        values[keyPath] = value
    }

    public mutating func removeValue(for keyPath: PartialKeyPath<Wrapped>) {
        values.removeValue(forKey: keyPath)
    }

}

extension Partial where Wrapped: PartialConvertible {

    public func unwrappedValue() throws -> Wrapped {
        return try Wrapped(partial: self)
    }

}
