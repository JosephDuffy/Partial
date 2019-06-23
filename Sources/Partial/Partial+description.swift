extension Partial: CustomStringConvertible {

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
