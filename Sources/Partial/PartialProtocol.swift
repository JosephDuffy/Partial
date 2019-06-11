public protocol PartialProtocol {

    associatedtype Wrapped

    /// Return the value of the given key path, or throws an error if the value is not available
    ///
    /// - Parameter key: The key path for the requested value
    func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value

    /// Return the value of the given key path, or throws an error if the value is not available
    ///
    /// - Parameter key: The key path for the requested value
    func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value?

    /// Return the value for the given key path, or `nil` if the value is not available
    ///
    /// - Parameter key: The key path of the requested value
    func value<Value>(for key: KeyPath<Wrapped, Value>) -> Value?

    /// Return the value for the given key path, or an error if the value is not available.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If this unwrapping fails the error will be thrown
    ///
    /// - Parameter key: The key path of the requested value
    func value<Value>(for key: KeyPath<Wrapped, Value>) throws -> Value where Value: PartialConvertible

    /// Return the value for the given key path, or an error if the value is not available.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If this unwrapping fails the error will be thrown
    ///
    /// - Parameter key: The key path of the requested value
    func value<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Value? where Value: PartialConvertible

    /// Return the value for the given key path, or `nil` if the value is not available.
    ///
    /// If the value stored for this key path is a `Partial` an attempt will be made to unwrap
    /// the value. If this unwrapping fails `nil` will be returned
    ///
    /// - Parameter key: The key path of the requested value
    func value<Value>(for key: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible

    /// Return a partial value for the given key path. If the value exists it will be wrapped in a new `Partial`
    ///
    /// - Parameter key: The key path of the requested value
    func partialValue<Value>(for key: KeyPath<Wrapped, Value>) throws -> Partial<Value>

    /// Return a partial value for the given key path. If the value exists it will be wrapped in a new `Partial`
    ///
    /// - Parameter key: The key path of the requested value
    func partialValue<Value>(for key: KeyPath<Wrapped, Value?>) throws -> Partial<Value>

    /// Update the stored value for the given key path
    ///
    /// - Parameter key: The key path of the value to set
    mutating func set<Value>(value: Value, for key: KeyPath<Wrapped, Value>)

    /// Update the stored value for the given key path
    ///
    /// - Parameter key: The key path of the value to set
    mutating func set<Value>(value: Value?, for key: KeyPath<Wrapped, Value?>)

    /// Update the stored value for the given key path to be a partial value
    ///
    /// - Parameter key: The key path of the value to set
    mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value>) where Value: PartialConvertible

    /// Update the stored value for the given key path to be a partial value
    ///
    /// - Parameter key: The key path of the value to set
    mutating func set<Value>(value: Partial<Value>, for key: KeyPath<Wrapped, Value?>) where Value: PartialConvertible

    /// Remove the stored value for the given key path
    ///
    /// - Parameter key: The key path of the value to remove
    mutating func removeValue(for key: PartialKeyPath<Wrapped>)

    subscript<Value>(key: KeyPath<Wrapped, Value>) -> Value? { get set }

    subscript<Value>(key: KeyPath<Wrapped, Value>) -> Partial<Value> { get }

    subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Partial<Value> { get }

    subscript<Value>(key: KeyPath<Wrapped, Value>) -> Partial<Value> where Value: PartialConvertible { get set }

    subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Partial<Value> where Value: PartialConvertible { get set }

    subscript<Value>(key: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible { get set }

}

extension PartialProtocol {

    public func value<Value>(for key: KeyPath<Wrapped, Value>) -> Value? {
        do {
            let value: Value = try self.value(for: key)
            return value
        } catch {
            return nil
        }
    }

    public func value<Value>(for key: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
        do {
            let value: Value = try self.value(for: key)
            return value
        } catch {
            return nil
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Value? {
        get {
            return value(for: key)
        }
        set {
            if let newValue = newValue {
                set(value: newValue, for: key)
            } else {
                removeValue(for: key)
            }
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Partial<Value> where Value: PartialConvertible {
        get {
            do {
                return try partialValue(for: key)
            } catch {
                return Partial<Value>()
            }
        }
        set {
            set(value: newValue, for: key)
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Partial<Value> where Value: PartialConvertible {
        get {
            do {
                return try partialValue(for: key)
            } catch {
                return Partial<Value>()
            }
        }
        set {
            set(value: newValue, for: key)
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Partial<Value> {
        do {
            return try partialValue(for: key)
        } catch {
            return Partial<Value>()
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value?>) -> Partial<Value> {
        do {
            return try partialValue(for: key)
        } catch {
            return Partial<Value>()
        }
    }

    public subscript<Value>(key: KeyPath<Wrapped, Value>) -> Value? where Value: PartialConvertible {
        get {
            return value(for: key)
        }
        set {
            if let partialValue = newValue {
                set(value: partialValue, for: key)
            } else {
                removeValue(for: key)
            }
        }
    }

}
