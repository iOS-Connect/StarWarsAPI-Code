import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let vc = NamesTableViewController(nibName: nil, bundle: nil)
        window?.rootViewController = UINavigationController(rootViewController: vc)

        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        return true
    }
}


