//
//  ItemCardViewModel.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import Foundation

final class ItemCardViewModel: ObservableObject {
    func totalTransactionAmount(transactions : [TransactionItemDataModel]) -> Double {
        var totalAmount : Double = 0.0
        for transaction in transactions {
            totalAmount += transaction.userTransfers
        }
        return totalAmount
    }
}
