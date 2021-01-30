//
//  AddListView.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 8/29/20.
//
import SwiftUI

struct AddListView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var imageData: Data = .init(count: 0)
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
    @State var imageShowing: Bool = false
    
    init() {
            UITextView.appearance().backgroundColor = .clear
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            VStack {
                ScrollView{
                    VStack(alignment: .center){
                        if self.imageData.count != 0 {
                            Button (action: {
                                self.imageShowing.toggle()
                            }) {
                                Image(uiImage: UIImage(data: self.imageData)!)
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                                    .cornerRadius(6)
                            }
                        } else {
                            Button(action: {
                                self.imageShowing.toggle()
                            }) {
                                Image(systemName: "photo.fill")
                                    .font(.system(size: 200))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .sheet(isPresented: self.$imageShowing, content: {
                        ImagePicker(show: self.$imageShowing, image: self.$imageData)
                    })
//                    .padding(.horizontal)
                    .padding(.vertical, 30)
                VStack(alignment: .leading, spacing: 20) {
                    Section(header: Text("DETAILS")){
                        // MARK: - TECH NAME
                        TextField("Tech Name", text: $name)
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(9)
                            .font(.system(size: 24, weight: .bold, design: .default))
                        
                        // MARK: - TECH TYPE
                        Picker("Tech Type", selection: $techType){
                            ForEach(techTypes, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        // MARK: - DATE ACQUIRED
                        DatePicker("Date Acquired", selection: $dateAcquired, displayedComponents: .date)
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(9)
                        
                        // MARK: - SERIAL NUMBER
                        TextField("Serial Number", text: $serialNumber)
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(9)
                        
                        // MARK: - PRODUCT NUMBER
                        TextField("Product Number", text: $productNumber)
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(9)
                        
                        // MARK: - MODEL NUMBER
                        TextField("Model Number", text: $modelNumber)
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(9)
                    }//: Section 1
                    
                    Section(header: Text("ADDITIONAL INFORMATION")){
                        // MARK: - DETAILS
                        TextEditor(text: $text)
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(9)
                    }//: Section 2
                    
                    // MARK: - SAVE BUTTON
                    Button(action: {
                        if self.name != ""{
                            let tech = Tech(context: self.managedObjectContext)
                            tech.imageData = self.imageData
                            tech.name = self.name
                            tech.techType = self.techType
                            tech.dateAcquired = self.dateAcquired
                            tech.serialNumber = self.serialNumber
                            tech.productNumber = self.productNumber
                            tech.modelNumber = self.modelNumber
                            tech.text = self.text
                            
                            do {
                                try self.managedObjectContext.save()
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
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                    } //: SAVE BUTTON
                } //: VSTACK
                .padding(.horizontal)
//                .padding(.vertical, 30)
                Spacer()
                } //: SCROLLVIEW
            } //: VSTACK
            .navigationBarTitle("New Item", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                                } ){
                                    Image(systemName: "xmark.circle.fill")
                                        .imageScale(.large)
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

