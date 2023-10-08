//
//  Signin.swift
//  Insider
//
//  Created by 유수진 on 2023/09/23.
//
//  Keywords: Binding, UserInfo
//  Ref.:
//  - https://insubkim.tistory.com/263
//  - https://developers.kakao.com/docs/latest/ko/kakaologin/ios#req-user-info
//  - https://developers.kakao.com/tool/resource/login
//  - https://pororious.tistory.com/305

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import KakaoSDKAuth
import KakaoSDKUser


struct Signin: View {
    @State var kakaoID : Int64 = -1
    @State var kakaoName : String = "None"
    @State var isLogin : Bool = false
    @State private var tag:Int? = nil
    
    var body: some View {
        
        SigninKakao(kakaoID: $kakaoID, kakaoName: $kakaoName, isLogin: $isLogin)
        VStack{
            NavigationLink(destination: AppForm(kakaoID: $kakaoID, kakaoName: $kakaoName, isLogin: $isLogin), isActive: $isLogin){
                    EmptyView()
            }
        }
        
    }
}

struct Signin_Previews: PreviewProvider {
    @Binding var tag : Int
    static var previews: some View {
        Signin()
    }
}


struct SigninKakao: View{
    @Binding var kakaoID : Int64
    @Binding var kakaoName : String
    @Binding var isLogin : Bool
    @State private var image = UIImage()
    @State private var showSheet = false
    func loginKakao(){
        if(UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            }
        } else {
            /* 카톡 미 설치경우 사파리를 통한 로그인 */
            UserApi.shared.loginWithKakaoAccount{(oauthToken, error) in
            }
        }
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() succeeded!")
                isLogin = true
                _ = user
                /* 사용자 정보는 User 클래스 객체로 전달된다.
                 회원번호 값을 조회하려면 user.id,
                 카카오계정 프로필 정보들은 user.kakaoAccount.profile,
                 이메일은 user.kakaoAccount.email과 같이 접근할 수 있다. */
//                kakaoID = String(user?.kakaoAccount?.profile?.nickname ?? "none")
                kakaoID = user?.id ?? 0
                kakaoName = String(user?.kakaoAccount?.profile?.nickname ?? "None")
                print("\(isLogin)")
            }
        }
    }
    
    
    /* ZStack.Sign-in 화면 */
    var body: some View{
//        ZStack {
//            RoundedRectangle(cornerRadius: 20)
//                .foregroundColor(Color.purple)
//                .frame(width: 80, height: 60)
//            Text("Sign-in")
//                .foregroundColor(.black)
//        }
        
        /* VStack.Kakao 화면 */
        VStack {
            Text("KakaoTalk")
                .foregroundColor(.purple)
            Color.black.ignoresSafeArea(.all)
            
            /* 신규 회원 Kakao 로그인 */
            Button(action: {
                loginKakao()
            }, label: {
                Text("Sign Up")
                    .foregroundColor(.purple)
                    .background(Color.black)
            })
            
            /* 기존 회원 Kakao 로그인 */
            Button(action:{
                loginKakao()
                print(kakaoID)
            }, label: {
                Text("Sign In")
                    .foregroundColor(.purple)
                    .background(Color.black)
            })
            
            /* 사진 선택 및 등록 */
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
        .background(Color.black)
    }
}
