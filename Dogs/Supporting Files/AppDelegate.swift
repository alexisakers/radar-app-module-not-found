//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

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

