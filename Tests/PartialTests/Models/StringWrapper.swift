import Partial

struct StringWrapper: PartialConvertible, Hashable, ExpressibleByStringLiteral {

    let string: String

    init(stringLiteral value: String) {
        self.string = value
    }

    init<PartialType: PartialProtocol>(partial: PartialType) throws where PartialType.Wrapped == StringWrapper {
        string = try partial.value(for: \.string)
    }
}
