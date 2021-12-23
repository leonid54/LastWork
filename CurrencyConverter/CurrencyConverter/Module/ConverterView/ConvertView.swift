import UIKit
import SnapKit

protocol IConvertView: AnyObject {
    func setupInitialState()
    func getConvert()
    func refreshPickView()
    func setCurrency()
}

final class ConvertView: UIViewController {
    private lazy var presenter: IConvertPresenter = {
           return ConvertPresenter(view: self)
       }()
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let convertTextField = UITextField()
    private let convertButton = UIButton()
    private let basePickerView = BasePickerView()
    private let convertPickerView = ConvertPickerView()
    private let convertLabel = UILabel()
    var onTouchHandler: ((String) -> Void)?
    static var currencies: [String: Double] = [:]
    static var currency:[String] = [] // возможно вынести в отдельный файл
    static var values:[Double] = [] // возможно вынести в отдельный файл
    static var activeCurrency: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configure()
        self.basePickerView.onSelectedCurrency = { [weak self] model in
            self?.onTouchHandler?(model)
        }
        self.presenter.onViewReady()
    }
}

private extension ConvertView {
    
    private func configure() {
        self.setConfig()
        self.addSubviews()
        self.setConstraint()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.convertTextField)
        self.contentView.addSubview(self.convertButton)
        self.contentView.addSubview(self.basePickerView)
        self.contentView.addSubview(self.convertPickerView)
        self.contentView.addSubview(self.convertLabel)
    }
    
    private func setConfig() {
        self.convertTextField.placeholder = "Currency"
        
        self.convertButton.setTitle("Convert", for: .normal)
        self.convertButton.addTarget(self, action: #selector(self.getConvert), for: .touchDown)
        self.convertButton.backgroundColor = .blue
        self.convertLabel.text = "0"
    }
    
    private func setConstraint() {
        
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        self.convertTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.convertButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertTextField.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.basePickerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertButton.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalTo(self.convertPickerView.snp.left)
        }
        
        self.convertPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertButton.snp.bottom).offset(20)
            make.left.equalTo(self.basePickerView.snp.right)
            make.right.equalToSuperview()
        }
        
        self.convertLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertPickerView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
}

extension ConvertView: IConvertView {
    func setCurrency() {
        ConvertView.currency.removeAll()
        ConvertView.values.removeAll()
        for (key, value) in ConvertView.currencies {
            ConvertView.currency.append(key)
            ConvertView.values.append(value)
        }
    }
    
    func refreshPickView() {
        self.basePickerView.pickerView.reloadAllComponents() // исправить
        self.convertPickerView.pickerView.reloadAllComponents() // исправить
    }
    
    @objc func getConvert() {
        if self.convertTextField.text != "" {
            self.convertLabel.text = String(Double(self.convertTextField.text!)! * ConvertView.activeCurrency)
        }
    }
    
    func setupInitialState() {
        self.title = "Currency Converter"
    }
}
