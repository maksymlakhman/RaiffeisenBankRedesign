//
//  UserItem.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 13.05.2024.
//

import Foundation

struct UserItem: Identifiable, Hashable, Decodable {
    let uid : String
    let username : String
    let email : String
//    let password : String
    var bio : String? = nil
    var profileImageUrl : String? = nil
    
    var id: String {
        return uid
    }
    
    var bioUnwraped : String {
        return bio ?? "Hey there! I am using WhatsApp."
    }
    
    static let placeholder = UserItem(uid: "1", username: "Max", email: "MaxTest1996@gmail.com")
    
    static let placeholders: [UserItem] = [
        UserItem(uid: "1", username: "Max", email: "maxtest@gmail.com"),
        UserItem(uid: "2", username: "Dam", email: "maxtest@gmail.com"),
        UserItem(uid: "3", username: "Sam", email: "maxtest@gmail.com", bio: "Tech Star"),
        UserItem(uid: "4", username: "Dr.Moris", email: "maxtest@gmail.com"),
        UserItem(uid: "5", username: "Fa", email: "maxtest@gmail.com"),
        UserItem(uid: "6", username: "Tim", email: "maxtest@gmail.com", bio: "Dreamer"),
        UserItem(uid: "7", username: "Yu", email: "maxtest@gmail.com"),
        UserItem(uid: "8", username: "Sima", email: "maxtest@gmail.com"),
        UserItem(uid: "9", username: "Dillon", email: "maxtest@gmail.com"),
        UserItem(uid: "10", username: "Nathan", email: "maxtest@gmail.com")
    ]
}

extension UserItem {
    init(dictionary : [String : Any]){
        self.uid = dictionary[.uid] as? String ?? ""
        self.username = dictionary[.username] as? String ?? ""
        self.email = dictionary[.email] as? String ?? ""
        self.bio = dictionary[.bio] as? String ?? nil
        self.profileImageUrl = dictionary[.profileImageUrl] as? String ?? nil
    }
}

extension String {
    static let uid = "uid"
    static let username = "username"
    static let email = "email"
    static let bio = "bio"
    static let profileImageUrl = "profileImageUrl"
}

