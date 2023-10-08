//
//  ContentView.swift
//  Insider
//
//  Created by 유수진 on 2023/09/06.
//
//  Keywords: Mandatory info., Property
//  Keywords: Binding, UserInfo
//  Ref.:
//  - https://insubkim.tistory.com/263
//  - https://developers.kakao.com/docs/latest/ko/kakaologin/ios#req-user-info

import SwiftUI
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage



struct ContentView: View {
    var body: some View {
        ContentView_Basic()
    }
}

///* Preview */
struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}

/* 기본 화면 */
struct ContentView_Basic: View{
    @State private var tag:Int? = nil
    
    var body: some View {
        NavigationStack{
            VStack{
                Color.black.ignoresSafeArea(.all)
                Text("Hello, Insider!")
                    .font(.system(size: 40))
            }
            VStack{
                NavigationLink(destination: Signin(), tag: 1, selection: self.$tag){
                    SigninMember()
                }
                
                NavigationLink(destination: Signin(), tag: 2, selection: self.$tag){
                    SignupGuest()
                }
                
                HStack{
                    Color.black.ignoresSafeArea(.all)
                    
                    Button(action: {
                        self.tag = 1
                    }){
                        EmptyView()
                    }
                }
                HStack{
                    
                    Button(action: {
                        self.tag = 2
                    }){
                        EmptyView()
                    }
                }
            }
        }
    }
}

struct SigninMember: View{
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.purple)
                .frame(width: 80, height: 60)
            Text("Sign-in")
                .foregroundColor(.black)
        }
    }
}

struct SignupGuest: View{
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.purple)
                .frame(width: 80, height: 60)
            Text("Sign-up")
                .foregroundColor(.black)
        }
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}
