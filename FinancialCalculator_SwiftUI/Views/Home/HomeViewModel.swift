//
//  HomeViewModel.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-27.
//
import Foundation



final class HomeViewModel: ObservableObject{
    
    @Published var alertMessage: String = ""
    @Published var monetaryType: MonetaryType = MonetaryType.Loan
    @Published var isDepositMadeInEnd: Bool = true
    @Published var depositType: DepositType = DepositType.End
    @Published var calculationParameter: CalculationParameter = CalculationParameter.numberOfPayment
    
    @Published var monetary: Monetary = Monetary(numberOfPayment: 1, interestRate: 0.0, presentValue: 0.0, payment: 0.0, futureValue: 0.0)
    
    var invalidFields: [String] = [""]
    var interestCompoundedPerUnitTime: Int = 1
    
    
    func resetCalculationParameter(){
        print("reset")
        self.monetary = Monetary(numberOfPayment: 1, interestRate: 0.0, presentValue: 0.0, payment: 0.0, futureValue: 0.0)
    }
    
    func calculateParameter(){
        invalidFields = [""]

        
        switch self.calculationParameter{
        case .numberOfPayment: calculateNumberOfPayment()
        case .interestRate: calculateInterestRate()
        case .presentValue: calculatePresentValue()
        case .payment: calculatePayment()
        case .futureValue: calculateFutureValue()
        }
    }
    
    private func calculateNumberOfPayment(){
        if(monetaryType != MonetaryType.CompoundSaving){
            checkValidPayment()
        }
        checkValidInterestRate()
        checkValidPresentValue()
        checkValidFutureValue()
        
        if(self.invalidFields.count > 1){
            assignErrorMessage()
            return
        }
        
        let a: Double = log(self.monetary.futureValue/self.monetary.presentValue)
        let b: Double = log(1.0 + self.monetary.interestRate/(100 * Double(interestCompoundedPerUnitTime))) * Double(interestCompoundedPerUnitTime)
        
        self.monetary.numberOfPayment = Int((a/b).rounded(.up))
        
    }
    
    private func calculateInterestRate(){
        if(monetaryType != MonetaryType.CompoundSaving){
            checkValidPayment()
        }
        checkValidNumberOfPayment()
        checkValidPresentValue()
        checkValidFutureValue()
        
        if(self.invalidFields.count > 1){
            assignErrorMessage()
            return
        }
        
        let a: Double = 1.0/(Double(interestCompoundedPerUnitTime) * Double(self.monetary.numberOfPayment))
        
        let b: Double = self.monetary.futureValue/self.monetary.presentValue
        
        self.monetary.interestRate = Double(interestCompoundedPerUnitTime) * ( pow(b,a) - 1) * 100
    }
    
    private func calculatePresentValue(){
        if(monetaryType != MonetaryType.CompoundSaving){
            checkValidPayment()
        }
        checkValidNumberOfPayment()
        checkValidInterestRate()
        checkValidFutureValue()
        
        if(self.invalidFields.count > 1){
            assignErrorMessage()
            return
        }
        
        let a: Double = (self.monetary.interestRate/(100 * Double(interestCompoundedPerUnitTime))) + 1
        let b: Double = Double(interestCompoundedPerUnitTime) * Double(self.monetary.numberOfPayment)
        
        self.monetary.presentValue = self.monetary.futureValue / pow(a, b)
        
    }
    
    private func calculatePayment(){
        checkValidNumberOfPayment()
        checkValidInterestRate()
        checkValidPresentValue()
        checkValidFutureValue()
        
        if(self.invalidFields.count > 1){
            assignErrorMessage()
            return
        }
    }
    
    private func calculateFutureValue(){
        if(monetaryType != MonetaryType.CompoundSaving){
            checkValidPayment()
        }
        checkValidNumberOfPayment()
        checkValidInterestRate()
        checkValidPresentValue()
        
        if(self.invalidFields.count > 1){
            assignErrorMessage()
            return
        }
        
    }
    
    
    private func checkValidNumberOfPayment(){
        if(self.monetary.numberOfPayment == 0){
            self.invalidFields.append(CalculationParameter.numberOfPayment.rawValue)
        }
    }
    
    private func checkValidInterestRate(){
        if(self.monetary.interestRate == 0){
            self.invalidFields.append(CalculationParameter.interestRate.rawValue)
        }
    }
    
    private func checkValidPresentValue(){
        if(self.monetary.presentValue == 0){
            self.invalidFields.append(CalculationParameter.presentValue.rawValue)
        }
    }
    
    private func checkValidPayment(){
        if(self.monetary.payment == 0){
            self.invalidFields.append(CalculationParameter.payment.rawValue)
        }
    }
    
    private func checkValidFutureValue(){
        if(self.monetary.futureValue == 0){
            self.invalidFields.append(CalculationParameter.futureValue.rawValue)
        }
    }
    
    private func assignErrorMessage(){
        let joinedFieldName = self.invalidFields.joined(separator:",")
        
        alertMessage = "Please enter valid \(joinedFieldName) to calculate the desired parameter"
    }
    
}




