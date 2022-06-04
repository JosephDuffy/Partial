/// A type that can be initialised with a `Partial` value that wraps itself
public protocol PartialConvertible {

    /// Create a new instance of this type, retrieving values from the partial.
    ///
    /// `Partial` provides convenience functions that throw relevant errors:
    ///
    /// ```
    /// foo = try partial.value(for: \.foo)
    /// ```
    ///
    /// - Parameter partial: The partial to retrieve values from
    init<PartialType: PartialProtocol>(partial: PartialType) throws where PartialType.Wrapped == Self

}

//extension Optional: PartialConvertible where Wrapped: PartialConvertible {
//    public init<PartialType: PartialProtocol>(partial: PartialType) throws where PartialType.Wrapped == Self {
//        do {
//            let optionalWrapper = OptionalPartialWrapper(partial: partial)
//            let unwrappedValue = try Wrapped(partial: optionalWrapper)
//            self = .some(unwrappedValue)
//        } catch let error as OptionalPartialWrapper<Wrapped>.Error {
//            switch error {
//            case .valueIsNil:
//                self = .none
//            case .valueNotSet:
//                throw error
//            }
//        } catch {
//            throw error
//        }
//    }
//}

//private struct OptionalPartialWrapper<Wrapped>: PartialProtocol {
//    mutating func setValue<Value>(_ value: Value, for keyPath: KeyPath<Wrapped, Value>) {
//        fatalError()
//    }
//
//    init() {
//        getValue = { _ in
//            throw Error.valueNotSet
//        }
//    }
//
//    fileprivate enum Error: Swift.Error {
//        case valueIsNil
//        case valueNotSet
//    }
//
//    fileprivate var knownKeys: [PartialKeyPath<Wrapped>: Any] = [:]
//
//    fileprivate var requestedKeys: [PartialKeyPath<Wrapped>] = []
//
//    init<PartialType: PartialProtocol>(
//        partial: PartialType,
//        requestedKeys: [PartialKeyPath<Wrapped>]
//    ) where PartialType.Wrapped == Wrapped? {
//        knownKeys
//    }
//
//    func value<Value>(for keyPath: KeyPath<Wrapped, Value>) throws -> Value {
//        knownKeys[keyPath] as! Value
//    }
//
//    mutating func removeValue<Value>(for keyPath: KeyPath<Wrapped, Value>) {
//        knownKeys.removeValue(forKey: keyPath)
//    }
//}
