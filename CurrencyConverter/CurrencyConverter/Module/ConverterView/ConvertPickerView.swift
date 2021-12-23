import UIKit
import SnapKit

final class ConvertPickerView: UIView {
     let pickerView = UIPickerView()
    
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
        return ConvertView.currency.count
//        return ConvertView.currencies.keys.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ConvertView.currency[row]
//        return ConvertView.currencies.keys

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ConvertView.activeCurrency = ConvertView.values[row]
    }
}

extension ConvertPickerView: UIPickerViewDelegate {
    
}
