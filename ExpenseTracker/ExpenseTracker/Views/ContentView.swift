//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Siddhatech on 27/08/24.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM : TransactionListViewModel
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading,spacing: 24) {
                   Text("OverView")
                        .font(.title2)
                    let data = transactionListVM.accumulateTransactions()
                    let doubleValues: [Double] = data.map { $0.1 }
                    LineChartView(
                        data: doubleValues,
                        title: "$\(round(doubleValues.last ?? 0))",
                        legend: "Cumulative Spending",
                        form: .init(width: 360, height: 230),
                        dropShadow: true
                    )

                   

                    RecentTransactionList()
                }.padding()
                .frame(maxWidth: .infinity)
            }.background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon)
                        
                }
            }
        }.navigationViewStyle(.stack)
            .accentColor(.primary)
    }
}

struct ContentView_Preview : PreviewProvider {
    static let transactioListVM : TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        Group{
          ContentView()
          ContentView()
                .preferredColorScheme(.dark)
        }.environmentObject(transactioListVM )
    }
}
