extension Partial: CustomDebugStringConvertible {

    public var debugDescription: String {
        if let backingValue = backingValue {
            return debugDescription(utilising: backingValue)
        } else {
            return "<\(type(of: self)) values=\(values.debugDescription); backingValue=\(backingValue.debugDescription))>"
        }
    }

    internal func debugDescription(utilising instance: Wrapped) -> String {
        var namedValues: [String: Any] = [:]
        var unnamedValues: [PartialKeyPath<Wrapped>: Any] = [:]

        let mirror = Mirror(reflecting: instance)
        for (key, value) in self.values {
            var foundKey = false

            for child in mirror.children {
                if let propertyName = child.label {
                    foundKey = (value as AnyObject) === (child.value as AnyObject)

                    if foundKey {
                        namedValues[propertyName] = value
                        break
                    }
                }
            }

            if !foundKey {
                unnamedValues[key] = value
            }
        }

        return "<\(type(of: self)) values=\(namedValues.debugDescription), \(unnamedValues.debugDescription); backingValue=\(backingValue.debugDescription))>"
    }

}

extension Partial where Wrapped: PartialConvertible {

    public var debugDescription: String {
        if let instance = try? Wrapped(partial: self) {
            return debugDescription(utilising: instance)
        } else {
            return "<\(type(of: self)) values=\(values.debugDescription); backingValue=\(backingValue.debugDescription))>"
        }
    }

}
