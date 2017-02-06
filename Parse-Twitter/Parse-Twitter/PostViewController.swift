import UIKit
import Parse
import ParseUI

class PostViewController: UIViewController {
    @IBOutlet weak var myImage: PFImageView!

    @IBOutlet weak var messageField: UITextField!
    
    @IBAction func imageOptions(_ sender: Any) {
        print("tapped")
    }

    @IBAction func postButton(_ sender: Any) {
        print("Message: \(messageField.text)")
        var postObject = PFObject(className:"Posts")
        postObject["message"] = messageField.text!
        postObject.saveInBackground { (success, error) in
            if (success) {
                print("succeed")
                UIApplication.shared.appDelegate.appController.postSucceed(self)
            } else {
                print("failed")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
