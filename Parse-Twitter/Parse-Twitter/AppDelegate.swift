import UIKit
import Parse
import ParseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = UIWindow.make()
    lazy var appController: AppController = AppController(self.window!)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setupParse()
        appController.showFirstController()

        return true
    }

    private func setupParse() {
        let config = ParseClientConfiguration {
            $0.applicationId = "myAppId"
            $0.clientKey = "myMasterKey"
            $0.server = "https://iostwitter.herokuapp.com/parse"
        }
        Parse.initialize(with: config)
    }
}

extension UIWindow {
    static func make() -> UIWindow {
        let win = UIWindow(frame: UIScreen.main.bounds)
        win.makeKeyAndVisible()
        return win
    }
}

class AppController {
    
    var window: UIWindow

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
    
    func postSucceed(_ viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

extension UIApplication {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
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
