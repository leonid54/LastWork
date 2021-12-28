import UIKit
import SnapKit

protocol IBasePickerView {
    func setModel(model: DataArray)
}

final class BasePickerView: UIView {
    let pickerView = UIPickerView()
    var onSelectedCurrency: ((String) -> Void)?
    var onBaseCurrency: ((String) -> Void)?
    private var baseViewModel: DataArray?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BasePickerView {
    
    private func configure() {
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

    private func setConstraint() {
        self.pickerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension BasePickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.baseViewModel?.currency?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.onBaseCurrency?(self.baseViewModel?.currency?[row] ?? "")
        return self.baseViewModel?.currency?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.onSelectedCurrency?(self.baseViewModel?.currency?[row] ?? "")
    }
}

extension BasePickerView: UIPickerViewDelegate {
}

extension BasePickerView: IBasePickerView {
    func setModel(model: DataArray) {
        self.baseViewModel = model
    }
}
