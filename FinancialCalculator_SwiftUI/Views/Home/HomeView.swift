//
//  HomeView.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-19.
//

import SwiftUI


struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()
    
    @ViewBuilder
    var body: some View {
        NavigationView{
            
                Form{
                    Section("Select Monetary Type"){
                        Picker("Monetary Type", selection: $viewModel.monetaryType) {
                            ForEach(MonetaryType.allCases, id: \.self) {
                                Text($0.rawValue)
                                .font(.system(size: 20))
                                
                            }
                            
                        }
                        .onChange(of: viewModel.monetaryType, perform: { value in
                            if (value == MonetaryType.CompoundSaving && viewModel.calculationParameter == CalculationParameter.payment){
                                viewModel.calculationParameter = CalculationParameter.futureValue
                            }
                        })
                        .frame(height: 50)
                        .pickerStyle(.wheel)
                        
                    }
                    
                    Section("Select Calculation Parameter"){
                        Picker("Calculation Parameter", selection: $viewModel.calculationParameter) {ForEach(CalculationParameter.allCases, id: \.self) {
                            if(viewModel.monetaryType != MonetaryType.CompoundSaving || $0 != CalculationParameter.payment){
                                Text($0.rawValue)
                                    .font(.system(size: 20))
                            }
                        }
                            
                        }
                        .frame(height: 50)
                        .pickerStyle(.wheel)
                        
                    }
                    
                    CalculationParameterView(calculationParameter: $viewModel.calculationParameter, monetaryType: $viewModel.monetaryType,
                        monetary: $viewModel.monetary
                    )
                    
                    if(viewModel.monetaryType != MonetaryType.CompoundSaving){
                        Section("Select When Deposits are Made") {
                            Toggle("\(viewModel.depositType.rawValue)", isOn: $viewModel.isDepositMadeInEnd)
                                .toggleStyle(SwitchToggleStyle(tint: .red))
                                .onChange(of: viewModel.isDepositMadeInEnd) { value in
                                    viewModel.depositType =  value == true ? DepositType.End : DepositType.Beginning
                                }
                            
                        }
                    }
                    
                    Button("Calculate"){
                        viewModel.calculateParameter()
                        
                    }
                    .buttonStyle(BorderlessButtonStyle())
                
                    
                }
                .navigationTitle(viewModel.monetaryType.rawValue)
                .onTapGesture{hideKeyboard()}
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button{
                            print("Save Tapped")
                        }label: {
                            Text("Save")
                        }
                        
                        Button{
                            viewModel.resetCalculationParameter()
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
