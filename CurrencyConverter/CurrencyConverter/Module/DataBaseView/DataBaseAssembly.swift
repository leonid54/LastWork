import UIKit

final class DataBaseAssembly {
    static func makeModule() -> UIViewController {
        let model = DataStorage()
        let router = DataBaseRouter()
        let presenter = DataBasePresenter(model: model, router: router)
        let controller = DataBaseViewController(presenter: presenter)
        
        return controller
    }
}
