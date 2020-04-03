/// The protocol that `Partial` and `PartialBuilder` implement.
/// It is not provided for consumers of Partial to implement this protocol; it is
/// provided to ensure the API of `Partial` and `PartialBuilder` are identical, and
/// to provide default implementations.
@dynamicMemberLookup
public protocol PartialProtocol {

    /// The type the partial will mirror the properties of.
    associatedtype Wrapped

    /// Create an empty partial.
    init()

    /// Returns the value of the given key path, or throws an error if the value has not been set.
    ///
    /// - Parameter keyPath: A keyPath path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value.
    func value<Value>(for keyPath: KeyPath<Wrapped, Value>) throws -> Value

    /// Updates the stored value for the given key path.
    ///
    /// - Parameter value: The value to store against `keyPath`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    mutating func setValue<Value>(_ value: Value, for keyPath: KeyPath<Wrapped, Value>)

    /// Removes the stored value for the given key path.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    mutating func removeValue<Value>(for keyPath: KeyPath<Wrapped, Value>)

}

extension PartialProtocol {

    /// Attempts to update the stored value for the given key path by unwrapping the provided partial value. If the
    /// unwrapping fails the error will be thrown.
    ///
    /// - Parameter partial: A partial wrapping a value of type `Value`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Parameter unwrapper: A closure that will be called to unwrap the passed partial.
    mutating func setValue<Value, PartialType>(
        _ partial: PartialType,
        for keyPath: KeyPath<Wrapped, Value>,
        unwrapper: (_ partial: PartialType) throws -> Value
    ) rethrows where PartialType: PartialProtocol, PartialType.Wrapped == Value {
        let value = try unwrapper(partial)
        setValue(value, for: keyPath)
    }

    /// Attempts to update the stored value for the given key path by unwrapping the provided partial value. If the
    /// unwrapping fails the error will be thrown.
    ///
    /// - Parameter partial: A partial wrapping a value of type `Value`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Parameter unwrapper: A closure that will be called to unwrap the passed partial.
    mutating func setValue<Value, PartialType>(
        _ partial: PartialType,
        for keyPath: KeyPath<Wrapped, Value?>,
        unwrapper: (_ partial: PartialType) throws -> Value
    ) rethrows where PartialType: PartialProtocol, PartialType.Wrapped == Value {
        let value = try unwrapper(partial)
        setValue(value, for: keyPath)
    }

    /// Attempts to update the stored value for the given key path by unwrapping the provided partial value. If the
    /// unwrapping fails the error will be thrown.
    ///
    /// - Parameter partial: A partial wrapping a value of type `Value`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Parameter unwrapper: A closure that will be called to unwrap the passed partial. Defaults to the
    ///                        `init(partial:)` function of `Value`
    mutating func setValue<Value, PartialType>(
        _ partial: PartialType,
        for keyPath: KeyPath<Wrapped, Value>,
        customUnwrapper unwrapper: (_ partial: PartialType) throws -> Value = Value.init(partial:)
    ) rethrows where PartialType: PartialProtocol, PartialType.Wrapped == Value, PartialType.Wrapped: PartialConvertible {
        try setValue(partial, for: keyPath, unwrapper: unwrapper)
    }

    /// Attempts to update the stored value for the given key path by unwrapping the provided partial value. If the
    /// unwrapping fails the error will be thrown.
    ///
    /// - Parameter partial: A partial wrapping a value of type `Value`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Parameter unwrapper: A closure that will be called to unwrap the passed partial. Defaults to the
    ///                        `init(partial:)` function of `Value`
    mutating func setValue<Value, PartialType>(
        _ partial: PartialType,
        for keyPath: KeyPath<Wrapped, Value?>,
        customUnwrapper unwrapper: (_ partial: PartialType) throws -> Value = Value.init(partial:)
    ) rethrows where PartialType: PartialProtocol, PartialType.Wrapped == Value, PartialType.Wrapped: PartialConvertible {
        try setValue(partial, for: keyPath, unwrapper: unwrapper)
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set. If the value is set
    /// to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    public subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Value? {
        get {
            return try? self.value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                setValue(newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    /// Do not use this function; dynamic member lookup should only be used with a `KeyPath`, which
    /// requires at least Swift 5.1
    public subscript(dynamicMember member: String) -> Never {
        fatalError("Dynamic member lookup requires Swift 5.1")
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set. If the value is set
    /// to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Value? {
        get {
            return try? self.value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                setValue(newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

}

extension PartialProtocol where Wrapped: PartialConvertible {

    /// Attempts to initialise a new `Wrapped` with self
    ///
    /// Any errors thrown by `Wrapped.init(partial:)` will be rethrown
    ///
    /// - Returns: The new `Wrapped` instance
    public func unwrapped() throws -> Wrapped {
        return try Wrapped(partial: self)
    }

}
