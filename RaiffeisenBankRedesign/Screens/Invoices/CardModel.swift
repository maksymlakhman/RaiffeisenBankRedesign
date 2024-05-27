//
//  CardModel.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import SwiftUI
import SwiftData
import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }

        let scanner = Scanner(string: hexString)

        var rgbValue: UInt64 = 0
        guard scanner.scanHexInt64(&rgbValue) else {
            return nil
        }

        var red, green, blue, alpha: UInt64
        switch hexString.count {
        case 6:
            red = (rgbValue >> 16)
            green = (rgbValue >> 8 & 0xFF)
            blue = (rgbValue & 0xFF)
            alpha = 255
        case 8:
            red = (rgbValue >> 16)
            green = (rgbValue >> 8 & 0xFF)
            blue = (rgbValue & 0xFF)
            alpha = rgbValue >> 24
        default:
            return nil
        }

        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }

    // Returns a hex string representation of the UIColor instance
    func toHexString(includeAlpha: Bool = false) -> String? {
        // Get the red, green, and blue components of the UIColor as floats between 0 and 1
        guard let components = self.cgColor.components else {
            // If the UIColor's color space doesn't support RGB components, return nil
            return nil
        }

        // Convert the red, green, and blue components to integers between 0 and 255
        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)

        // Create a hex string with the RGB values and, optionally, the alpha value
        let hexString: String
        if includeAlpha, let alpha = components.last {
            let alphaValue = Int(alpha * 255.0)
            hexString = String(format: "#%02X%02X%02X%02X", red, green, blue, alphaValue)
        } else {
            hexString = String(format: "#%02X%02X%02X", red, green, blue)
        }

        // Return the hex string
        return hexString
    }
}

extension Color {

    init?(hex: String) {
        guard let uiColor = UIColor(hex: hex) else { return nil }
        self.init(uiColor: uiColor)
    }

    func toHexString(includeAlpha: Bool = false) -> String? {
        return UIColor(self).toHexString(includeAlpha: includeAlpha)
    }

}


enum LogoCard : String, Codable {
    case mastercard = "mastercard"
    case visa = "visa"
    case mono = "mono"
    
    var description : String {
        switch self{
        case .mastercard : "Mastercard"
        case .visa : "Visa"
        case .mono : "Monobank"
        }
    }
}

@Model
class Card {
    var color: String
    var name : String
    var coins : Double
    var transactionItemsDataModel : [TransactionItemDataModel]?
    var creationDate : Date
    var expirationDate : Date
    let tokenCode : Int
    var logoCard : LogoCard
    @Relationship(inverse : \TeamModel.teamName)
    
    
    init(_color: String, _name: String, _coins: Double, _creationDate : Date ,_expirationDate : Date, _tokenCode : Int, _logoCard : LogoCard) {
        self.color = _color
        self.name = _name
        self.coins = _coins
        self.creationDate = _creationDate
        self.expirationDate = Calendar.current.date(byAdding: .year, value: 4, to: Date()) ?? Date()
        self.tokenCode = Int.random(in: 100...999)
        self.logoCard = _logoCard
    }
    
    
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}

enum SendOrReceivedEnum : String, Codable {
    case send = "arrow.up.forward"
    case receive = "arrow.down.backward"
    
    var description: String {
        switch self {
            case .send: return "Отправить"
            case .receive: return "Получить"
        }
    }
}

@Model
class TransactionItemDataModel: Identifiable, ObservableObject {
    var id : UUID
    var card : Card?
    var defaultImage : String
    var operationOptionImage : SendOrReceivedEnum
    var currentTimeAndDate : Date
    var userTransfers : Double
    
    init(card : Card ,defaultImage: String, operationOptionImage: SendOrReceivedEnum, currentTimeAndDate: Date, userTransfers: Double) {
        self.id = UUID()
        self.card = card
        self.defaultImage = defaultImage
        self.operationOptionImage = operationOptionImage
        self.currentTimeAndDate = currentTimeAndDate
        self.userTransfers = userTransfers
    }
    
}


enum TeamRegionCountry : String, Codable {
    case ukraine = "Ukraine"
    case usa = "USA"
    case uk = "UK"
    
    var description: String {
        switch self {
            case .ukraine: return "🇺🇦"
            case .usa: return "🇺🇸"
            case .uk: return "🇬🇧"
        }
    }
}

@Model
class TeamModel {
    var id : UUID
    var card : [Card]?
    var teamName : String
    var teamEmail : String
    var region : TeamRegionCountry
    var color: String
    @Relationship
    var arrUsers: [User]?
    
    init(teamName: String, teamEmail: String, region: TeamRegionCountry, color: String) {
        self.id = UUID()
        self.teamName = teamName
        self.teamEmail = teamEmail
        self.region = region
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}


import Foundation
import SwiftUI
import SwiftData

@Model
class User {
    var name : String
    var userLastName : String
    var color: String
    var teamModel : [TeamModel]?
    
    init(name: String, userLastName : String, color : String) {
        self.name = name
        self.userLastName = userLastName
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .blue
    }
}
