//
//  ChatViewController.swift
//  FlashChat-IOS13
//
//  Created by Sean Shlimak on 20/04/2021.
//

import UIKit
import Firebase
class ChatViewController: UIViewController {
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTF: UITextField!
    var fireStoreDB = Firestore.firestore()
    var messages: [MessageModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.title
        navigationItem.hidesBackButton = true
        messageTableView.dataSource = self
        messageTableView.register(UINib(nibName: Constants.cellNibName, bundle: .main), forCellReuseIdentifier: Constants.cellIdentifier)
        loadMessages()
    }
    
    func loadMessages(){
        fireStoreDB.collection(Constants.FStore.collectionName).order(by: Constants.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            if let e = error{
                print(e)
            }else {
                if let snapShotDocuments = querySnapshot?.documents{
                    self.messages = []
                    for doc in snapShotDocuments {
                        if let sender = doc.data()[Constants.FStore.senderField] as? String,
                           let messageBody = doc.data()[Constants.FStore.bodyField] as? String{
                            let message = MessageModel(sender: sender, messageBody: messageBody)
                            self.messages.append(message)
                            DispatchQueue.main.async {
                                self.messageTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.messageTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        if let messageBody = messageTF.text, let sender = Auth.auth().currentUser?.email{
            fireStoreDB.collection(Constants.FStore.collectionName).addDocument(data: [
            Constants.FStore.senderField : sender,
            Constants.FStore.bodyField : messageBody,
                Constants.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error{
                    print(e)
                } else {
                    print("Data Was Successfully Saved.")
                }
            }
        }
        messageTF.text = ""
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch let error as NSError{
            print(error)
        }
    }
}
extension ChatViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! MessageTableViewCell
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
        }
        
        cell.messageLabel.text = message.messageBody
        return cell
    }
    
}
