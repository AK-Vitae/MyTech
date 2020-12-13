//
//  AppView.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 12/10/20.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView() {
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                        .font(.system(size: 30))
                }
//            SettingsView()
//                .tabItem {
//                    Image(systemName: "square.and.arrow.up")
//                        .font(.system(size: 30))
//                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
