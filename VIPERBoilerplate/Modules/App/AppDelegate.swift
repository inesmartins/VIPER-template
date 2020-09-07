import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appRouter: AppRouterType?

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VIPERBoilerplate")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let store = StoreService(container: self.persistentContainer)
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
