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
        self.dataBasePresenter.loadView(controller: self, view: self.dataBaseView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Conversion info"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.addSubview(dataBaseView as! UIView)
    }
}
