import UIKit
import SnapKit

protocol IConvertPickerView {
    func setModel(model: DataArray)
}

final class ConvertPickerView: UIView {
    let pickerView = UIPickerView()
    var onConvertCurrency: ((String) -> Void)?
    private var convertViewModel: DataArray?
    var activeCurrency: Double = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ConvertPickerView {
    
    private func configure() {
        self.setConfig()
        self.addSubviews()
        self.setConstraint()
        self.addDelegate()
    }
    
    private func addSubviews() {
        self.addSubview(self.pickerView)
    }
    
    private func addDelegate() {
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }
    
    private func setConfig() {
        
    }
    
    private func setConstraint() {
        self.pickerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ConvertPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.convertViewModel?.currency?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.activeCurrency = self.convertViewModel?.values?[row] ?? 0
        return self.convertViewModel?.currency?[row] ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.activeCurrency = self.convertViewModel?.values?[row] ?? 0
        self.onConvertCurrency?(self.convertViewModel?.currency?[row] ?? "")
    }
}

extension ConvertPickerView: UIPickerViewDelegate {
    
}

extension ConvertPickerView: IConvertPickerView {
    func setModel(model: DataArray) {
        self.convertViewModel = model
    }
}
