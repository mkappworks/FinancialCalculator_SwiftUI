//
//  Page.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-28.
//

import Foundation

/**
 Mainly used in the HelpView
 */
struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePages: [Page] = [
        Page(name: "Welcome to Financial Calculator!", description: "The best app to get started with financial planning", imageUrl: "Intro", tag: 0),
        
        Page(name: "Select the Monetary Action", description: "Select the Monetary Action from the picker wheel to best fit your requirement. You can choose between Loan, Mortgage, Saving, Compound Saving", imageUrl: "SelectMonetaryType", tag: 1),
        
        Page(name: "Select the Calculation Parameter", description: "Select the Calculation Parameter from the picker wheel to best fit your requirement.", imageUrl: "SelectCalParameter", tag: 2),
        
        Page(name: "Input Valid Parameters", description: "Please enter invalid value for fields other than the ones disabled", imageUrl: "InputParameter", tag: 3),
        
        Page(name: "Select When you want to Deposit", description: "Only applies to Loan, Mortgage, Saving when calculating for the Future Value or Payment", imageUrl: "SelectEnd", tag: 4),
        
        Page(name: "Click Calculate", description: "By pressing Calculate you will get a value for the parameter you selected in Calculation Parameter", imageUrl: "ClickOnCal", tag: 5),
        
        Page(name: "Save or Reset", description: "Once you are satisfied with results you can save the data for later view. Or you can reset the Home View to start all over again", imageUrl: "SaveAndReset", tag: 6),
        
        Page(name: "History", description: "Visit history page to view all you previous calculation that were saved. You can delete any record by selecting and swiping to the left", imageUrl: "HistoryPage", tag: 7),
        
    ]
}
