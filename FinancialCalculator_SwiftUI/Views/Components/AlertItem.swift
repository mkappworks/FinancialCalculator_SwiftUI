//
//  AlertItem.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-28.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?
}

enum AlertContext {

    static let invalidValues = AlertItem(title: Text("Entered Invalid parameters"),
                                            message: Text("The input parameter invalid. Please enter values greater than 0"),
                                            dismissButton: .default(Text("Ok")))
    
    static let unableToComplete = AlertItem(title: Text("File Error"),
                                            message: Text("Unable to complete your request at this time. Please try again connection."),
                                            dismissButton: .default(Text("Ok")))
}

enum MonetaryError: Error {
    case invalidValues
    case unableToComplete
}
