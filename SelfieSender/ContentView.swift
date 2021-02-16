//
//  ContentView.swift
//  SelfieSender
//
//  Created by Samuel Donovan on 2/15/21.
//

import SwiftUI

// the main screen of the app:
// vertical stack of image and buttons
struct ContentView: View {
    
    @ObservedObject var imagePickerControllerDelegate = ImagePickerControllerDelegate()
    
    var body: some View {

            VStack {
                if imagePickerControllerDelegate.selectedImage != nil {
                    Image(uiImage: imagePickerControllerDelegate.selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                } else {
                    Image(systemName: "snow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                }
                Button("Use Camera") {
                    print("??")
                    imagePickerControllerDelegate.sourceType = .camera
                    imagePickerControllerDelegate.isImagePickerDisplay = true
                }.padding()
                Button("Use Photo Library") {
                    imagePickerControllerDelegate.sourceType = .photoLibrary
                    imagePickerControllerDelegate.isImagePickerDisplay = true
                }.padding()
            }
            .sheet(isPresented: $imagePickerControllerDelegate.isImagePickerDisplay) {
                ImagePickerView(imagePickerControllerDelegate: imagePickerControllerDelegate)
            }

    }
}
