extension Partial: CustomDebugStringConvertible {

    public var debugDescription: String {
        if let backingValue = backingValue {
            return debugDescription(utilising: backingValue)
        } else {
            return String(describing: self)
        }
    }

    internal func debugDescription(utilising instance: Wrapped) -> String {
        var namedValues: [String: Any] = [:]
        var unnamedValues: [PartialKeyPath<Wrapped>: Any] = [:]

        let mirror = Mirror(reflecting: instance)
        valuesLoop: for (key, value) in self.values {
            for child in mirror.children {
                guard let propertyName = child.label else { continue }
                guard (value as AnyObject) === (child.value as AnyObject) else { continue }

                namedValues[propertyName] = value
                break valuesLoop
            }

            unnamedValues[key] = value
        }

        return "\(type(of: self))(values: \(namedValues) + \(unnamedValues), backingValue: \(instance))"
    }

}

extension Partial where Wrapped: PartialConvertible {

    public var debugDescription: String {
        if let instance = try? Wrapped(partial: self) {
            return debugDescription(utilising: instance)
        } else if let backingValue = backingValue {
            return debugDescription(utilising: backingValue)
        } else {
            return String(describing: self)
        }
    }

}
