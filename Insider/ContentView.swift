//
//  ContentView.swift
//  Insider
//
//  Created by 유수진 on 2023/09/06.
//
//  Keywords: Mandatory info., Property

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

/* Preview */
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
                NavigationLink(destination: SigninPage(), tag: 1, selection: self.$tag){
                    SigninKakao()
                }
                NavigationLink(destination: ApplyForm(), tag: 2, selection: self.$tag){
                    ApplyButton()
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

/* ZStack.Sign-in 화면 */
struct SigninKakao: View{
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

struct ApplyButton: View{
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.purple)
                .frame(width: 80, height: 60)
            Text("Apply")
                .foregroundColor(.black)
        }
    }
}

/* VStack.Kakao 화면 */
struct SigninPage: View{
    
    @State private var image = UIImage()
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            Text("KakaoTalk")
                .foregroundColor(.purple)
            Color.black.ignoresSafeArea(.all)
            Button(action: {
                print("Sign In!")
                if(UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        print("oauthToken=")
                        print(oauthToken)
                        print("error=")
                        print(error)
                        
                    }
                } else {
                    /* 카톡 미 설치경우 사파리를 통한 로그인 */
                    UserApi.shared.loginWithKakaoAccount{(oauthToken, error) in
                        print("oauthToken=")
                        print(oauthToken)
                        print("error=")
                        print(error)
                    }
                }
            }, label: {
                Text("Sign Up")
                    .foregroundColor(.purple)
                    .background(Color.black)
            })
            
            Button(action:{
                let testItemsReference = Database.database().reference(withPath: "test-items")
                let userItemRef = testItemsReference.child("user")
                let values: [String: Any] = [ "age": 30, "name": "usuzin"]
                userItemRef.setValue(values)
            }, label: {
                Text("Sign In")
                    .foregroundColor(.purple)
                    .background(Color.black)
            })
            
            Button(action: {
                self.showSheet.toggle()
                
            }, label: {
                Text("Select Pic.")
                    .foregroundColor(.purple)
                    .background(Color.black)
            })
            .sheet(isPresented: $showSheet) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
            
            Button(action: {
                let default_image = UIImage(named: "Default_Img")
                let d_image = default_image?.jpegData(compressionQuality: 0.5)
                let u_image = image.jpegData(compressionQuality: 0.5)
                let data = (u_image ?? d_image)!
                let storage = Storage.storage()
                let filePath = "Users_Pics/user1"
                let metaData = StorageMetadata()
                metaData.contentType = "image/png"
                storage.reference().child(filePath).putData(data, metadata: metaData){
                     (metaData,error) in if let error = error {
                         print(error.localizedDescription)
                         return
                     } else {
                         print("Succeeded!")
                     }
                }
            }, label: {
                Text("Upload Pic.")
                    .foregroundColor(.purple)
                    .background(Color.black)
            })
        }
        /* 글자 영역의 배경색 */
        .background(Color.black)
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
