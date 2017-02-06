import UIKit
import Parse
import ParseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appController: AppController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let config = ParseClientConfiguration {
            $0.applicationId = "myAppId"
            $0.clientKey = "myMasterKey"
            $0.server = "https://iostwitter.herokuapp.com/parse"
        }
        Parse.initialize(with: config)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        appController = AppController(window!)
        appController.showFirstController()
        
        return true
    }
    
}
class AppController {
    
    var window: UIWindow!

    init(_ window: UIWindow) {
        self.window = window
    }

    func didLogout() {
        showFirstController()
    }

    func didLogin() {
        showFirstController()
    }
    
    func showFirstController() {
        if let _ = PFUser.current() {
            showChatController()
        } else {
            showLoginController()
        }
    }
    
    func showChatController() {
        let stroyboard = UIStoryboard(name: "ChatTable", bundle: nil)
        let ctvc = stroyboard.instantiateInitialViewController()
        self.window.rootViewController = ctvc
    }

    func showLoginController() {
        let stroyboard = UIStoryboard(name: "Welcome", bundle: nil)
        let lvc = stroyboard.instantiateInitialViewController()
        self.window.rootViewController = lvc
    }

}

/*
 curl -X POST \
 -H "X-Parse-Application-Id: myAppId" \
 -H "Content-Type: application/json" \
 -d '{"score":1337,"playerName":"Sean Plott","cheatMode":false}' \
 https://iostwitter.herokuapp.com/parse/classes/GameScore
 
 
 curl -X GET \
 -H "X-Parse-Application-Id: myAppId" \
  https://iostwitter.herokuapp.com/parse/classes/GameScore/uhnfSKBO0F
 */
