import Partial

struct StringWrapperWrapper: PartialConvertible, Hashable {

    let stringWrapper: StringWrapper
    let optionalStringWrapper: StringWrapper?

    init(stringWrapper: StringWrapper, optionalStringWrapper: StringWrapper?) {
        self.stringWrapper = stringWrapper
        self.optionalStringWrapper = optionalStringWrapper
    }

    init<PartialType: PartialProtocol>(partial: PartialType) throws where PartialType.Wrapped == StringWrapperWrapper {
        stringWrapper = try partial.value(for: \.stringWrapper)
        optionalStringWrapper = try partial.value(for: \.optionalStringWrapper)
    }

}
