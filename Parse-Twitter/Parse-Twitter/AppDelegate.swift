import UIKit
import Parse
import ParseUI
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

     var window: UIWindow? = UIWindow.make()
     var appController: AppController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.appController = AppController(window!)
        setupParse()
        appController.showFirstController()
        
        handleRemoteNotification(from: launchOptions, for: application)
        return true
    }
    
    func requestNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert]) { (completed, err) in
            if completed {
                print("agreed")
                
                UIApplication.shared.registerForRemoteNotifications()
                self.playLocalNotification()
                } else {
                print("not agreed")
            }
        }
    }
    
    private func handleRemoteNotification(from launchOptions:[UIApplicationLaunchOptionsKey: Any]?, for application: UIApplication) {
        if let launchOptions = launchOptions {
            if let notificationDictionary = launchOptions[.remoteNotification] as? [NSObject : AnyObject] {
                self.application(application, didReceiveRemoteNotification: notificationDictionary, fetchCompletionHandler: { (result) in
                    
                })
            }
        }
    }
    
    private func playLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "title"
        content.body = "sexy body"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "request.id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (err) in
            if(err != nil) {
                print("failed to schedule \(err)")
            }
        }
    }

    private func setupParse() {
        //set subclass
        Post.registerSubclass()
        
        //init
        let config = ParseClientConfiguration {
            $0.applicationId = "myAppId"
            $0.clientKey = "myMasterKey"
            $0.server = "https://iostwitter.herokuapp.com/parse"
        }
        Parse.initialize(with: config)
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let installation = PFInstallation.current()
        installation?["user"] = PFUser.current()
        installation?.setDeviceTokenFrom(deviceToken)
        installation?.saveInBackground()
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PFPush.handle(userInfo)
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
        UIApplication.shared.appDelegate.requestNotification()
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
