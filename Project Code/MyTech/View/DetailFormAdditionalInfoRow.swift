//
//  DetailFormAdditionalInfoRow.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 12/26/20.
//

import SwiftUI

struct DetailFormRowAdditonalInfoView: View {
    // MARK: - PROPERTIES
    var text: Text
    
    // MARK: - BODY
    var body: some View {
        HStack {
            text
        }
    }
}

// MARK: - PREVIEW
struct DetailFormRowAdditonalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailFormRowAdditonalInfoView(text: Text("MyTech"))
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
