//
//  SettingsView.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 12/16/20.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Tech.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tech.name, ascending: true)]) var techs: FetchedResults<Tech>
    
    @State private var showingAddListView: Bool = false
    @State private var isShareSheetShowing = false
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - FORM
                Form {
                    // MARK: - SECTION ABOUT THE DEVELOPER
                    Section(header: Text("ABOUT THE DEVELOPER")) {
                        SettingsLinkRowView(icon: "globe", color: Color.pink, text: "Website", link: "https://eloquent-lichterman-897681.netlify.app/")
                    }
                    
                    // MARK: - SECTION ABOUT THE APPLICATION
                    Section(header: Text("ABOUT THE APPLICATION")) {
                        SettingsFormRowView(icon: "gear", firstText: "Application", secondText: "MyTech")
                        SettingsFormRowView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        SettingsFormRowView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                        SettingsLinkRowView(icon: "keyboard", color: Color.gray, text: "Source Code", link: "https://github.com/AK-Vitae/MyTech")
                    }
                    
                    // MARK: - SHARE BUTTON
                    Button(action: shareButton) {
                        Text("Export Data")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                            .shadow(radius: 4)
                    } //: SHARE BUTTON
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
            } //: VSTACK
            .navigationBarHidden(true)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        } //: NAVIGATIONVIEW
        .navigationBarTitle("Settings", displayMode: .inline)
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
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
