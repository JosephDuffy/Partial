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

    /// Create a partial that builds on top of the provided value.
    ///
    /// The provided instance will be used to return values that have not been set.
    ///
    /// - Parameter backingValue: An instance of `Wrapped` that will be used to return values that have not been set
    init(backingValue: Wrapped)

    /// Returns the value of the given key path, or throws an error if the value has not been set.
    ///
    /// If a backing value was provided on initialisation this will never throw; if a value has
    /// not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// - Parameter keyPath: A keyPath path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value.
    func value<Value>(for keyPath: KeyPath<Wrapped, Value>) throws -> Value

    /// Returns the value of the given key path, or throws an error if the value has not been set.
    ///
    /// If a backing value was provided on initialisation this will never throw; if a value has
    /// not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value.
    func value<Value>(for keyPath: KeyPath<Wrapped, Value?>) throws -> Value?

    /// Returns the value for the given key path, or `nil` if the value has not been set.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    func value<Value>(for keyPath: KeyPath<Wrapped, Value>) -> Value?

    /// Returns the value of the given key path, or throws an error if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error it will be rethrown by this function.
    ///
    /// If a backing value was provided on initialisation this will never throw; if a value has
    /// not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value.
    func value<Value>(for keyPath: KeyPath<Wrapped, Value>) throws -> Value where Value: PartialConvertible

    /// Returns the value of the given key path, or throws an error if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error it will be rethrown by this function.
    ///
    /// If a backing value was provided on initialisation this will never throw; if a value has
    /// not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value.
    func value<Value>(for keyPath: KeyPath<Wrapped, Value?>) throws -> Value? where Value: PartialConvertible

    /// Returns the value for the given key path, or `nil` if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error this function will return `nil`.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set or could not be unwrapped.
    func value<Value>(for keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible

    /// Returns a `Partial` for the given key path. If the value exists it will be wrapped in a
    /// new `Partial`. If the value has not been set an empty `Partial` will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value wrapped by a `Partial`, or an empty `Partial`.
    func partialValue<Value>(for keyPath: KeyPath<Wrapped, Value>) -> Partial<Value>

    /// Returns a `Partial` for the given key path. If the value exists it will be wrapped in a
    /// new `Partial`. If the value has not been set an empty `Partial` will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value wrapped by a `Partial`, or an empty `Partial`.
    func partialValue<Value>(for keyPath: KeyPath<Wrapped, Value?>) -> Partial<Value>

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

    /// Updates the stored value for the given key path to be a partial value.
    ///
    /// - Parameter value: The partial value to store against `keyPath`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    mutating func setValue<Value>(_ value: Partial<Value>, for keyPath: KeyPath<Wrapped, Value>)

    /// Update the stored value for the given key path to be a partial value.
    ///
    /// - Parameter value: The partial value to store against `keyPath`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    mutating func setValue<Value>(_ value: Partial<Value>, for keyPath: KeyPath<Wrapped, Value?>)

    /// Removes the stored value for the given key path.
    ///
    /// - Parameter keyPath: The key path of the value to remove.
    mutating func removeValue(for keyPath: PartialKeyPath<Wrapped>)

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Value? { get set }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value is set to nil it will remove the value. To explicitly set the
    /// value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Value?? { get set }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error this function will return `nil`.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set or could not be unwrapped.
    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible { get set }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error this function will return `nil`.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value. To explicitly set the
    /// value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set or could not be unwrapped.
    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Value?? where Value: PartialConvertible { get set }

    /// Returns a `Partial` for the given key path. If the value exists it will be wrapped in a
    /// new `Partial`. If the value has not been set an empty `Partial` will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value wrapped by a `Partial`, or an empty `Partial`.
    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup or `value(for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Partial<Value> { get set }

    /// Returns a `Partial` for the given key path. If the value exists it will be wrapped in a
    /// new `Partial`. If the value has not been set an empty `Partial` will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value wrapped by a `Partial`, or an empty `Partial`.
    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup or `value(for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Partial<Value> { get set }

    #if swift(>=5.1)
    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Value? { get set }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value is set to nil it will remove the value. To explicitly set the
    /// value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Value?? { get set }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error this function will return `nil`.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set or could not be unwrapped.
    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible { get set }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error this function will return `nil`.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value. To explicitly set the
    /// value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set or could not be unwrapped.
    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Value?? where Value: PartialConvertible { get set }

    /// Returns a `Partial` for the given key path. If the value exists it will be wrapped in a
    /// new `Partial`. If the value has not been set an empty `Partial` will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value wrapped by a `Partial`, or an empty `Partial`.
    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Partial<Value> { get set }

    /// Returns a `Partial` for the given key path. If the value exists it will be wrapped in a
    /// new `Partial`. If the value has not been set an empty `Partial` will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value wrapped by a `Partial`, or an empty `Partial`.
    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Partial<Value> { get set }
    #endif
}

extension PartialProtocol {

    /// Returns the value for the given key path, or `nil` if the value has not been set.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    public func value<Value>(for keyPath: KeyPath<Wrapped, Value>) -> Value? {
        do {
            let value: Value = try self.value(for: keyPath)
            return value
        } catch {
            return nil
        }
    }

    /// Returns the value for the given key path, or `nil` if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error this function will return `nil`.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set or could not be unwrapped.
    public func value<Value>(for keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
        do {
            let value: Value = try self.value(for: keyPath)
            return value
        } catch {
            return nil
        }
    }

    /// Removes the stored value for the given key path.
    ///
    /// - Parameter keyPath: The key path of the value to remove.
    public mutating func removeValue<Value>(for keyPath: KeyPath<Wrapped, Value>) {
        self.removeValue(for: keyPath as PartialKeyPath<Wrapped>)
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    public subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Value? {
        get {
            return value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                setValue(newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value is set to nil it will remove the value. To explicitly set the
    /// value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    public subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Value?? {
        get {
            return value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                setValue(newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error this function will return `nil`.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set or could not be unwrapped.
    public subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
        get {
            return value(for: keyPath)
        }
        set {
            if let partialValue = newValue {
                setValue(partialValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error this function will return `nil`.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value. To explicitly set the
    /// value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set or could not be unwrapped.
    public subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Value?? where Value: PartialConvertible {
        get {
            return value(for: keyPath)
        }
        set {
            if let partialValue = newValue {
                setValue(partialValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    /// Returns a `Partial` for the given key path. If the value exists it will be wrapped in a
    /// new `Partial`. If the value has not been set an empty `Partial` will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value wrapped by a `Partial`, or an empty `Partial`.
    public subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Partial<Value> {
        get {
            return partialValue(for: keyPath)
        }
        set {
            setValue(newValue, for: keyPath)
        }
    }

    /// Returns a `Partial` for the given key path. If the value exists it will be wrapped in a
    /// new `Partial`. If the value has not been set an empty `Partial` will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value wrapped by a `Partial`, or an empty `Partial`.
    public subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Partial<Value> {
        get {
            return partialValue(for: keyPath)
        }
        set {
            setValue(newValue, for: keyPath)
        }
    }

    /// Do not use this function; dynamic member lookup should only be used with a `KeyPath`, which
    /// requires at least Swift 5.1
    @available(swift, obsoleted: 5.0, message: "Use KeyPath-based dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    public subscript(dynamicMember member: String) -> Never {
        fatalError("Dynamic member lookup requires Swift 5.1")
    }

    #if swift(>=5.1)
    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Value? {
        get {
            return value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                setValue(newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value is set to nil it will remove the value. To explicitly set the
    /// value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set.
    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Value?? {
        get {
            return value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                setValue(newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error this function will return `nil`.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value, or `nil` if a value has not been set or could not be unwrapped.
    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
        get {
            return value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                setValue(newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    /// Retrieve or set a value for the given key path. Returns `nil` if the value has not been set.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If the initialiser throws an error this function will return `nil`.
    ///
    /// If a backing value was provided on initialisation this will never return an optional; if
    /// a value has not been set for `keyPath` the value from the backing value will be returned.
    ///
    /// If the value is set to nil it will remove the value. To explicitly set the
    /// value to `nil` set it to `Optional<Value>.none`.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value, or `nil` if a value has not been set or could not be unwrapped.
    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Value?? where Value: PartialConvertible {
        get {
            return value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                setValue(newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    /// Returns a `Partial` for the given key path. If the value exists it will be wrapped in a
    /// new `Partial`. If the value has not been set an empty `Partial` will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    /// - Returns: The stored value wrapped by a `Partial`, or an empty `Partial`.
    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Partial<Value> {
        get {
            do {
                return try partialValue(for: keyPath)
            } catch {
                return Partial<Value>()
            }
        }
        set {
            setValue(newValue, for: keyPath)
        }
    }

    /// Returns a `Partial` for the given key path. If the value exists it will be wrapped in a
    /// new `Partial`. If the value has not been set an empty `Partial` will be returned.
    ///
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    /// - Returns: The stored value wrapped by a `Partial`, or an empty `Partial`.
    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Partial<Value> {
        get {
            do {
                return try partialValue(for: keyPath)
            } catch {
                return Partial<Value>()
            }
        }
        set {
            setValue(newValue, for: keyPath)
        }
    }
    #endif
}
