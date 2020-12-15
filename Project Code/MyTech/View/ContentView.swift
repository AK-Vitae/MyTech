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
    @State private var isShareSheetShowing = false
//    @State private var animatingButton: Bool = false
    
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
                    Button(action: shareButton) {
                        Image(systemName: "square.and.arrow.up")
                    } //: SHARE BUTTON
                )
                // MARK: - NO TECH ITEMS
                if techs.count == 0 {
                    EmptyListView()
                }
            } //: ZSTACK
            .sheet(isPresented: $showingAddListView){
            AddListView().environment(\.managedObjectContext, self.managedObjectContext)
            }
            .overlay(
                ZStack {
                    Button(action:{
                        self.showingAddListView.toggle()
                    }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .background(Circle().fill(Color("ColorBase")))
                                .frame(width: 48, height: 48, alignment: .center)
                                .font(.title)
                    } //: ADD BUTTON
                } //: ZSTACK
                .padding(.bottom, 50)
                .padding(.trailing, 50)
                , alignment: .bottomTrailing
            )
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
    
    func shareButton() {
        let fileName = "MyTech.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "Name,Type,Date Acquired, Serial Number, Product Number, Model Number, Additional Information\n"

        for tech in techs {
            csvText += "\(tech.name ?? "Unknown"),\(tech.techType ?? ""),\(tech.dateAcquired ?? Date()),\(tech.serialNumber ?? ""),\(tech.productNumber ?? ""),\(tech.modelNumber ?? ""),\(tech.text ?? "")\n"
        }
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        print(path ?? "not found")

        var filesToShare = [Any]()
        filesToShare.append(path!)

        let av = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)

        isShareSheetShowing.toggle()
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
