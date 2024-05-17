//
//  FirebaseConstans.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 13.05.2024.
//

import Foundation
import Firebase
import FirebaseStorage

enum FirebaseConstans {
    private static let DatabaseRef = Database.database().reference()
    static let UserRef = DatabaseRef.child("users")
    static let ChannelsRef = DatabaseRef.child("channels")
    static let MessagesRef = DatabaseRef.child("channel-messages")
    static let UserChannelsRef = DatabaseRef.child("user-channels")
    static let UserDirectChannels = DatabaseRef.child("user-direct-channels")
}
