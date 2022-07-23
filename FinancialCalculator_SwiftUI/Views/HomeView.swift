//
//  HomeView.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-19.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing:20){
                NavigationLinkCardView(destinationView: MortgageView(), image: "savings", imageTitle: "Savings")
        
                NavigationLinkCardView(destinationView: MortgageView(), image: "loan", imageTitle: "Loans")
                
                NavigationLinkCardView(destinationView: MortgageView(), image: "mortgage", imageTitle: "Mortgage")
            }
        }
        
    }
}

struct NavigationLinkCardView<Content: View>: View {
    var destinationView: Content
    var image: String
    var imageTitle: String

    init(destinationView: Content, image: String, imageTitle:String) {
        self.destinationView = destinationView
        self.image = image
        self.imageTitle = imageTitle
    }

    var body: some View {
        NavigationLink(destination:destinationView) {
            VStack{
                Image(image)
                Text(imageTitle)
                    .foregroundColor(.black)
            }
            .frame(width: 200,height: 200)
            .border(.black, width: 4)
            .cornerRadius(10)
        .padding()
        }
        
    }
}

//
//struct NavigationLinkCardView: View {
//    var destination: View
//    var image: String
//    var imageTitle: String
//
//    var body: some View {
//        NavigationLink(destination: destination) {
//            VStack{
//                Image(image)
//                Text(imageTitle)
//            }
//            .frame(width: 200,height: 200)
//            .border(.black, width: 4)
//            .cornerRadius(10)
//        .padding()
//        }
//
//    }
//}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
