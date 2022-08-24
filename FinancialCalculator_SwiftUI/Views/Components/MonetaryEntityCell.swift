//
//  MonetaryEntityCell.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-28.
//

import SwiftUI


struct MonetaryEntityCell: View {
    
    var monetaryEntity: MonetaryEntity
    var numberOfPaymentUnit: String
    
    init(monetaryEntity: MonetaryEntity){
        self.monetaryEntity = monetaryEntity
        if(monetaryEntity.monetaryType == MonetaryType.Mortgage.rawValue){
            numberOfPaymentUnit = "years"
        }else{
            numberOfPaymentUnit = "months"
        }
        
    }
    
    var body: some View {
        HStack {
            Image("\(monetaryEntity.monetaryType)")
                .resizable()
                .frame(width:50, height: 50)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 5) {
                Text(monetaryEntity.monetaryType)
                    .font(.title3)
                    .fontWeight(.medium)
                
                MonetaryTextCell(title: "Number of Payments (\(numberOfPaymentUnit)) ", value: "\(monetaryEntity.numberOfPayment)")
                
                MonetaryTextCell(title: "Interest Rate ", value: "\(monetaryEntity.interestRate)%")
                
                MonetaryTextCell(title: "Present Value LKR ", value: "\(monetaryEntity.presentValue)")
                
                if(monetaryEntity.monetaryType != MonetaryType.CompoundSaving.rawValue){
                    MonetaryTextCell(title: "Payment LKR ", value: "\(monetaryEntity.payment)")
                }
               
                MonetaryTextCell(title: "Future Value LKR ", value: "\(monetaryEntity.futureValue)")

            }
            .padding(.leading)
        }
    }
}


struct MonetaryTextCell: View {
                             
    var title: String
    var value: String
                             
    var body: some View {
        HStack{
            Text(title)
                .foregroundColor(.secondary)
            .fontWeight(.semibold)
            Text(value)
            .foregroundColor(.primary)
            .fontWeight(.bold)
        }
    }
}


