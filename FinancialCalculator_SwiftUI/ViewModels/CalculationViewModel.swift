//
//  HomeViewModel.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-27.
//
import Foundation



final class CalculationViewModel: ObservableObject{
    
    @Published var isPaymentAvailable: Bool =  false
    @Published var alertMessage: String = ""
    @Published var isAlertMessage: Bool=false
    @Published var monetaryType: MonetaryType = MonetaryType.Loan
    @Published var isDepositMadeInEnd: Bool = true
    @Published var depositType: DepositType = DepositType.End
    @Published var calculationParameter: CalculationParameter = CalculationParameter.numberOfPayment
    
    @Published var monetary: Monetary = Monetary(numberOfPayment: 1, interestRate: 0.0, presentValue: 0.0, futureValue: 0.0, payment: 0.0 )
    
    var invalidFields: [String] = [""]
    var interestCompoundedPerUnitTime: Int = 1
    
    /**
     Checking if the payment is needed as a input or output parameter
    
     Only if the MonetaryType is not CompoundSaving and the CalculationParameter is futureValue or payment the
     
     payment parameter is available in the UI
     **/
    func checkIfPaymentAvailable(){
        if(self.monetaryType == MonetaryType.CompoundSaving){
            self.isPaymentAvailable = false
            return
        }
        
        if(self.monetaryType != MonetaryType.CompoundSaving && self.calculationParameter == CalculationParameter.futureValue){
            self.isPaymentAvailable = true
            return
        }
        
        if(self.monetaryType != MonetaryType.CompoundSaving && self.calculationParameter == CalculationParameter.payment){
            self.isPaymentAvailable = true
            return
        }
        
        self.isPaymentAvailable = false
    }
    
    func resetCalculationParameter(){
        self.monetaryType = MonetaryType.Loan
        self.calculationParameter = CalculationParameter.numberOfPayment
        self.monetary = Monetary(numberOfPayment: 1, interestRate: 0.0, presentValue: 0.0, futureValue: 0.0, payment: 0.0)
    }
    
    func calculateParameter(){
        invalidFields = [""]
        alertMessage = ""
        isAlertMessage = false
        
     switch self.calculationParameter{
            case .numberOfPayment: calculateNumberOfPayment()
            case .interestRate: calculateInterestRate()
            case .presentValue: calculatePresentValue()
            case .payment: calculatePayment()
            case .futureValue: calculateFutureValue()
            }
    }
    
    private func calculateNumberOfPayment(){
        /**
         Checking if the numberOfPayments has all the input parameter to calculate it
         if atleast ones of the neccessary parameters are missing, will return from the func with an
         error message
         */
        checkValidInterestRate()
        checkValidPresentValue()
        checkValidFutureValue()
        
        if(self.invalidFields.count > 1){
            assignErrorMessage()
            print(self.invalidFields)
            return
        }
        
        /**
         Calculation broken down in bit sizes
         */
        let a: Double = log(self.monetary.futureValue/self.monetary.presentValue)
        let b: Double = log(1.0 + self.monetary.interestRate/(100 * Double(interestCompoundedPerUnitTime))) * Double(interestCompoundedPerUnitTime)
        
        
        if(monetaryType == MonetaryType.Mortgage){
            self.monetary.numberOfPayment = Int((a/(b * 12)).rounded(.up))
        } else {
            self.monetary.numberOfPayment = Int((a/b).rounded(.up))
        }
 
        
    }
    
    private func calculateInterestRate(){
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
        if(isPaymentAvailable){checkValidPayment()}
        
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
        if(isPaymentAvailable){checkValidPayment()}
        
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
            futureValueWithContribution = calculateFutureValueWithContributionAtEndMultipler() * self.monetary.payment
        }
        
        if(monetaryType != MonetaryType.CompoundSaving && !isDepositMadeInEnd){
            futureValueWithContribution = calculateFutureValueWithContributionAtBeginMultipler() * self.monetary.payment
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
        
        self.alertMessage = "Please enter valid \(joinedFieldName) to calculate the desired parameter"
        
        self.isAlertMessage = true
        
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




