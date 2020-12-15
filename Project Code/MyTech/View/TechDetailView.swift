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
            VStack{
                List {
                    Section(header: Text("Details")){
                        HStack{
                            Text("Tech Type:")
                            Spacer()
                            Text(tech.techType ?? "")
                                .fontWeight(.light)
                        }
                        HStack{
                            Text("Date Acquired:")
                            Spacer()
                            Text(tech.dateAcquired ?? Date(), style: .date)
                                .fontWeight(.light)
                        }
                        HStack{
                            Text("Serial Number:")
                            Spacer()
                            Text(tech.serialNumber ?? "")
                                .fontWeight(.light)
                        }
                        HStack{
                            Text("Product Number:")
                            Spacer()
                            Text(tech.productNumber ?? "")
                                .fontWeight(.light)
                        }
                        HStack{
                            Text("Model Number:")
                            Spacer()
                            Text(tech.modelNumber ?? "")
                                .fontWeight(.light)
                        }
                    }//: SECTION 1
                    Section(header: Text("Additional Information")){
                        Text(tech.text ?? "")
                    } //: SECTION 2
                } //: LIST
            } //: VSTACK
            .navigationBarHidden(true)
        } //: NAVIGATIONVIEW
        .navigationBarTitle(Text(tech.name ?? "Unknown Item"), displayMode: .inline)
//        .navigationBarItems(trailing: EditButton())
    }
}

// MARK: - PREVIEW
struct TechDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let tech = Tech(context: moc)
        tech.name = "Test"
        tech.dateAcquired = Date()
        

        return NavigationView {
            TechDetailView(tech: tech)
        }
    }
}
