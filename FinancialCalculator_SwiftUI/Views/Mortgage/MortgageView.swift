////
////  MortgageView.swift
////  FinancialCalculator_SwiftUI
////
////  Created by Malith Kuruppu on 2022-07-22.
////
//
//import SwiftUI
//
//
//struct MortgageView: View {
//
//    @State private var monetaryType: MonetaryType = MonetaryType.Loan
//    @State private var isDepositMadeInEnd: Bool = true
//    @State private var depositType: DepositType = DepositType.End
//    @State private var calculationParameter: CalculationParameter = CalculationParameter.numberOfPayment
//    
//    @ViewBuilder
//    var body: some View {
//        NavigationView{
//            VStack {
//                Form{
//                    Section("Select Monetary Type"){
//                        Picker("Monetary Type", selection: $monetaryType) {
//                            ForEach(MonetaryType.allCases, id: \.self) {
//                                Text($0.rawValue)
//                                .font(.system(size: 20))
//                                
//                            }
//                            
//                        }
//                        .onChange(of: monetaryType, perform: { value in
//                            if (value == MonetaryType.CompoundSaving && calculationParameter == CalculationParameter.payment){
//                                calculationParameter = CalculationParameter.futureValue
//                            }
//                        })
//                        .frame(height: 50)
//                        .pickerStyle(.wheel)
//                        
//                    }
//                    
//                    Section("Select Calculation Parameter"){
//                        Picker("Calculation Parameter", selection: $calculationParameter) {ForEach(CalculationParameter.allCases, id: \.self) {
//                            if(monetaryType != MonetaryType.CompoundSaving || $0 != CalculationParameter.payment){
//                                Text($0.rawValue)
//                                    .font(.system(size: 20))
//                            }
//                        }
//                            
//                        }
//                        .frame(height: 50)
//                        .pickerStyle(.wheel)
//                        
//                    }
//                    
//                    CalculationParameterView(calculationParameter: $calculationParameter, monetaryType: $monetaryType)
//                    
//                    if(monetaryType != MonetaryType.CompoundSaving){
//                        Section("Select When Deposits are Made") {
//                            Toggle("\(depositType.rawValue)", isOn: $isDepositMadeInEnd)
//                                .toggleStyle(SwitchToggleStyle(tint: .red))
//                                .onChange(of: isDepositMadeInEnd) { value in
//                                    depositType =  value == true ? DepositType.End : DepositType.Beginning
//                                }
//                            
//                        }
//                    }
//                    
//                    Button("Calculate"){
//                        print("Clear Tapped")
//                    }
//                    .buttonStyle(BorderlessButtonStyle())
//                
//                    
//                }
//                .navigationTitle(monetaryType.rawValue)
//                .onTapGesture{hideKeyboard()}
//                .toolbar{
//                    ToolbarItemGroup(placement: .navigationBarTrailing){
//                        Button{
//                            print("Save Tapped")
//                        }label: {
//                            Text("Save")
//                        }
//                        
//                        Button{
//                            print("Clear Tapped")
//                        }label: {
//                            Text("Reset")
//                        }
//                    }
//                    
//                    
//                }
//                
//            }
//            .accentColor(.red)
//            
//            
//        }
//    }
//}
//
//
//#if canImport(UIKit)
//extension View{
//    func hideKeyboard(){
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
//#endif
//
//struct MortgageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MortgageView()
//    }
//}
//
