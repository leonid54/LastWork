import UIKit
import SnapKit
import RealmSwift

protocol IDataBaseView: AnyObject {
    func setupInitialState()
}

final class DataBaseView: UIViewController {
    private lazy var presenter: DataBasePresenter = {
        return DataBasePresenter(view: self)
    }()
    private var tableView: UITableView = UITableView()
    private var addButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.presenter.onViewReady()
//        self.items = realm.objects(Company.self)
    }

}

private extension DataBaseView {
    
    private func configure() {
        self.setConfig()
        self.addDelegate()
        self.addSubviews()
        self.setConstraint()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.addButton)
        self.view.addSubview(self.tableView)
    }

    private func addDelegate() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func setConfig() {
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(addCompany(_:)))
        self.tableView.showsVerticalScrollIndicator = false
        self.addButton.setTitle("Add", for: .normal)
    }

    private func setConstraint() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func addCompany(_ sender: AnyObject) {
        self.addAlert()
        }
    
    private func addAlert() {
        let alert = UIAlertController(title: "Добавление новой компании", message: "Введите название компании", preferredStyle: .alert)
        
        var alertTextField: UITextField?
        alert.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "Компания"
        }
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            guard let text = alertTextField?.text , !text.isEmpty else { return }
//            let task = ConversionInfo()
//            task.name = text
//            task.id = NSUUID().uuidString
//
//            try! self.realm.write {
//                self.realm.add(task)
//            }
//            self.tableView.insertRows(at: [IndexPath.init(row: self.items.count-1, section: 0)], with: .automatic)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension DataBaseView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = items[indexPath.row]
//        let employee = EmployeesView.init(companyID: item.id)
//        self.navigationController?.pushViewController(employee, animated: true)
    }
    
//     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let editingRow = items[indexPath.row]
//
//        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _,_ in
//            try! self.realm.write {
//                self.realm.delete(editingRow)
//                tableView.reloadData()
//            }
//        }
//        return [deleteAction]
//    }
}

extension DataBaseView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if items.count != 0 {
//            return items.count
//        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DataBaseViewCell()
        cell.configure()
//        let item = items[indexPath.row]
//        cell.nameLabel.text = item.name
        return cell
    }
}

extension DataBaseView: IDataBaseView {
    func setupInitialState() {
        self.navigationController?.title = "Company"
    }
}
