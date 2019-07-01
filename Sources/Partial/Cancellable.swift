public class Cancellable {

    typealias CancelAction = (Cancellable) -> Void

    private let cancelAction: CancelAction

    init(cancelAction: @escaping (Cancellable) -> Void) {
        self.cancelAction = cancelAction
    }

    deinit {
        cancel()
    }

    public func cancel() {
        cancelAction(self)
    }

}
