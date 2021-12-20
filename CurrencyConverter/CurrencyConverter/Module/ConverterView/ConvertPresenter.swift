import UIKit

protocol IConvertPresenter {
    func onViewReady()
}

final class ConvertPresenter: IConvertPresenter {
    private weak var view: ConvertView?
    private var networkService = NetworkService()

    init(view: ConvertView) {
        self.view = view
        self.loadData(url: "", baseCurrency: "RUB")
    }
    
    func onViewReady() {
        self.view?.setupInitialState()
    }
    
    func loadData(url: String, baseCurrency: String) {
        self.networkService.loadData(url: "https://freecurrencyapi.net/api/v2/latest?apikey=4a16fbf0-5bf6-11ec-a4ff-0dc3c805f898&base_currency=" + "\(baseCurrency)") {  (result: Result<Currency, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print("все окей")
                    print("\(data)")
                    if let rates = data.data as? NSDictionary {
                        for (key, value) in rates {
                            self.view?.currency.append(key as? String ?? "")
                            self.view?.values.append(value as? Double ?? 0)
                        }
                        print(self.view?.currency)
                        print(self.view?.values)
                        self.view?.refreshPickView()

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
