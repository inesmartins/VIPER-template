import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appRouter: AppRouterType?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let coreData = CoreDataStorage()
        let userDefaults = UserDefaultsStorage()
        let keychain = KeyChainStorage()

        let store = StoreService(coreData: coreData,
                                 userDefaults: userDefaults,
                                 keychain: keychain)
        let apiService = APIService()
        let appViewController = self.setupAppViewController()
        self.appRouter = AppRouter(
            appViewController: appViewController,
            store: store,
            apiService: apiService)
        self.appRouter?.startApplication()
        return true
    }
}

private extension AppDelegate {

    func setupAppViewController() -> AppViewControllerType {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let appViewController = AppViewController()
        self.window?.rootViewController = appViewController
        self.window?.makeKeyAndVisible()
        return appViewController
    }

}
