//
//  HomeView.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-19.
//

import SwiftUI


struct HomeView: View {

    @StateObject private var calculationViewModel = CalculationViewModel()
    @StateObject private var coreDataViewModel = CoreDataViewModel()
    
    @ViewBuilder
    var body: some View {
        NavigationView{
                Form{
                    Section("Select Monetary Type"){
                        Picker("Monetary Type", selection: $calculationViewModel.monetaryType) {
                            ForEach(MonetaryType.allCases, id: \.self) {
                                Text($0.rawValue)
                                .font(.system(size: 20))
                                
                            }
                            
                        }
                        .onChange(of: calculationViewModel.monetaryType, perform: { value in
                            if (value == MonetaryType.CompoundSaving && calculationViewModel.calculationParameter == CalculationParameter.payment){
                                calculationViewModel.calculationParameter = CalculationParameter.futureValue
                            }
                        })
                        .frame(height: 50)
                        .pickerStyle(.wheel)
                        
                    }
                    
                    Section("Select Calculation Parameter"){
                        Picker("Calculation Parameter", selection: $calculationViewModel.calculationParameter) {ForEach(CalculationParameter.allCases, id: \.self) {
                            if(calculationViewModel.monetaryType != MonetaryType.CompoundSaving || $0 != CalculationParameter.payment){
                                Text($0.rawValue)
                                    .font(.system(size: 20))
                            }
                        }
                            
                        }
                        .frame(height: 50)
                        .pickerStyle(.wheel)
                        
                    }
                    
                    CalculationParameterView(calculationParameter: $calculationViewModel.calculationParameter, monetaryType: $calculationViewModel.monetaryType,
                        monetary: $calculationViewModel.monetary
                    )
                    
                    if(calculationViewModel.monetaryType != MonetaryType.CompoundSaving){
                        Section("Select When Deposits are Made") {
                            Toggle("\(calculationViewModel.depositType.rawValue)", isOn: $calculationViewModel.isDepositMadeInEnd)
                                .toggleStyle(SwitchToggleStyle(tint: .red))
                                .onChange(of: calculationViewModel.isDepositMadeInEnd) { value in
                                    calculationViewModel.depositType =  value == true ? DepositType.End : DepositType.Beginning
                                }
                            
                        }
                    }
                    
                    Button("Calculate"){
                        calculationViewModel.calculateParameter()
                        
                    }
                    .buttonStyle(BorderlessButtonStyle())
                
                    
                }
                .navigationTitle(calculationViewModel.monetaryType.rawValue)
                .onTapGesture{hideKeyboard()}
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button{
                            coreDataViewModel.saveMonetaryData(monetary: calculationViewModel.monetary, monetaryType: calculationViewModel.monetaryType)
                        }label: {
                            Text("Save")
                        }
                        
                        Button{
                            calculationViewModel.resetCalculationParameter()
                        }label: {
                            Text("Reset")
                        }
                    }
                    
                    
                }
            .accentColor(.red)
//            .alert(item: $viewModel.alertItem) { alertItem in
//                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
//            }
            
            
        }
    }
}


#if canImport(UIKit)
extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?
}
