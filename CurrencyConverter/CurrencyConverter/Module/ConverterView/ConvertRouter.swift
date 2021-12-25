import UIKit

final class ConvertRouter {
    private var controller: ConvertViewController?
    private var targertController: DataBaseViewController?
    
    func setRootController(controller: ConvertViewController) {
           self.controller = controller
       }

    func setTargetController(controller: DataBaseViewController) {
        self.targertController = controller
    }

    func next() {
        self.setTargetController(controller: DataBaseAssembly.makeModule() as! DataBaseViewController)
        guard let targertController = self.targertController else {
            return
        }
        self.controller?.navigationController?.pushViewController(targertController, animated: true)
    }
}
