extension Partial: CustomStringConvertible {

    public var description: String {
        let backingValueDescription: String

        if let backingValue = backingValue as? CustomStringConvertible {
            backingValueDescription = backingValue.description
        } else {
            backingValueDescription = String(describing: backingValue)
        }

        return "<\(type(of: self)) values=\(values.description); backingValue=\(backingValueDescription)>"
    }

}
