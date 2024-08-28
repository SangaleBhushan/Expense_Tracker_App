import Foundation
import  Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String ,Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []

    init() {
        Task {
            await getTransaction()
        }
    }

    func getTransaction() async {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Bad response: \(response)")
                return
            }
            
            let decoder = JSONDecoder()
            let decodedTransactions = try decoder.decode([Transaction].self, from: data)
            self.transactions = decodedTransactions
            print("Finished fetching transaction")
            dump(self.transactions)
        } catch {
            print("Error fetching transaction: \(error.localizedDescription)")
        }
    }
    
    func groupTransactiomByMonth ()-> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        let groupTransactions =  TransactionGroup(grouping: transactions){ $0.month }
        return groupTransactions
    }
    func accumulateTransactions ()-> TransactionPrefixSum {
        guard !transactions.isEmpty else { return [] }
        
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)
//        print("DateInterval", dateInterval)
        var sum : Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride (from: dateInterval!.start, to: today, by: 60 * 60 * 24){
            let dailyExpenses = transactions.filter{$0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) {$0 - $1.signedAmount}
            sum += dailyTotal
            
            cumulativeSum.append((date.formatted(),sum))
            print(date.formatted() , "daily Total : " ,dailyTotal, "sum: " , sum)
         
        }
        return cumulativeSum
    }
}




//import Foundation
//
//final class TransactionListViewModel: ObservableObject {
//    @Published var transactions: [Transaction] = []
//
//    init() {
//        loadSampleData()
//    }
//
//    func loadSampleData() {
//        let path = "/Users/siddhatech/Downloads/BhushanTraining/ExpenseTracker/ExpenseTracker/sample_data.json"
//        let fileURL = URL(fileURLWithPath: path)
//        
//        do {
//            let data = try Data(contentsOf: fileURL)
//            let decodedTransactions = try JSONDecoder().decode([Transaction].self, from: data)
//            self.transactions = decodedTransactions
//            print("success")
//        } catch {
//            print("Failed to load or decode JSON: \(error.localizedDescription)")
//        }
//    }
//
//}
//
//Users/siddhatech/Downloads/BhushanTraining/ExpenseTracker/ExpenseTracker/sample_data.json
//url    Foundation.URL    //"file:///Users/siddhatech/Library/Developer/CoreSimulator/Devices/418C0AA1-AFF1-45C3-BCC0-B38FB818003A/data/Containers/Bundle/Application/8BF9114D-D22C-4C36-9AFC-7B5F83CE67C2/ExpenseTracker.app/sample_data.json"



/*Another Way to load json data into Data Model */
//
//func loadSampleData() {
//    if let url = Bundle.main.url(forResource: "sample_data", withExtension: "json") {
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM/dd/yyyy" // Adjust this format to match your JSON date format
//            decoder.dateDecodingStrategy = .formatted(dateFormatter)
//            
//            let decodedTransactions = try decoder.decode([Transaction].self, from: data)
//            self.transactions = decodedTransactions
//        } catch let decodingError as DecodingError {
//            switch decodingError {
//            case .dataCorrupted(let context):
//                print("Data corrupted: \(context.debugDescription)")
//            case .keyNotFound(let key, let context):
//                print("Key '\(key)' not found: \(context.debugDescription)")
//            case .typeMismatch(let type, let context):
//                print("Type mismatch for type \(type): \(context.debugDescription)")
//            case .valueNotFound(let value, let context):
//                print("Value not found for type \(value): \(context.debugDescription)")
//            @unknown default:
//                print("Unknown decoding error: \(decodingError)")
//            }
//        } catch {
//            print("Failed to decode JSON: \(error)")
//        }
//    } else {
//        print("File not found")
//    }
//}
