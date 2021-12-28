import UIKit

final class ConvertViewController: UIViewController {
    private var convertView: IConvertView
    private var convertPresenter: IConvertPresenter
    
    init(presenter: IConvertPresenter) {
        self.convertView = ConvertView(frame: UIScreen.main.bounds)
        self.convertPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.convertView as! UIView
        self.convertPresenter.loadView(controller: self, view: self.convertView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = l10n("CONVERT_VIEW_CONTROLLER_TITLE")
        self.navigationController?.navigationBar.tintColor = Colors.defaultRedColor
        self.navigationItem.backButtonTitle = l10n("CONVERT_VIEW_CONTROLLER_BACK_BUTTON")
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
