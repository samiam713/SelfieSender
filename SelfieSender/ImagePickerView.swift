//
//  ImagePickerView.swift
//  SelfieSender
//
//  Created by Samuel Donovan on 2/15/21.
//

import Foundation
import UIKit
import SwiftUI

// SwiftUI wrapper around a UIImagePickerController
// https://developer.apple.com/documentation/uikit/uiimagepickercontroller
struct ImagePickerView: UIViewControllerRepresentable {
    
    let imagePickerControllerDelegate: ImagePickerControllerDelegate
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = imagePickerControllerDelegate.sourceType
        imagePicker.delegate = imagePickerControllerDelegate // confirming the delegate
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

// delegate for the ImagePickerControllerDelegate
class ImagePickerControllerDelegate: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ObservableObject {
    
    // we will pick images from the camera
    @Published var sourceType: UIImagePickerController.SourceType = .camera
    
    // the image we receive from the UIImagePickerController, initially false
    @Published var selectedImage: UIImage? = nil
    
    // is the imagePickerDisplay active?
    // initially false, when you press buttons becomes true
    @Published var isImagePickerDisplay = false
    
    // delegate function
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage, let pngData = selectedImage.pngData() else { return }
        
        print("First 25 bytes\n[", terminator: "")
        for byte in pngData[0..<50] {
            print(byte, terminator: ",")
        }
        print("]")
        
        // example HTTP request using the data
        // ServerCommunicator.updateUserProfile(pngData: pngData)
        
        self.selectedImage = selectedImage
        self.isImagePickerDisplay = false
    }
    
}

