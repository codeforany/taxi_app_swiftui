//
//  ImagePicker.swift
//  taxi_driver
//
//  Created by CodeForAny on 29/12/23.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var action: ( (UIImage) -> () )?
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    func makeUIViewController(context:  UIViewControllerRepresentableContext<ImagePicker> ) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing  = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            
        var parent: ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.action?(image)
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
}

#Preview {
    ImagePicker()
}
