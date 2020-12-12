//
//  ContentView.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 8/29/20.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Tech.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tech.name, ascending: true)]) var techs: FetchedResults<Tech>
    
    @State private var showingAddListView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            ZStack {
                List {
                    ForEach(self.techs, id: \.self) { tech in
                        NavigationLink(destination: TechDetailView(tech: tech)){
                            HStack{
                                Text(tech.name ?? "Unknown")
                                Spacer()
                                Text(tech.techType ?? "Unknown")
                            } //: HSTACK
                        } //: NAVIGATIONLINK
                    } //: FOREACH
                    .onDelete(perform: deleteTech)
                } //: LIST
                .navigationBarTitle("My Tech", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:
                    Button(action: {
                        self.showingAddListView.toggle()
                    }) {
                        Image(systemName: "plus")
                    } //: ADD BUTTON
                        .sheet(isPresented: $showingAddListView){
                        AddListView().environment(\.managedObjectContext, self.managedObjectContext)
                    }
                )
                // MARK: - NO TECH ITEMS
                if techs.count == 0 {
                    EmptyListView()
                }
            } //: ZSTACK
        } //: NAVIGATION
    }
    
    // MARK: - FUNCTIONS
    
    private func deleteTech(at offsets: IndexSet){
        for index in offsets{
            let tech = techs[index]
            managedObjectContext.delete(tech)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView()
            .environment(\.managedObjectContext, context)
    }
}
