import UIKit
import RealmSwift

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        DataStorage.setConfig()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let vc = ConvertAssembly.makeModule()
        let navVC = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
    }
}

