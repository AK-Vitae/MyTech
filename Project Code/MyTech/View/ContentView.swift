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
    
    @State private var showingAddListView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Text("Hello World")
            } //: LIST
            .navigationBarTitle("My Tech", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showingAddListView.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                    } //: ADD BUTTON
                                    .sheet(isPresented: $showingAddListView){
                                        AddListView().environment(\.managedObjectContext, self.managedObjectContext)
                                    }
            )
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}
