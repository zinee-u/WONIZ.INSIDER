//
//  ContentView.swift
//  Insider
//
//  Created by 유수진 on 2023/09/06.
//
//  Keywords: Firebase
//  Ref.
//  - https://ios-development.tistory.com/769
//  - https://hryang.tistory.com/32
//  - https://makeschool.org/mediabook/oa/tracks/build-ios-apps/build-a-photo-sharing-app/uploading-photos-to-firebase/
//  - https://fomaios.tistory.com/entry/Swift-Storage%EC%97%90%EC%84%9C-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EC%97%85%EB%A1%9C%EB%93%9C-%EB%B0%8F-%EB%8B%A4%EC%9A%B4%EB%A1%9C%EB%93%9C%ED%95%98%EA%B8%B0
//  - https://velog.io/@ayb226/Flutter-%EC%98%A4%EB%A5%98-%EB%AA%A8%EC%9D%8C-FIRMessaging-Remote-Notifications-proxy-enabled-%ED%95%B4%EA%B2%B0%EB%B2%95
//  - https://github.com/you6878/howltalk_ios_simple_version/blob/master/Guide/section_4/index.md
//  - https://designcode.io/swiftui-advanced-handbook-imagepicker

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
            ZStack{
                Color.black.ignoresSafeArea(.all)
                NavigationLink(destination: SigninPage(), tag: 1, selection: self.$tag){
                    SigninKakao()
                }
                Button(action: {
                    self.tag = 1
                }) {
                    EmptyView()
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

