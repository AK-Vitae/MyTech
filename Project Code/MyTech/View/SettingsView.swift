//
//  SettingsView.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 12/9/20.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - PROPERTIES
    @FetchRequest(entity: Tech.entity(), sortDescriptors: []) var techs: FetchedResults<Tech>
    @State private var isShareSheetShowing = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            Button(action: shareButton)
            {
                HStack(alignment: .firstTextBaseline) {
                    Text("Export CSV")
                        .font(.headline)
                    Image(systemName: "square.and.arrow.up")
                        .font(.title)
                } //: HSTACK
            } //: BUTTON
        } //: NAVIGATIONVIEW
        .navigationBarTitle("Settings")
    }

    // MARK: - FUNCTIONS
    func shareButton() {
        let fileName = "MyTech.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "Name,Type\n"

        for tech in techs {
            csvText += "\(tech.name ?? "Unknown"),\(tech.techType ?? "-")\n"
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
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
