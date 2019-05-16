public class PartialBuilder<Wrapped> {
    
    public var partial: Partial<Wrapped>
    
    public init(partial: Partial<Wrapped> = Partial<Wrapped>()) {
        self.partial = partial
    }
    
    public init(backingValue: Wrapped) {
        partial = Partial(backingValue: backingValue)
    }
    
}

extension PartialBuilder where Wrapped: PartialConvertible {
    
    public func unwrappedValue() throws -> Wrapped {
        return try Wrapped(partial: partial)
    }
    
}
