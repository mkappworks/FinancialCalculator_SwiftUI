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
        
        
        if(monetaryType == MonetaryType.Mortgage){
            self.monetary.numberOfPayment = Int((a/(b * 12)).rounded(.up))
        } else {
            self.monetary.numberOfPayment = Int((a/b).rounded(.up))
        }
        
        
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
        
        let timeInMonths: Double = getNumberOfPaymentsInMonths()
        
        let a: Double = 1.0/(Double(interestCompoundedPerUnitTime) * timeInMonths)
        
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
        
        let timeInMonths: Double = getNumberOfPaymentsInMonths()
        
        let a: Double = (self.monetary.interestRate/(100 * Double(interestCompoundedPerUnitTime))) + 1
        let b: Double = Double(interestCompoundedPerUnitTime) * timeInMonths
        
        self.monetary.presentValue = self.monetary.futureValue / pow(a, b)
        
    }
    
    private func calculatePayment(){
        
        if(monetaryType == MonetaryType.CompoundSaving){
            return
        }
        
        checkValidNumberOfPayment()
        checkValidInterestRate()
        checkValidPresentValue()
        checkValidFutureValue()
        
        if(self.invalidFields.count > 1){
            assignErrorMessage()
            return
        }
        
        
        let compoundInterestForPrincipal: Double = calculateFutureValueWithOutContribution()
        let futureValueWithContribution: Double = self.monetary.futureValue
        var contributionMultipler: Double!

        if(monetaryType != MonetaryType.CompoundSaving && isDepositMadeInEnd){
            contributionMultipler = calculateFutureValueWithContributionAtEndMultipler()
        }
        
        if(monetaryType != MonetaryType.CompoundSaving && !isDepositMadeInEnd){
            contributionMultipler = calculateFutureValueWithContributionAtBeginMultipler()
        }
        
        self.monetary.payment = (futureValueWithContribution - compoundInterestForPrincipal)/(contributionMultipler)
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
        
        let compoundInterestForPrincipal: Double = calculateFutureValueWithOutContribution()
        var futureValueWithContribution: Double = 0.0

        if(monetaryType != MonetaryType.CompoundSaving && isDepositMadeInEnd){
            futureValueWithContribution = calculateFutureValueWithContributionAtEndMultipler() * self.monetary.payment!
        }
        
        if(monetaryType != MonetaryType.CompoundSaving && !isDepositMadeInEnd){
            futureValueWithContribution = calculateFutureValueWithContributionAtBeginMultipler() * self.monetary.payment!
        }
        
        self.monetary.futureValue = compoundInterestForPrincipal + futureValueWithContribution

    }
    
    private func calculateCompoundInterestMultipler() -> Double{
        let timeInMonths: Double = getNumberOfPaymentsInMonths()
        
        let a: Double = (self.monetary.interestRate/(100 * Double(interestCompoundedPerUnitTime))) + 1
        let b: Double = Double(interestCompoundedPerUnitTime) * timeInMonths
        
        return pow(a, b)
    }
    
    private func calculateFutureValueWithOutContribution() -> Double{     
        return self.monetary.presentValue * calculateCompoundInterestMultipler()
    }
    
    private func calculateFutureValueWithContributionAtEndMultipler() -> Double{
        let a: Double = calculateCompoundInterestMultipler() - 1
        let b: Double = self.monetary.interestRate/(100 * Double(interestCompoundedPerUnitTime))
        
        return a/b
    }
    
    private func calculateFutureValueWithContributionAtBeginMultipler() -> Double{
        let a: Double = calculateFutureValueWithContributionAtEndMultipler()
        let b: Double = self.monetary.interestRate/(100 * Double(interestCompoundedPerUnitTime)) + 1
        
        return a * b
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
    
    private func getNumberOfPaymentsInMonths()-> Double{
        var timeInMonths: Double
        
        if(monetaryType ==  MonetaryType.Mortgage){
            timeInMonths = Double(self.monetary.numberOfPayment) * 12
        }else{
            timeInMonths = Double(self.monetary.numberOfPayment)
        }
        
        return timeInMonths
    }
    
}




