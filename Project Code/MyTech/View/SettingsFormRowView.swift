//
//  SettingsFormRowView.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 12/25/20.
//

import SwiftUI

struct SettingsFormRowView: View {
    // MARK: - PROPERTIES
//    var icon: String
    var firstText: String
    var secondText: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Text(firstText).foregroundColor(Color.gray)
            Spacer()
            Text(secondText)
        }
    }
}

// MARK: - PREVIEW
struct SettingsFormRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsFormRowView(firstText: "Application", secondText: "MyTech")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
