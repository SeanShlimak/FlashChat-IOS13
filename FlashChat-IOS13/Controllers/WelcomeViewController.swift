//
//  WelcomeViewController.swift
//  FlashChat-IOS13
//
//  Created by Sean Shlimak on 19/04/2021.
//

import UIKit
import CLTypingLabel
class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = Constants.title
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    /*func setLabelAnimation(){
        let label = "⚡️FlashChat"
        var letterIndex = 0.0
        for letter in label {
            Timer.scheduledTimer(withTimeInterval: 0.1 * letterIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            letterIndex += 1
        }
        
    }
    */
}
