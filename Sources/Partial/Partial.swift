import Foundation

/// A struct that mirrors the properties of `Wrapped`, making each of the
/// types optional.
public struct Partial<Wrapped>: PartialProtocol, CustomStringConvertible {

    /// An error that can be thrown by the `value(for:)` function.
    public enum Error<Value>: Swift.Error {
        /// The key path has not been set.
        case keyPathNotSet(KeyPath<Wrapped, Value>)
    }

    /// A textual representation of the Partial's values.
    public var description: String {
        return "\(type(of: self))(values: \(String(describing: values)))"
    }

    /// The values that have been set.
    private var values: [PartialKeyPath<Wrapped>: Any] = [:]

    /// Create an empty `Partial`.
    public init() {}

    /// Returns the value of the given key path, or throws an error if the value has not been set.
    ///
    /// - Parameter keyPath: A keyPath path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value.
    public func value<Value>(for keyPath: KeyPath<Wrapped, Value>) throws -> Value {
        if let value = values[keyPath] {
            if let value = value as? Value {
                return value
            } else {
                preconditionFailure("Value has been set, but is not of type \(Value.self): \(value)")
            }
        } else {
            throw Error.keyPathNotSet(keyPath)
        }
    }

    /// Updates the stored value for the given key path.
    ///
    /// - Parameter value: The value to store against `keyPath`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    public mutating func setValue<Value>(_ value: Value, for keyPath: KeyPath<Wrapped, Value>) {
        values[keyPath] = value
    }

    /// Removes the stored value for the given key path.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    public mutating func removeValue<Value>(for keyPath: KeyPath<Wrapped, Value>) {
        values.removeValue(forKey: keyPath)
    }

}

extension Partial where Wrapped: PartialConvertible {

    /// Attempts to initialise a new `Wrapped` with self
    ///
    /// Any errors thrown by `Wrapped.init(partial:)` will be rethrown
    ///
    /// - Returns: The new `Wrapped` instance
    public func unwrappedValue() throws -> Wrapped {
        return try Wrapped(partial: self)
    }

}
