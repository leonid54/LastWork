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
        self.backgroundColor = Colors.defaultWhiteColor
        
        self.convertTextField.placeholder = l10n("CONVERT_VIEW_CONVERT_TEXT_FIELD")
        self.convertTextField.borderStyle = .roundedRect
                
        self.convertButton.setTitle(l10n("CONVERT_VIEW_CONVERT_BUTTON"), for: .normal)
        self.convertButton.addTarget(self, action: #selector(self.getConvert), for: .touchDown)
        self.convertButton.backgroundColor = Colors.defaultRedColor
        self.convertButton.layer.cornerRadius = Metrics.convertButtonCornerRadius

        self.conversionInfoButton.setTitle(l10n("CONVERT_VIEW_CONVERT_INFO_BUTTON"), for: .normal)
        self.conversionInfoButton.addTarget(self, action: #selector(self.getInfo), for: .touchDown)
        self.conversionInfoButton.backgroundColor = Colors.defaultGrayColor
        self.conversionInfoButton.layer.cornerRadius = Metrics.convertButtonCornerRadius
        
        self.convertLabel.text = "0"
        
        self.toLabel.textColor = Colors.defaultBlackColor
        self.toLabel.text = l10n("CONVERT_VIEW_TO_LABEL")
        self.toLabel.textAlignment = .center
        self.toLabel.font = Metrics.defaultToLabelFont
        
        self.baseСurrencyLabel.textColor = Colors.defaultBlackColor
        self.baseСurrencyLabel.text = l10n("CONVERT_VIEW_BASE_CURRENCY_LABEL")
        self.baseСurrencyLabel.textAlignment = .center
        self.baseСurrencyLabel.font = Metrics.defaultBaseCurrencyLabelFont
        
        self.conversionСurrencyLabel.textColor = Colors.defaultBlackColor
        self.conversionСurrencyLabel.text = l10n("CONVERT_VIEW_CONVERSION_LABEL")
        self.conversionСurrencyLabel.textAlignment = .center
        self.conversionСurrencyLabel.font = Metrics.defaultBaseCurrencyLabelFont
        
        self.resultLabel.textColor = Colors.defaultBlackColor
        self.resultLabel.text = l10n("CONVERT_VIEW_RESULT_LABEL")
        self.resultLabel.font = Metrics.defaultResultLabelFont
        
        self.lineView.backgroundColor = Colors.defaultGrayColor
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
            make.top.equalToSuperview().offset(Metrics.convertTextFieldTop)
            make.left.equalToSuperview().offset(Metrics.convertLeftConstr)
            make.right.equalToSuperview().offset(Metrics.convertRightConstr)
        }
        
        self.convertButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertTextField.snp.bottom).offset(Metrics.convertLeftConstr)
            make.left.equalToSuperview().offset(Metrics.convertLeftConstr)
            make.right.equalToSuperview().offset(Metrics.convertRightConstr)
            make.height.equalTo(Metrics.convertHeight)
        }
        
        self.baseСurrencyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertButton.snp.bottom).offset(Metrics.convertHeight)
            make.left.equalToSuperview()
            make.width.equalTo(Metrics.convertWidth)
        }
        
        self.conversionСurrencyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertButton.snp.bottom).offset(Metrics.convertHeight)
            make.right.equalToSuperview()
            make.width.equalTo(Metrics.convertWidth)
        }
        
        self.basePickerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.baseСurrencyLabel.snp.bottom).offset(Metrics.convertLeftConstr)
            make.left.equalToSuperview()
            make.width.equalTo(Metrics.convertWidth)
        }
        
        self.toLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.baseСurrencyLabel.snp.bottom).offset(Metrics.convertToLabelTop)
            make.left.equalTo(self.basePickerView.snp.right).offset(Metrics.convertToLabelLeft)
            make.right.equalTo(self.convertPickerView.snp.left).offset(Metrics.convertToLabelRight)
        }
        
        self.convertPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.baseСurrencyLabel.snp.bottom).offset(Metrics.convertLeftConstr)
            make.right.equalToSuperview()
            make.width.equalTo(Metrics.convertWidth)

        }
        
        self.resultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertPickerView.snp.bottom).offset(Metrics.convertHeight)
            make.left.equalToSuperview().offset(Metrics.convertLeftConstr)
            make.right.equalToSuperview().offset(Metrics.convertRightConstr)
        }
        
        self.convertLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.resultLabel.snp.bottom).offset(Metrics.convertLeftConstr)
            make.left.equalToSuperview().offset(Metrics.convertLeftConstr)
            make.right.equalToSuperview().offset(Metrics.convertRightConstr)
        }
        
        self.lineView.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertLabel.snp.bottom).offset(Metrics.convertDefaultOne)
            make.left.equalToSuperview().offset(Metrics.convertLineViewLeft)
            make.right.equalToSuperview().offset(Metrics.convertLineViewRight)
            make.height.equalTo(Metrics.convertDefaultOne)
        }
        
        self.conversionInfoButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.convertLabel.snp.bottom).offset(Metrics.convertInfoButtonTop)
            make.left.equalToSuperview().offset(Metrics.convertLeftConstr)
            make.right.equalToSuperview().offset(Metrics.convertRightConstr)
            make.height.equalTo(Metrics.convertButtonHeight)
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

        UIView.animate(withDuration: Metrics.convertAnimateDuration) {
            self.convertButton.alpha = Metrics.convertAnimateAlpha
        }
        
        UIView.animate(withDuration: Metrics.convertAnimateDuration) {
            self.convertButton.alpha = Metrics.convertAnimateAlpha
        }
        
        if self.convertTextField.text != "" {
            self.convertLabel.text = String(Double(self.convertTextField.text!)! * (self.convertPickerView.activeCurrency))
        }
        
        dataBase.setModel(number: self.convertTextField.text ?? "", base: self.baseModel ?? "error base", result: self.convertLabel.text ?? "nil", convert: self.convertModel ?? "error convert") // сделать красиво
    }
    
    @objc func getInfo() {
        UIView.animate(withDuration: Metrics.convertAnimateDuration) {
            self.conversionInfoButton.alpha = Metrics.convertAnimateAlphaGetInfoFirst
        }
        
        UIView.animate(withDuration: Metrics.convertAnimateDuration) {
            self.conversionInfoButton.alpha = Metrics.convertAnimateAlpha
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
