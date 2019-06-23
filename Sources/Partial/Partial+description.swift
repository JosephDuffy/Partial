extension Partial: CustomStringConvertible {

    /// A textual representation of the Partial's values and backing value. The
    /// names of the properties will not be included because they are not available
    /// via KeyPaths without reflection.
    ///
    /// If this partial has a backing value the `debugDescription` property can be
    /// used to print the names of the properties
    public var description: String {
        let backingValueDescription: String

        if let backingValue = backingValue as? CustomStringConvertible {
            backingValueDescription = String(describing: backingValue)
        } else {
            backingValueDescription = String(describing: backingValue)
        }

        return "\(type(of: self))(values: \(String(describing: values)), backingValue: \(backingValueDescription))"
    }

}
