import UIKit

protocol IConvertPresenter {
    func loadView(controller: ConvertViewController, view: IConvertView)
}

final class ConvertPresenter {
    private weak var controller: ConvertViewController?
    private weak var view: IConvertView?
    private let router: ConvertRouter
    private var networkService = NetworkService()
    private var baseCurrency = ""
    
    init(router: ConvertRouter) {
        self.router = router
    }
}

private extension ConvertPresenter {
    
    func loadData(baseCurrency: String) {
        self.networkService.loadData(url: "https://freecurrencyapi.net/api/v2/latest?apikey=4a16fbf0-5bf6-11ec-a4ff-0dc3c805f898&base_currency=" + "\(baseCurrency)") {  (result: Result<Currency, Error>) in
            switch result {
            case .success(let data):
                var currency: [String] = []
                var values: [Double] = []
                DispatchQueue.main.async {
                    print("Success")
                    if let rates = data.data as? NSDictionary {
                        for (key, value) in rates {
                            DataArray.currencies.updateValue(value as? Double ?? 0, forKey: key as? String ?? "")
                        }
                        print(DataArray.currencies)

                        currency.removeAll()
                        values.removeAll()
                    for (key, value) in DataArray.currencies {
                            currency.append(key)
                            values.append(value)
                        }
                    }
                    let model = DataArray(currency: currency, values: values)
                    self.view?.setCurrency(model: model)
                    self.view?.refreshPickView()
                }
            case .failure(let error):
                print("[NETWORK] error is: \(error)")
                DispatchQueue.main.async {
                    print("error")
                }
            }
        }
    }
    
    private func setNetwork() {
        self.view?.onTouchHandler = { [weak self] model in
            self?.loadData(baseCurrency: "\(model)")
        }
        self.loadData(baseCurrency: "\(self.baseCurrency)")
    }
    
    private func setHandlers() {
        DispatchQueue.main.async {
            self.view?.onInfoButtonHandler = { [weak self] in
                self?.router.next()
            }
        }
    }
}

extension ConvertPresenter: IConvertPresenter {
    func loadView(controller: ConvertViewController, view: IConvertView) {
        self.controller = controller
        self.view = view
        self.setHandlers()
        self.setNetwork()
    }
}
