import UIKit

final class DataBaseViewController: UIViewController {
    private var dataBaseView: IDataBaseView
    private var dataBasePresenter: IDataBasePresenter
    
    init(presenter: IDataBasePresenter) {
        self.dataBaseView = DataBaseView(frame: UIScreen.main.bounds)
        self.dataBasePresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.dataBaseView as! UIView
        self.dataBasePresenter.loadView(controller: self, view: self.dataBaseView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = l10n("BASE_VIEW_CONTROLLER_TITLE")
    }
}
