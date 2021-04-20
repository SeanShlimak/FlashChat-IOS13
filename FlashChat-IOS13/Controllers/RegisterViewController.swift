//
//  RegisterViewController.swift
//  FlashChat-IOS13
//
//  Created by Sean Shlimak on 20/04/2021.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if (emailTF.text == nil || passwordTF.text == nil){
            UIAlertController.init(title: "Information Missing", message: "Please Fill In Email And Password.", preferredStyle: .alert).show(self, sender: nil)
            return
        }
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (dataResult, error) in
            if let e = error {
                print(e)
                return
            }else {
                self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
