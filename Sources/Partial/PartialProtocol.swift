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

    /// Returns the value of the given key path, or throws an error if the value has not been set.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value.
    func value<Value>(for keyPath: KeyPath<Wrapped, Value?>) throws -> Value?

    /// Updates the stored value for the given key path.
    ///
    /// - Parameter value: The value to store against `keyPath`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    mutating func setValue<Value>(_ value: Value, for keyPath: KeyPath<Wrapped, Value>)

    /// Updates the stored value for the given key path.
    ///
    /// - Parameter value: The value to store against `keyPath`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    mutating func setValue<Value>(_ value: Value?, for keyPath: KeyPath<Wrapped, Value?>)

    /// Removes the stored value for the given key path.
    ///
    /// - Parameter keyPath: The key path of the value to remove.
    mutating func removeValue(for keyPath: PartialKeyPath<Wrapped>)
}

extension PartialProtocol {

    /// Removes the stored value for the given key path.
    ///
    /// - Parameter keyPath: The key path of the value to remove.
    public mutating func removeValue<Value>(for keyPath: KeyPath<Wrapped, Value>) {
        self.removeValue(for: keyPath as PartialKeyPath<Wrapped>)
    }

    /// Attempts to update the stored value for the given key path by unwrapping the
    /// provided partial value. If the unwrapping fails the error will be thrown.
    ///
    /// - Parameter value: A partial wrapping a value of type `Value`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    mutating func setValue<Value>(_ partial: Partial<Value>, for keyPath: KeyPath<Wrapped, Value>) throws where Value: PartialConvertible {
        let value = try partial.unwrappedValue()
        setValue(value, for: keyPath)
    }

    /// Attempts to update the stored value for the given key path by unwrapping the
    /// provided partial value. If the unwrapping fails the error will be thrown.
    ///
    /// - Parameter value: A partial wrapping a value of type `Value`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    mutating func setValue<Value>(_ partial: Partial<Value>, for keyPath: KeyPath<Wrapped, Value?>) throws where Value: PartialConvertible {
        let value = try partial.unwrappedValue()
        setValue(value, for: keyPath)
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set. If the value is set
    /// to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
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

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set. If the value is set
    /// to nil it will remove the value. To set the value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    public subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Value?? {
        get {
            do {
                let value: Value? = try self.value(for: keyPath)
                return value
            } catch {
                return nil
            }
        }
        set {
            if let newValue = newValue {
                setValue(newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set. If the value is set
    /// to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    public subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
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

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set. If the value is set
    /// to nil it will remove the value. To set the value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    public subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Value?? where Value: PartialConvertible {
        get {
            do {
                let value: Value? = try self.value(for: keyPath)
                return value
            } catch {
                return nil
            }
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
    @available(swift, obsoleted: 5.0, message: "Use KeyPath-based dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    public subscript(dynamicMember member: String) -> Never {
        fatalError("Dynamic member lookup requires Swift 5.1")
    }

    #if swift(>=5.1)
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
    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set. If the value is set
    /// to nil it will remove the value. To set the value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Value?? {
        get {
            do {
                let value: Value? = try self.value(for: keyPath)
                return value
            } catch {
                return nil
            }
        }
        set {
            if let newValue = newValue {
                setValue(newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set. If the value is set
    /// to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
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

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set. If the value is set
    /// to nil it will remove the value. To set the value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Value?? where Value: PartialConvertible {
        get {
            do {
                let value: Value? = try self.value(for: keyPath)
                return value
            } catch {
                return nil
            }
        }
        set {
            if let newValue = newValue {
                setValue(newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }
    #endif
}
