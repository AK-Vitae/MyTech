//
//  ImagePicker.swift
//  MyTech
//
//  Created by Akshith Ramadugu on 1/30/21.
//

import SwiftUI
import Combine

struct ImagePicker: UIViewControllerRepresentable {
    // MARK: - PROPERTIES
    @Binding var show: Bool
    @Binding var image: Data
    
    var sourceType:UIImagePickerController.SourceType = .photoLibrary

    // MARK: - FUNCTIONS
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(child1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    // MARK: - CLASSES
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var child: ImagePicker
        
        init(child1: ImagePicker) {
            child = child1
        }
        // MARK: - CLASS FUNCTIONS
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.child.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            
            let data = image.jpegData(compressionQuality: 0.45)
            
            self.child.image = data!
            self.child.show.toggle()
        }
    }
}
