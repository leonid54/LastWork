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
        self.toLabel.textColor = .black
        
        self.numberLabel.numberOfLines = 2
    }

    private func setConstraint() {
        self.numberLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
        }
        
        self.baseCurrencyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.numberLabel.snp.right).offset(2)
            make.top.equalToSuperview().offset(10)
        }
        
        self.toLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.baseCurrencyLabel.snp.right).offset(2)
            make.top.equalToSuperview().offset(10)
        }
        
        self.resultLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.toLabel.snp.right).offset(2)
            make.top.equalToSuperview().offset(10)
        }
        
        self.conversionCurrencyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.resultLabel.snp.right).offset(2)
            make.top.equalToSuperview().offset(10)
        }
    }
}
