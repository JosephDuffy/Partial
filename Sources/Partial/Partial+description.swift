extension Partial: CustomStringConvertible {

    /// A textual representation of the Partial's values. The names of the properties will not be included because they
    /// are not available via key path without reflection, which requires an instance of the type.
    public var description: String {
        return "\(type(of: self))(values: \(String(describing: values)))"
    }

}
