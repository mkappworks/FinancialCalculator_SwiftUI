//
//  HomeView.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-19.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing:20){
            CardView(image: "savings", imageTitle: "Savings")
    
            CardView(image: "loan", imageTitle: "Loans")
            
            CardView(image: "mortgage", imageTitle: "Mortgage")
        }
        
    }
}

struct CardView: View {
    var image: String
    var imageTitle: String
    
    var body: some View {
        VStack{
            Image(image)
            Text(imageTitle)
        }
        .frame(width: 200,height: 200)
        .border(.black, width: 4)
        .cornerRadius(10)
        .padding()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
