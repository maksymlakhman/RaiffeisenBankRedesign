//
//  ReceiveViewModel.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import Foundation

class ReceiveViewModel: ObservableObject {
    @Published var accountNumber: String = ""
    @Published var hourlyRate: String = ""
    @Published var hoursWorked: String = ""
    @Published var taxRate: String? = ""
    @Published var bonuses: String? = ""
    @Published var comments: String = ""
    @Published var finalNetSalary: String = "0.00"
    
    func formatAccountNumber(_ value: String) -> String {
        var formattedValue = ""
        var index = 0
        
        for character in value {
            if index > 0 && index % 4 == 0 {
                formattedValue.append(" ")
            }
            formattedValue.append(character)
            index += 1
        }
        
        return formattedValue
    }
    
    func pushSalary() {
        let hourlyRateDouble = Double(hourlyRate) ?? 0.0
        let hoursWorkedDouble = Double(hoursWorked) ?? 0.0
        let taxRateDouble = Double(taxRate ?? "") ?? 0.0
        let bonusesDouble = Double(bonuses ?? "") ?? 0.0
        
        let grossSalary = hourlyRateDouble * hoursWorkedDouble
        let taxAmount = grossSalary * (taxRateDouble / 100)
        let netSalary = grossSalary - taxAmount + bonusesDouble
        finalNetSalary = String(format: "%.2f", netSalary)
    }
}
