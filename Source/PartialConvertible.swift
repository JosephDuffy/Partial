public protocol PartialConvertible {
    
    init(partial: Partial<Self>) throws
    
}
