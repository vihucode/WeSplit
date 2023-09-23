//
//  ContentView.swift
//  WeSplit
//
//  Created by Vili Huotari on 20.9.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkamount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPrecent = 20
    @State private var tipAmount = 0
    @State private var tipDefault = "Percentage"
    @FocusState private var amountIsFocused: Bool

    
    let tip = ["Amount", "Percentage"]
    var totalAmount: Double {
        var tipSelection = 0.0
        var tipValue = 0.0
        if (tipDefault == "Percentage"){
            tipSelection = Double(tipPrecent)
            tipValue = checkamount / 100 * tipSelection
        }else {
            tipValue = Double(tipAmount)
        }
        
        let grandTotal = checkamount + tipValue
        
        return grandTotal
    }
    
    var totalperPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)

        let amountPerPerson = totalAmount / peopleCount
        
        return amountPerPerson
    }

    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkamount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "EURO"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<11){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("", selection: $tipDefault) {
                        ForEach(tip, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    if (tipDefault == "Percentage"){
                        Picker("", selection: $tipPrecent) {
                            ForEach(0..<101, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .padding(.trailing, 125)
                    }else {
                        Picker("", selection: $tipAmount) {
                            ForEach(0..<Int(checkamount + 1), id: \.self) {
                                Text($0, format: .currency(code: Locale.current.currency?.identifier ?? "EURO"))
                            }
                        }
                        .padding(.trailing, 125)
                    }

                }header: {
                    Text("Tip")
                }
                
                Section{
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EURO"))
                }header: {
                    Text("Total amount")
                }
                
                Section{
                    Text(totalperPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EURO"))
                }header: {
                    Text("Amout per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
