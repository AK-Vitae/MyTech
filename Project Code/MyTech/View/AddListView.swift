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
    @State private var techType: String = "Normal"
    
    let techTypes = ["Device", "Component", "Accesory"]
    // MARK: - BODY
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    // MARK: - TECH NAME
                    TextField("Tech", text: $name)
                    
                    // MARK: - TECH TYPE
                    Picker("Tech Type", selection: $techType){
                        ForEach(techTypes, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
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

