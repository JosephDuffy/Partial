import Partial

struct StringWrapper: PartialConvertible, Hashable, ExpressibleByStringLiteral {
    let string: String

    init(stringLiteral value: String) {
        self.string = value
    }

    init(partial: Partial<StringWrapper>) throws {
        string = try partial.value(for: \.string)
    }
}
