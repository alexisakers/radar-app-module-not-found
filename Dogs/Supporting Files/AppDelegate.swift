import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let dogsDirectory = Bundle.main.resourceURL!.appendingPathComponent("golden_retriever")
        let dogFiles = try! FileManager.default.contentsOfDirectory(at: dogsDirectory, includingPropertiesForKeys: nil)
        let localDogs = dogFiles.map(Dog.init)

        let dogsViewController = DogsViewController(dogs: localDogs, breed: "Golden Retrievers")
        let navigation = UINavigationController(rootViewController: dogsViewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()

        return true
    }

}

