//
//  DetailFormRowView.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 12/25/20.
//

import SwiftUI

struct DetailFormRowView: View {
    // MARK: - PROPERTIES
    var firstText: String
    var secondText: Text
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Text(firstText).foregroundColor(Color.gray)
            Spacer()
            secondText
        }
    }
}

// MARK: - PREVIEW
struct DetailFormRowView_Previews: PreviewProvider {
    static var previews: some View {
        DetailFormRowView(firstText: "Application", secondText: Text("MyTech"))
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
