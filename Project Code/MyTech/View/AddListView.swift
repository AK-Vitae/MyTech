//
//  AddListView.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 2/8/21.
//
import SwiftUI

struct AddListView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var serialNumber: String = ""
    @State private var productNumber: String = ""
    @State private var modelNumber: String = ""
    @State private var dateAcquired: Date = Date()
    @State private var text = ""
    @State private var techType: String = "Device"
    
    let techTypes = ["Device", "Component", "Accesory"]
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Section(header: Text("Details")){
                        // MARK: - TECH NAME
                        TextField("Tech Name", text: $name)
                        
                        // MARK: - TECH TYPE
                        Picker("Tech Type", selection: $techType){
                            ForEach(techTypes, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        // MARK: - DATE ACQUIRED
                        DatePicker("Date Acquired", selection: $dateAcquired, displayedComponents: .date)
                        
                        // MARK: - SERIAL NUMBER
                        TextField("Serial Number", text: $serialNumber)
                        
                        // MARK: - PRODUCT NUMBER
                        TextField("Product Number", text: $productNumber)
                        
                        // MARK: - MODEL NUMBER
                        TextField("Model Number", text: $modelNumber)
                    }//: Section 1
                    
                    Section(header: Text("ADDITIONAL INFORMATION")){
                        // MARK: - DETAILS
                        TextEditor(text: $text)
                    }//: Section 2
                    
                    // MARK: - SAVE BUTTON
                    Button(action: {
                        print("Save a new tech item")
                    }) {
                        Text("Save")
                    } //: SAVE BUTTON
                } //: FORM
                Spacer()
            } //: VSTACK
            .navigationBarTitle("New Item", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                                } ){
                                    Image(systemName: "xmark")
                                }
            )
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW
struct AddListView_Previews: PreviewProvider {
    static var previews: some View {
        AddListView()
    }
}

