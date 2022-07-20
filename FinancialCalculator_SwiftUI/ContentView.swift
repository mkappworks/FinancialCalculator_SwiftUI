//
//  ContentView.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
                TabView{
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    HistoryView()
                        .tabItem {
                            Image(systemName: "building.columns.fill")
                            Text("History")
                        }
                    HelpView()
                        .tabItem {
                            Image(systemName: "questionmark")
                            Text("Help")
                        }
                    
                    
                }
                .background(.gray)
                
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

