import UIKit
import SnapKit

protocol IConvertView: AnyObject {
    func getConvert()
    func refreshPickView()
    func setCurrency(model: DataArray)
    func getInfo()
    var onTouchHandler: ((String) -> Void)? { get set }
    var onInfoButtonHandler: (() -> Void)? { get set }
}

final class ConvertView: UIView {
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let convertTextField = UITextField()
    private let convertButton = UIButton()
    private let conversionInfoButton = UIButton()
    private let basePickerView = BasePickerView()
    private let convertPickerView = ConvertPickerView()
    private let convertLabel = UILabel()
    private let toLabel = UILabel()
    private let resultLabel = UILabel()
    private let lineView = UIView()
    private let baseСurrencyLabel = UILabel()
    private let conversionСurrencyLabel = UILabel()
    var onTouchHandler: ((String) -> Void)?
    var onInfoButtonHandler: (() -> Void)?
    private var baseModel: String?
    private var convertModel: String?
    private var viewModel: DataArray?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.convertPickerView.onConvertCurrency = { [weak self] model in
            self?.convertModel = model
        }
        self.basePickerView.onBaseCurrency = { [weak self] model in
            self?.baseModel = model
        }
        self.basePickerView.onSelectedCurrency = { [weak self] model in
            self?.onTouchHandler?(model)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ConvertView {
    
    private func configure() {
        self.setConfig()
        self.addSubviews()
        self.setConstraint()
        self.setDelegate()
    }
    
    private func setDelegate() {
        self.convertTextField.delegate = self
    }
    
    private func addSubviews() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.convertTextField)
        self.contentView.addSubview(self.convertButton)
        self.contentView.addSubview(self.basePickerView)
        self.contentView.addSubview(self.convertPickerView)
        self.contentView.addSubview(self.convertLabel)
        self.contentView.addSubview(self.baseСurrencyLabel)
        self.contentView.addSubview(self.conversionСurrencyLabel)
        self.contentView.addSubview(self.toLabel)
        self.contentView.addSubview(self.resultLabel)
        self.contentView.addSubview(self.conversionInfoButton)
        self.contentView.addSubview(self.lineView)
    }
    
    private func setConfig() {
        self.backgroundColor = .white
        
        self.convertTextField.placeholder = "Number"
        self.convertTextField.borderStyle = .roundedRect
                
        self.convertButton.setTitle("Convert", for: .normal)
        self.convertButton.addTarget(self, action: #selector(self.getConvert), for: .touchDown)
        self.convertButton.backgroundColor = UIColor(red: 0.929, green: 0.098, blue: 0.192, alpha: 1)
        self.convertButton.layer.cornerRadius = 15

        self.conversionInfoButton.setTitle("Get conversion info", for: .normal)
        self.conversionInfoButton.addTarget(self, action: #selector(self.getInfo), for: .touchDown)
        self.conversionInfoButton.backgroundColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        self.conversionInfoButton.layer.cornerRadius = 15
        
        self.convertLabel.text = "0"
        
        self.toLabel.textColor = .black
        self.toLabel.text = "to"
        self.toLabel.textAlignment = .center
        self.toLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        
        self.baseСurrencyLabel.textColor = .black
        self.baseСurrencyLabel.text = "Base"
        self.baseСurrencyLabel.textAlignment = .center
        self.baseСurrencyLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        
        self.conversionСurrencyLabel.textColor = .black
        self.conversionСurrencyLabel.text = "Conversion"
        self.conversionСurrencyLabel.textAlignment = .center
        self.conversionСurrencyLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        
        self.resultLabel.textColor = .black
        self.resultLabel.text = "Result:"
        self.resultLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.semibold)
        
        self.lineView.backgroundColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
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
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.convertButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertTextField.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        
        self.baseСurrencyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertButton.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.width.equalTo(180)
        }
        
        self.conversionСurrencyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertButton.snp.bottom).offset(20)
            make.right.equalToSuperview()
            make.width.equalTo(180)
        }
        
        self.basePickerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.baseСurrencyLabel.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.width.equalTo(180)
        }
        
        self.toLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.baseСurrencyLabel.snp.bottom).offset(105)
            make.left.equalTo(self.basePickerView.snp.right).offset(5)
            make.right.equalTo(self.convertPickerView.snp.left).offset(-5)
        }
        
        self.convertPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.baseСurrencyLabel.snp.bottom).offset(10)
            make.right.equalToSuperview()
            make.width.equalTo(180)

        }
        
        self.resultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertPickerView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.convertLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.resultLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.lineView.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertLabel.snp.bottom).offset(1)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(1)
        }
        
        self.conversionInfoButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
    }
}

extension ConvertView: IConvertView {
    func setCurrency(model: DataArray) {
        self.viewModel = model
        self.basePickerView.setModel(model: model)
        self.convertPickerView.setModel(model: model)
    }
    
    func refreshPickView() {
        self.basePickerView.pickerView.reloadAllComponents()
        self.convertPickerView.pickerView.reloadAllComponents()
    }
    
    @objc func getConvert() {
        let dataBase = DataBaseView()

        UIView.animate(withDuration: 0.5) {
            self.convertButton.alpha = 0.5
        }
        
        UIView.animate(withDuration: 0.5) {
            self.convertButton.alpha = 1
        }
        
        if self.convertTextField.text != "" {
            self.convertLabel.text = String(Double(self.convertTextField.text!)! * (self.convertPickerView.activeCurrency))
        }
        dataBase.setModel(number: self.convertTextField.text ?? "", base: self.baseModel ?? "error base", result: self.convertLabel.text ?? "nil", convert: self.convertModel ?? "error convert") // сделать красиво
    }
    
    @objc func getInfo() {
        UIView.animate(withDuration: 0.5) {
            self.conversionInfoButton.alpha = 0.5
        }
        
        UIView.animate(withDuration: 0.5) {
            self.conversionInfoButton.alpha = 1
        }
        
        self.onInfoButtonHandler?()
    }
}

extension ConvertView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
}
