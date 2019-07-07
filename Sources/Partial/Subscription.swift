/// An object that represents a subscription to a `PartialBuilder`. When the object is deallocated the `cancel` function
/// will be called automatically.
public class Subscription: Hashable {

    public static func == (lhs: Subscription, rhs: Subscription) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    typealias CancelAction = (Subscription) -> Void

    private let uuid = UUID()
    private let cancelAction: CancelAction

    init(cancelAction: @escaping CancelAction) {
        self.cancelAction = cancelAction
    }

    deinit {
        cancel()
    }

    /// Cancels the subscription, causing the update subscriber to be removed
    public func cancel() {
        cancelAction(self)
    }

    public func hash(into hasher: inout Hasher) {
        return uuid.hash(into: &hasher)
    }

}
