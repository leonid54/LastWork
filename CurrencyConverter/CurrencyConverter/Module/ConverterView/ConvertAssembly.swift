import UIKit

final class ConvertAssembly {
    static func makeModule() -> UIViewController {
        let router = ConvertRouter()
        
        let presenter = ConvertPresenter(router: router)
        let controller = ConvertViewController(presenter: presenter)
        
        router.setRootController(controller: controller)
        
        return controller
    }
}
