//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Siddhatech on 27/08/24.
//

import Foundation
import SwiftUI

var transactionPreviewData = Transaction(id: 1, date: "22/11/20002", institution: "Siddhatech", account: "Visa", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)
var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
