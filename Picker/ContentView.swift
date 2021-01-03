//
//  ContentView.swift
//  Picker
//
//  Created by Shakur on 1/3/21.
// Thanks to @ Karthick Selvaraj ( Medium Handle)

// ** If you start a new project, be sure to list enable Camera, under privacy settings in Plist

import SwiftUI

struct ContentView: View {
    
    @State private var image: Image? = Image(systemName: "plus")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    var body: some View {
        // WARNING: Force wrapped image for demo purpose, not for production
        image!
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 300)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .onTapGesture { self.shouldPresentActionScheet = true }
            .sheet(isPresented: $shouldPresentImagePicker) {
                ImagePicker(
                    sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,
                    
                    image: self.$image,
                    isPresented: self.$shouldPresentImagePicker)
        }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
            
            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"),
                        buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = true}),
                                  
            ActionSheet.Button.default(Text("Photo Library"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = false
            }),
            
            ActionSheet.Button.cancel()])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
