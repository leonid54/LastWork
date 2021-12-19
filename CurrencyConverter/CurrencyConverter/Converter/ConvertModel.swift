import UIKit

struct Currency: Codable {
//    let query: Query
    let data: [String: Double]
}

struct Query: Codable {
    let apikey: String
    let timestamp: Int
    let baseCurrency: String

    enum CodingKeys: String, CodingKey {
        case apikey, timestamp
        case baseCurrency = "base_currency"
    }
}
