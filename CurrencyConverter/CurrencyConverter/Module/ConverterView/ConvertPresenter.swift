import UIKit

protocol IConvertPresenter {
    func onViewReady()
}

final class ConvertPresenter: IConvertPresenter {
    private weak var view: ConvertView?
    private var networkService = NetworkService()
    private var baseCurrency = ""

    init(view: ConvertView) {
        self.view = view
        self.view?.onTouchHandler = { [weak self] model in
            self?.loadData(baseCurrency: "\(model)")
        }
        self.loadData(baseCurrency: "\(self.baseCurrency)")
    }
    
    func onViewReady() {
        self.view?.setupInitialState()
    }
    
    func loadData(baseCurrency: String) {
        self.networkService.loadData(url: "https://freecurrencyapi.net/api/v2/latest?apikey=4a16fbf0-5bf6-11ec-a4ff-0dc3c805f898&base_currency=" + "\(baseCurrency)") {  (result: Result<Currency, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print("Success")
                    print("\(data)")
            
                    if let rates = data.data as? NSDictionary {
                        for (key, value) in rates {
                            ConvertView.currencies.updateValue(value as? Double ?? 0, forKey: key as? String ?? "")
                            self.view?.setCurrency()
                            self.view?.refreshPickView()
                        }
                    }
                }
            case .failure(let error):
                print("[NETWORK] error is: \(error)")
                DispatchQueue.main.async {
                    print("error")
                }
            }
        }
    }
}
