import UIKit
import RealmSwift

final class ConversionInfo: Object {
    @Persisted var baseCurrency: String
    @Persisted var convertCurrency: String
}
