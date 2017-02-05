import UIKit
import Parse
import ParseUI

class PostViewController: UIViewController {
    @IBOutlet weak var myImage: PFImageView!

    @IBOutlet weak var messageField: UITextField!
    

    @IBAction func postButton(_ sender: Any) {
        print("Message: \(messageField.text)")
        var postObject = PFObject(className:"Posts")
        postObject["message"] = messageField.text!
        postObject.saveInBackground { (success, error) in
            if (success) {
                print("succeed")
            } else {
                print("failed")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add an tap gensture on top of the image view
        let tap = UITapGestureRecognizer(target: self, action: #selector(PostViewController.imageOption(sender:)))
        myImage.isUserInteractionEnabled = true;
        myImage.addGestureRecognizer(tap)
    }
    
    func imageOption(sender: UIImageView) {
        print("tapped")
    }
}
