//
//  TechDetailView.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 12/8/20.
//

import CoreData
import SwiftUI

struct TechDetailView: View {
    // MARK: - PROPERTIES
    let tech: Tech
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - FORM
                Form {
                    // MARK: - VSTACK FOR IMAGE
                    VStack {
                        if tech.imageData == nil {
                            Text("No Image Added")
//                                .multilineTextAlignment(.center)
                        } else {
                            Image(uiImage: UIImage(data: tech.imageData ?? .init(count: 0))!)
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                                    .cornerRadius(6)
                        }
                    } //: VSTACK FOR IMAGE
                    .padding(.vertical, 30)
                    // MARK: - DETAILS SECTION
                    Section(header: Text("DETAILS")) {
                        DetailFormRowView(firstText: "Tech Type", secondText: Text(tech.techType ?? ""))
                        DetailFormRowView(firstText: "Date Acquired", secondText: Text(tech.dateAcquired ?? Date(), style: .date))
                        DetailFormRowView(firstText: "Serial Number", secondText: Text(tech.serialNumber ?? ""))
                        DetailFormRowView(firstText: "Product Number", secondText: Text(tech.productNumber ?? ""))
                        DetailFormRowView(firstText: "Model Number", secondText: Text(tech.modelNumber ?? ""))
                    }//: DETAILS SECTION
                    // MARK: - ADDITONAL INFORMATION SECTION
                    Section(header: Text("ADDITONAL INFORMATION")) {
                        DetailFormRowAdditonalInfoView(text: Text(tech.text ?? ""))
                    }//: ADDITONAL INFORMATION SECTION
                } //: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK: - FOOTER
                Text("© SVAAR Holdings LLC.")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            }
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        } //: NAVIGATIONVIEW
        .navigationBarTitle(Text(tech.name ?? "Unknown Item"), displayMode: .inline)
    }
}

// MARK: - PREVIEW
struct TechDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let tech = Tech(context: moc)
        tech.name = "Test"
        tech.techType = "Device"
        tech.dateAcquired = Date()
        tech.serialNumber = "123"
        tech.productNumber = "321"
        tech.modelNumber = "Q123"
        tech.text = "Got last year and is currently in my room"
        

        return NavigationView {
            TechDetailView(tech: tech)
        }
    }
}
