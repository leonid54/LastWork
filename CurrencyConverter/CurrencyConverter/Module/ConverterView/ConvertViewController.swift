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
        self.convertPresenter.loadView(controller: self, view: self.convertView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currency Converter"
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.929, green: 0.098, blue: 0.192, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.addSubview(convertView as! UIView)
    }
}
