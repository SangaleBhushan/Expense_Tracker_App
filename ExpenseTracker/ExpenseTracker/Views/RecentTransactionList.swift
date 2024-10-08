//
//  RecentTransactionList.swift
//  ExpenseTracker
//
//  Created by Siddhatech on 28/08/24.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM : TransactionListViewModel
    
    var body: some View {
        VStack{
            HStack{
                Text("Recent Transactions")
                    .bold()
                Spacer()
                NavigationLink{
                    TransactionList()
                }label: {
                    HStack(spacing:4) {
                     Text("See All")
                        Image(systemName: "chevron.right")
                    }.foregroundColor(.text)
                }
            }.padding(.top)
            
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id:\.element) { index , transaction in
                TransactionRow(transaction: transaction)
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }.padding()
            .background(Color.systemBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
            .shadow(color:Color.primary.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/,x:0,y:5)
             
    }
}
struct RecentTransactionList_Preview : PreviewProvider {
    static let transactioListVM : TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        Group{
            RecentTransactionList()
            RecentTransactionList()
                .preferredColorScheme(.dark)
        }.environmentObject(transactioListVM )
    }
}
