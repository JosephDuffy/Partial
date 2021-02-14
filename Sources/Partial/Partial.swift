import Foundation

/// A struct that mirrors the properties of `Wrapped`, making each of the
/// types optional.
public struct Partial<Wrapped>: PartialProtocol, CustomStringConvertible {
    /// An error that can be thrown by the `value(for:)` function.
    public enum Error<Value>: Swift.Error {
        /// The key path has not been set.
        case keyPathNotSet(KeyPath<Wrapped, Value>)

        /// A value has been set to an unexpected type.
        ///
        /// - parameter value: The set value.
        /// - parameter keyPath: The key path the value was set against.
        case invalidType(value: Any, keyPath: KeyPath<Wrapped, Value>)
    }

    /// A textual representation of the Partial's values.
    public var description: String {
        return "\(type(of: self))(values: \(String(describing: values)))"
    }

    /// The values that have been set.
    fileprivate var values: [PartialKeyPath<Wrapped>: Any] = [:]

    /// Create an empty `Partial`.
    public init() {}

    /// Returns the value of the given key path, or throws an error if the value has not been set.
    ///
    /// - Parameter keyPath: A keyPath path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value.
    public func value<Value>(for keyPath: KeyPath<Wrapped, Value>) throws -> Value {
        guard let value = values[keyPath] else {
            throw Error.keyPathNotSet(keyPath)
        }

        if let value = value as? Value {
            return value
        }

        throw Error.invalidType(value: value, keyPath: keyPath)
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

extension Partial: Codable where Wrapped: PartialCodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Wrapped.CodingKey.self)
        let collection = Wrapped.keyPathCodingKeyCollection
        values = try container
            .allKeys
            .reduce(into: [PartialKeyPath<Wrapped>: Any](), { values, codingKey in
                guard let (value, keyPath) = try collection.decode(codingKey, in: container) else { return }
                values[keyPath] = value
            })
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Wrapped.CodingKey.self)

        let collection = Wrapped.keyPathCodingKeyCollection

        try values.forEach { pair in
            let (keyPath, value) = pair

            try collection.encode(value, forKey: keyPath, to: &container)
        }
    }
}
