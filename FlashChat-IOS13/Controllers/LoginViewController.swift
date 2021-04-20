//
//  LoginViewController.swift
//  FlashChat-IOS13
//
//  Created by Sean Shlimak on 20/04/2021.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser != nil{
            self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
        }
    }
    @IBAction func loginPressed(_ sender: Any) {
        if let email = emailTF.text, let password = passwordTF.text{
            Auth.auth().signIn(withEmail: email, password: password) { (dataResult, error) in
                if let error = error{
                    print(error)
                }else {
                    print("User Sucessfully Logged In")
                    self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                }
            }
        } else {
            UIAlertController.init(title: "Information Missing", message: "Please Fill In Email And Password Before Signing In", preferredStyle: .alert).show(self, sender: nil)
        }
        
    }

}
