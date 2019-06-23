extension PartialProtocol {

    /// Updates the stored value for the given key path.
    ///
    /// - Parameter value: The value to store against `keyPath`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    @available(*, deprecated, renamed: "setValue(_:for:)")
    mutating func set<Value>(value: Value, for keyPath: KeyPath<Wrapped, Value>) {
        setValue(value, for: keyPath)
    }

    /// Updates the stored value for the given key path.
    ///
    /// - Parameter value: The value to store against `keyPath`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    @available(*, deprecated, renamed: "setValue(_:for:)")
    mutating func set<Value>(value: Value?, for keyPath: KeyPath<Wrapped, Value?>) {
        setValue(value, for: keyPath)
    }

    /// Updates the stored value for the given key path to be a partial value.
    ///
    /// - Parameter value: The partial value to store against `keyPath`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value`.
    @available(*, deprecated, renamed: "setValue(_:for:)")
    mutating func set<Value>(value: Partial<Value>, for keyPath: KeyPath<Wrapped, Value>) {
        setValue(value, for: keyPath)
    }

    /// Update the stored value for the given key path to be a partial value.
    ///
    /// - Parameter value: The partial value to store against `keyPath`.
    /// - Parameter keyPath: A key path from `Wrapped` to a property of type `Value?`.
    @available(*, deprecated, renamed: "setValue(_:for:)")
    mutating func set<Value>(value: Partial<Value>, for keyPath: KeyPath<Wrapped, Value?>) {
        setValue(value, for: keyPath)
    }

}
