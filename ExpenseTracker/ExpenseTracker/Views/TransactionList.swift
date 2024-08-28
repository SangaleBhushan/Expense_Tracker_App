//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Siddhatech on 28/08/24.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM : TransactionListViewModel
    
    var body: some View {
        VStack{
            List{
                ForEach(Array(transactionListVM.groupTransactiomByMonth()) , id:\.key){ month , transactions in
                    Section{
                        ForEach(transactions){ transaction in
                          TransactionRow(transaction: transaction)
                        }
                    }header: {
                       Text(month)
                    }
                    .listSectionSeparator(.hidden)
                    
                }
            }
        }.navigationTitle("Transactions")
            
        
    }
}

struct TransactionList_Preview : PreviewProvider {
    static let transactioListVM : TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        Group{
            NavigationView{
              TransactionList()
            }
            NavigationView{
            TransactionList()
            }
                .preferredColorScheme(.dark)
        }.environmentObject(transactioListVM )
    }
}
