//
//  HistoryView.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-19.
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var coreDataViewModel = CoreDataViewModel()
    
    var body: some View {
        ZStack {
            NavigationView{
                List{
                    ForEach(coreDataViewModel.savedEntities, id:\.self){entry in
                        MonetaryEntityCell(monetaryEntity: entry)
                    }
                    .onDelete(perform: coreDataViewModel.deleteMonetaryData)
                }
                .navigationTitle("History")
            }
            
            .onAppear{
                coreDataViewModel.fetchAllMonetary()
        }
            
            if coreDataViewModel.isLoading { LoadingView() }
        }
    }
        
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
