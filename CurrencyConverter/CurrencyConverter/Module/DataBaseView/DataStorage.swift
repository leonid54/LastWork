import UIKit
import RealmSwift

final class DataStorage {
    let realm = try! Realm()
    var items: Results<ConversionInfo>!
    
    init() {
        self.items = realm.objects(ConversionInfo.self)
    }
    
    static func setConfig() {
        var config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}
            })
        config.deleteRealmIfMigrationNeeded = true
        
        Realm.Configuration.defaultConfiguration = config
        
        _ = try! Realm()
    }
}

