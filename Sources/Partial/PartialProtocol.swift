@dynamicMemberLookup
public protocol PartialProtocol {

    associatedtype Wrapped

    /// Initialise an empty partial
    init()

    /// Initialise a partial that builds on top of the provided value. When a value is set it will take
    /// precedence over the value from the backing value
    ///
    /// - Parameter backingValue: An instance of `Wrapped` that values will be retrieved from, unless
    ///                           the value has been set on this partial
    init(backingValue: Wrapped)

    /// Return the value of the given key path, or throws an error if the value is not available
    ///
    /// - Parameter key: The key path for the requested value
    func value<Value>(for keyPath: KeyPath<Wrapped, Value>) throws -> Value

    /// Return the value of the given key path, or throws an error if the value is not available
    ///
    /// - Parameter key: The key path for the requested value
    func value<Value>(for keyPath: KeyPath<Wrapped, Value?>) throws -> Value?

    /// Return the value for the given key path, or `nil` if the value is not available
    ///
    /// - Parameter key: The key path of the requested value
    func value<Value>(for keyPath: KeyPath<Wrapped, Value>) -> Value?

    /// Return the value for the given key path, or an error if the value is not available.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If this unwrapping fails the error will be thrown
    ///
    /// - Parameter key: The key path of the requested value
    func value<Value>(for keyPath: KeyPath<Wrapped, Value>) throws -> Value where Value: PartialConvertible

    /// Return the value for the given key path, or an error if the value is not available.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If this unwrapping fails the error will be thrown
    ///
    /// - Parameter key: The key path of the requested value
    func value<Value>(for keyPath: KeyPath<Wrapped, Value?>) throws -> Value? where Value: PartialConvertible

    /// Return the value for the given key path, or `nil` if the value is not available.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If this unwrapping fails `nil` will be returned
    ///
    /// - Parameter key: The key path of the requested value
    func value<Value>(for keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible

    /// Return a partial value for the given key path. If the value exists it will be wrapped in a new `Partial`
    ///
    /// - Parameter key: The key path of the requested value
    func partialValue<Value>(for keyPath: KeyPath<Wrapped, Value>) -> Partial<Value>

    /// Return a partial value for the given key path. If the value exists it will be wrapped in a new `Partial`
    ///
    /// - Parameter key: The key path of the requested value
    func partialValue<Value>(for keyPath: KeyPath<Wrapped, Value?>) -> Partial<Value>

    /// Update the stored value for the given key path
    ///
    /// - Parameter key: The key path of the value to set
    mutating func set<Value>(value: Value, for keyPath: KeyPath<Wrapped, Value>)

    /// Update the stored value for the given key path
    ///
    /// - Parameter key: The key path of the value to set
    mutating func set<Value>(value: Value?, for keyPath: KeyPath<Wrapped, Value?>)

    /// Update the stored value for the given key path to be a partial value
    ///
    /// - Parameter key: The key path of the value to set
    mutating func set<Value>(value: Partial<Value>, for keyPath: KeyPath<Wrapped, Value>)

    /// Update the stored value for the given key path to be a partial value
    ///
    /// - Parameter key: The key path of the value to set
    mutating func set<Value>(value: Partial<Value>, for keyPath: KeyPath<Wrapped, Value?>)

    /// Remove the stored value for the given key path
    ///
    /// - Parameter keyPath: The key path of the value to remove
    mutating func removeValue(for keyPath: PartialKeyPath<Wrapped>)

    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Value? { get set }

    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Value?? { get set }

    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible { get set }

    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Value?? where Value: PartialConvertible { get set }

    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup or `value(for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Partial<Value> { get set }
    @available(swift, deprecated: 5.1, message: "Use dynamic member lookup or `value(for:)`")
    subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Partial<Value> { get set }

    #if swift(>=5.1)
    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Value? { get set }

    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Value?? { get set }

    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible { get set }

    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Value?? where Value: PartialConvertible { get set }

    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Partial<Value> { get set }

    subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Partial<Value> { get set }
    #endif
}

extension PartialProtocol {

    public func value<Value>(for keyPath: KeyPath<Wrapped, Value>) -> Value? {
        do {
            let value: Value = try self.value(for: keyPath)
            return value
        } catch {
            return nil
        }
    }

    public func value<Value>(for keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
        do {
            let value: Value = try self.value(for: keyPath)
            return value
        } catch {
            return nil
        }
    }

    public mutating func removeValue<Value>(for keyPath: KeyPath<Wrapped, Value>) {
        self.removeValue(for: keyPath as PartialKeyPath<Wrapped>)
    }

    public subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Value? {
        get {
            return value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                set(value: newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    public subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Value?? {
        get {
            return value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                set(value: newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    public subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
        get {
            return value(for: keyPath)
        }
        set {
            if let partialValue = newValue {
                set(value: partialValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    public subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Value?? where Value: PartialConvertible {
        get {
            return value(for: keyPath)
        }
        set {
            if let partialValue = newValue {
                set(value: partialValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    public subscript<Value>(keyPath: KeyPath<Wrapped, Value>) -> Partial<Value> {
        get {
            return partialValue(for: keyPath)
        }
        set {
            set(value: newValue, for: keyPath)
        }
    }

    public subscript<Value>(keyPath: KeyPath<Wrapped, Value?>) -> Partial<Value> {
        get {
            return partialValue(for: keyPath)
        }
        set {
            set(value: newValue, for: keyPath)
        }
    }

    @available(swift, obsoleted: 5.0, message: "Use KeyPath-based dynamic member lookup, `value(for:)`, or `set(value:for:)`")
    public subscript(dynamicMember member: String) -> Never {
        fatalError("Dynamic member lookup requires Swift 5.1")
    }

    #if swift(>=5.1)
    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Value? {
        get {
            return value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                set(value: newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Value?? {
        get {
            return value(for: keyPath)
        }
        set {
            switch newValue {
            case .none:
                removeValue(for: keyPath)
            case .some(let value):
                set(value: value, for: keyPath)
            }
        }
    }

    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
        get {
            return value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                set(value: newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Value?? where Value: PartialConvertible {
        get {
            return value(for: keyPath)
        }
        set {
            if let newValue = newValue {
                set(value: newValue, for: keyPath)
            } else {
                removeValue(for: keyPath)
            }
        }
    }

    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value>) -> Partial<Value> {
        get {
            do {
                return try partialValue(for: keyPath)
            } catch {
                return Partial<Value>()
            }
        }
        set {
            set(value: newValue, for: keyPath)
        }
    }

    public subscript<Value>(dynamicMember keyPath: KeyPath<Wrapped, Value?>) -> Partial<Value> {
        get {
            do {
                return try partialValue(for: keyPath)
            } catch {
                return Partial<Value>()
            }
        }
        set {
            set(value: newValue, for: keyPath)
        }
    }
    #endif
}
