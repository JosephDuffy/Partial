internal final class Weak<Wrapped :AnyObject> {
    private(set) weak var wrapped: Wrapped?

    init(_ wrapped: Wrapped) {
        self.wrapped = wrapped
    }
}

extension Weak: Equatable where Wrapped: Equatable {
    static func == (lhs: Weak<Wrapped>, rhs: Weak<Wrapped>) -> Bool {
        return lhs.wrapped == rhs.wrapped
    }
}

extension Weak: Hashable where Wrapped: Hashable {
    func hash(into hasher: inout Hasher) {
        wrapped.hash(into: &hasher)
    }
}
