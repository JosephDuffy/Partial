class PartialBuilder<Wrapped> {
    
    var partial: Partial<Wrapped>
    
    init(partial: Partial<Wrapped> = Partial<Wrapped>()) {
        self.partial = partial
    }
    
    init(backingValue: Wrapped) {
        partial = Partial(backingValue: backingValue)
    }
    
}

extension PartialBuilder where Wrapped: PartialConvertible {
    
    func unwrappedValue() throws -> Wrapped {
        return try Wrapped(partial: partial)
    }
    
}
