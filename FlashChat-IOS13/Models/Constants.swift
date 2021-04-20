//
//  Constants.swift
//  FlashChat-IOS13
//
//  Created by Sean Shlimak on 20/04/2021.
//

import Foundation
struct Constants {
    static let cellIdentifier = "ChatCell"
    static let cellNibName = "MessageTableViewCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let title = "⚡️FlashChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
