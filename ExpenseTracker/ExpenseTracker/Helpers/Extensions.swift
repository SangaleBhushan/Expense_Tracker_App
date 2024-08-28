//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Siddhatech on 27/08/24.
//

import Foundation
import SwiftUI
extension Color{
    static let systemBackground =  Color(uiColor: .systemBackground)
   static let Background = Color("Background")
   static let Icon = Color("icon")
   static let Text  = Color("Text")
}

extension DateFormatter{
    static let allnumericUSA : DateFormatter={
        print("initializing  date formatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}


extension String{
    func dateParsed()->Date{
        guard let parsedDate = DateFormatter.allnumericUSA.date(from: self) else { return Date()}
        
        return parsedDate
    }
}
extension Date{
    func formatted()->String{
        return self.formatted(.dateTime.year().month().day())
    }
}
