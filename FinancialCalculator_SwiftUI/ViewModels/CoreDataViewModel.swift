//
//  CoreDataViewModel.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-28.
//

import Foundation
import CoreData
import SwiftUI


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
    
    func addMonetaryData(monetary: Monetary, monetaryType: MonetaryType){
        let newMonetaryEntry = MonetaryEntity(context: container.viewContext)
        newMonetaryEntry.id = monetary.id
        newMonetaryEntry.payment = monetary.payment
        newMonetaryEntry.futureValue = monetary.futureValue
        newMonetaryEntry.presentValue = monetary.presentValue
        newMonetaryEntry.interestRate = monetary.interestRate
        newMonetaryEntry.numberOfPayment = Int64(monetary.numberOfPayment)
        newMonetaryEntry.monetaryType = monetaryType.rawValue

        saveMonetaryData()
    }
    
    func saveMonetaryData(){
        self.isLoading = true
        
        do{
          try container.viewContext.save()
          fetchAllMonetary()
        } catch let error {
            print("Error fetch \(error)")
        }
        
        self.isLoading = false
    }
    
    func deleteMonetaryData(indexSet: IndexSet){
        
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        
        container.viewContext.delete(entity)
        
        saveMonetaryData()
        
    }
    
    
}
