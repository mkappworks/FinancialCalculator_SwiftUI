//
//  CoreDataViewModel.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-28.
//

import Foundation
import CoreData


final class CoreDataViewModel: ObservableObject{
    let container: NSPersistentContainer
    @Published var savedEntities:[MonetaryEntity] = []
    @Published var isLoading = false
    
    init(){
        container = NSPersistentContainer(name: "Monetary")
        container.loadPersistentStores{(description, error) in
            if let error = error {
                print("error \(error)")
            }else{
                print("Successfully loaded core data")
            }
        }
    }
    
    func fetchAllMonetary(){
        self.isLoading = true
        let request = NSFetchRequest<MonetaryEntity>(entityName: "MonetaryEntity")
        
        do{
          savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetch \(error)")
        }
        
        self.isLoading = false
        
    }
    
    func saveMonetaryData(monetary: Monetary, monetaryType: MonetaryType){
        self.isLoading = true
        
        let newMonetaryEntry = MonetaryEntity(context: container.viewContext)
        newMonetaryEntry.id = monetary.id
        newMonetaryEntry.payment = monetary.payment ?? 0.0
        newMonetaryEntry.futureValue = monetary.futureValue
        newMonetaryEntry.presentValue = monetary.presentValue
        newMonetaryEntry.interestRate = monetary.interestRate
        newMonetaryEntry.numberOfPayment = Int16(monetary.numberOfPayment)
        newMonetaryEntry.monetaryType = monetaryType.rawValue
        
        do{
          try container.viewContext.save()
        } catch let error {
            print("Error fetch \(error)")
        }
        
        self.isLoading = false
    }
    
    
}
