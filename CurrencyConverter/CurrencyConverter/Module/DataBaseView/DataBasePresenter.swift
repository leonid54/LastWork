import UIKit

protocol IDataBasePresenter {
    func onViewReady()
}

final class DataBasePresenter {
//    private var model = IDataStorage()
    private weak var view: IDataBaseView?

    init(view: IDataBaseView) {
        self.view = view
    }
    
    func onViewReady() {
           self.view?.setupInitialState()
       }
}
