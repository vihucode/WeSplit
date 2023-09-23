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
    @FocusState private var amountIsFocused: Bool
    
    let tipPrecentages = [10, 15, 20, 25, 0]
    
    var totalperPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPrecent)
        
        let tipValue = checkamount / 100 * tipSelection
        let grandTotal = checkamount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
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
                        ForEach(2..<10){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("Tip percentage", selection: $tipPrecent) {
                        ForEach(tipPrecentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }header: {
                    Text("Tip percentage")
                }
                
                Section{
                    Text(totalperPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EURO"))
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
