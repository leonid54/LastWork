import UIKit
import SnapKit
import RealmSwift

protocol IDataBaseView: AnyObject {
    func setData(model: DataStorage)
}

final class DataBaseView: UIView {
    private var tableView: UITableView = UITableView()
    let realm = try! Realm()
 // как сделать по-другому???
    var items: Results<ConversionInfo>! // как сделать по-другому???
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.items = realm.objects(ConversionInfo.self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(number: String, base: String, result: String, convert: String) {
        let task = ConversionInfo()
        task.convertNumber = number
        task.baseCurrency = base
        task.resultOfConversion = result
        task.convertCurrency = convert

        try! self.realm.write {
            self.realm.add(task)
        }
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.configure()
//        self.presenter.onViewReady()
//        self.items = realm.objects(ConversionInfo.self)
//    }
    
}

private extension DataBaseView {
    
    private func configure() {
        self.setConfig()
        self.addDelegate()
        self.addSubviews()
        self.setConstraint()
    }
    
    private func addSubviews() {
        self.addSubview(self.tableView)
    }

    private func addDelegate() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func setConfig() {
        self.backgroundColor = .white
        self.tableView.showsVerticalScrollIndicator = false
    }

    private func setConstraint() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension DataBaseView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
    }
    
     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let editingRow = items[indexPath.row]

        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _,_ in
            try! self.realm.write {
                self.realm.delete(editingRow)
            }
            tableView.reloadData()
        }
        return [deleteAction]
    }
}

extension DataBaseView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count != 0 {
            return items.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DataBaseViewCell()
        cell.configure()
        let item = items[indexPath.row]
        cell.numberLabel.text = item.convertNumber
        cell.baseCurrencyLabel.text = item.baseCurrency
        cell.resultLabel.text = item.resultOfConversion
        cell.conversionCurrencyLabel.text = item.convertCurrency
        return cell
        
    }
}

extension DataBaseView: IDataBaseView {

    func setData(model: DataStorage) {
//        let realm = model.realm
    }
}
