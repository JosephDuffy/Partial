import Nimble

/// A Nimble matcher that succeeds when the actual value is nil wrapped in an optional.
public func beNilWrappedInOptional<T>() -> Predicate<T?> {
    return Predicate.simpleNilable("be nil wrapped in an optional") { actualExpression in
        let actualValue = try actualExpression.evaluate()
        switch actualValue {
        case .some(let value):
            return PredicateStatus(bool: value == nil)
        case .none:
            return PredicateStatus(bool: false)
        }
    }
}
