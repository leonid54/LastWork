import UIKit
import SnapKit

protocol IConvertView: AnyObject {
    func setupInitialState()
    func getConvert()
    func refreshPickView()
}

final class ConvertView: UIViewController {
    private lazy var presenter: IConvertPresenter = {
           return ConvertPresenter(view: self)
       }()
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let convertTextField = UITextField()
    private let convertButton = UIButton()
    private let atPickView = UIPickerView()
    private let toPickView = UIPickerView()
    private let convertLabel = UILabel()
    var currency:[String] = []
    var values:[Double] = []
    var activeCurrency: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configure()
        self.presenter.onViewReady()
    }
}

private extension ConvertView {
    
    private func configure() {
        self.setConfig()
        self.addSubviews()
        self.setConstraint()
        self.addDelegate()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.convertTextField)
        self.contentView.addSubview(self.convertButton)
        self.contentView.addSubview(self.atPickView)
        self.contentView.addSubview(self.toPickView)
        self.contentView.addSubview(self.convertLabel)
    }
    
    private func addDelegate() {
        self.atPickView.dataSource = self
        self.atPickView.delegate = self
        self.toPickView.dataSource = self
        self.toPickView.delegate = self
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
        
        self.atPickView.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertButton.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalTo(self.toPickView.snp.left)
        }
        
        self.toPickView.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertButton.snp.bottom).offset(20)
            make.left.equalTo(self.atPickView.snp.right)
            make.right.equalToSuperview()
        }
        
        self.convertLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.toPickView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
}

extension ConvertView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.currency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.activeCurrency = self.values[row]
    }
}

extension ConvertView: UIPickerViewDelegate {
    
}

extension ConvertView: IConvertView {
    func refreshPickView() {
        self.atPickView.reloadAllComponents()
        self.toPickView.reloadAllComponents()
    }
    
    @objc func getConvert() {
        if self.convertTextField.text != "" {
            self.convertLabel.text = String(Double(self.convertTextField.text!)! * self.activeCurrency)
        }
    }
    
    func setupInitialState() {
        self.title = "Currency Converter"
    }
}
