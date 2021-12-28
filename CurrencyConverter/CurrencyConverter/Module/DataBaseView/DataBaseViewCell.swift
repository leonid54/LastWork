import UIKit

final class DataBaseViewCell: UITableViewCell {
    let numberLabel = UILabel()
    let baseCurrencyLabel = UILabel()
    let toLabel = UILabel()
    let resultLabel = UILabel()
    let conversionCurrencyLabel = UILabel()
    
    func configure() {
        self.addSubviews()
        self.setConstraint()
        self.setContent()
    }
}

private extension DataBaseViewCell {
    
    private func addSubviews() {
        self.addSubview(self.numberLabel)
        self.addSubview(self.baseCurrencyLabel)
        self.addSubview(self.toLabel)
        self.addSubview(self.conversionCurrencyLabel)
        self.addSubview(self.resultLabel)
    }
    
    private func setContent() {
        self.toLabel.text = "="
        self.toLabel.textColor = Colors.defaultBlackColor
    }

    private func setConstraint() {
        self.numberLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Metrics.dataBaseCellLeftNumberLabel)
            make.top.equalToSuperview().offset(Metrics.dataBaseCellTopLabel)
        }
        
        self.baseCurrencyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.numberLabel.snp.right).offset(Metrics.dataBaseCellLeftRightLabel)
            make.top.equalToSuperview().offset(Metrics.dataBaseCellTopLabel)
        }
        
        self.toLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.baseCurrencyLabel.snp.right).offset(Metrics.dataBaseCellLeftRightLabel)
            make.top.equalToSuperview().offset(Metrics.dataBaseCellTopLabel)
        }
        
        self.resultLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.toLabel.snp.right).offset(Metrics.dataBaseCellLeftRightLabel)
            make.top.equalToSuperview().offset(Metrics.dataBaseCellTopLabel)
        }
        
        self.conversionCurrencyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.resultLabel.snp.right).offset(Metrics.dataBaseCellLeftRightLabel)
            make.top.equalToSuperview().offset(Metrics.dataBaseCellTopLabel)
        }
    }
}
