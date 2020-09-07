import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appRouter: AppRouterType?

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VIPERBoilerplate")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appViewController = self.setupAppViewController()
        let store = StoreService(container: self.persistentContainer)
        let apiService = APIService()
        self.appRouter = AppRouter(
            appViewController: appViewController,
            store: store,
            authService: apiService,
            ddgService: apiService)
        self.appRouter?.startApplication()
        return true
    }

    private func setupAppViewController() -> AppViewControllerType {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let appViewController = AppViewController(nibName: nil, bundle: nil)
        self.window?.rootViewController = appViewController
        self.window?.makeKeyAndVisible()
        return appViewController
    }

}
