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
                    // MARK: - SECTION 4
                    Section(header: Text("About the application")) {
                        DetailFormRowView(firstText: "Tech Type", secondText: Text(tech.techType ?? ""))
                    }
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
        tech.dateAcquired = Date()
        

        return NavigationView {
            TechDetailView(tech: tech)
        }
    }
}
