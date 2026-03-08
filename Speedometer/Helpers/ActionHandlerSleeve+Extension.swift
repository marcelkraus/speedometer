import UIKit

@objc class ActionHandlerSleeve: NSObject {
    let actionHandler: () -> Void

    init(_ actionHandler: @escaping () -> Void) {
        self.actionHandler = actionHandler
    }

    @objc func invoke() {
        actionHandler()
    }
}

extension UIControl {
    func addAction(for event: UIControl.Event = .touchUpInside, actionHandler: @escaping () -> Void) {
        let closureSleeve = ActionHandlerSleeve(actionHandler)

        addTarget(closureSleeve, action: #selector(ActionHandlerSleeve.invoke), for: event)
        objc_setAssociatedObject(self, "[\(arc4random())]", closureSleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
