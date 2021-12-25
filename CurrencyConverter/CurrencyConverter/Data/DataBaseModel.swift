import UIKit
import RealmSwift

final class ConversionInfo: Object {
    @Persisted var convertNumber: String
    @Persisted var baseCurrency: String
    @Persisted var convertCurrency: String
    @Persisted var resultOfConversion: String
}
