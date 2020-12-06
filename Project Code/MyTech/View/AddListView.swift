//
//  AddListView.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 2/8/21.
//
import SwiftUI

struct AddListView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var serialNumber: String = ""
    @State private var productNumber: String = ""
    @State private var modelNumber: String = ""
    @State private var dateAcquired: Date = Date()
    @State private var text = ""
    @State private var techType: String = "Device"
    
    let techTypes = ["Device", "Component", "Accesory"]
    
    @State private var errorShowing: Bool = false
    @State private var erroTitle: String = ""
    @State private var errorMessage: String = ""
    
    
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
                        if self.name != ""{
                            let tech = Tech(context: self.managedObjectContext)
                            tech.name = self.name
                            tech.techType = self.techType
                            tech.dateAcquired = self.dateAcquired
                            tech.serialNumber = self.serialNumber
                            tech.productNumber = self.productNumber
                            tech.modelNumber = self.modelNumber
                            tech.text = self.text
                            
                            do {
                                try self.managedObjectContext.save()
                                print("New Tech: \(tech.name ?? ""), Tech Type: \(tech.techType ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.erroTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for \nthe new tech item"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
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
            .alert(isPresented: $errorShowing){
                Alert(title: Text(erroTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW
struct AddListView_Previews: PreviewProvider {
    static var previews: some View {
        AddListView()
    }
}

