import UIKit

protocol IDataBasePresenter {
    func loadView(controller: DataBaseViewController, view: IDataBaseView)
}

final class DataBasePresenter {
    private var model = DataStorage()
    private weak var controller: DataBaseViewController?
    private let router: DataBaseRouter
    private weak var view: IDataBaseView?
    
    init(model: DataStorage, router: DataBaseRouter) {
        self.model = model
        self.router = router
    }
}

extension DataBasePresenter: IDataBasePresenter {
    func loadView(controller: DataBaseViewController, view: IDataBaseView) {
        self.controller = controller
        self.view = view
        self.view?.setData(model: model)
    }
}
