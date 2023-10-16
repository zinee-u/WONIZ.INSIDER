//
//  Signin.swift
//  Insider
//
//  Created by 유수진 on 2023/09/23.
//
//  Keywords: Binding, UserInfo, NavigationView/Stack
//  Ref.:
//  - https://insubkim.tistory.com/263
//  - https://developers.kakao.com/docs/latest/ko/kakaologin/ios#req-user-info
//  - https://developers.kakao.com/tool/resource/login
//  - https://pororious.tistory.com/305
//  - https://velog.io/@niro/iOS-SwiftUI-NavigationStack-%EC%95%8C%EC%95%84%EB%B3%B4%EA%B8%B0-in-WWDC22
//  - https://www.hohyeonmoon.com/blog/swiftui-tutorial-navigation/

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
        NavigationView{
            if(isLogin == true){
                VStack{
                    NavigationLink(destination:FirstPage(kakaoID: $kakaoID, kakaoName: $kakaoName, isLogin: $isLogin), isActive: $isLogin){
                        btnLogin()
                    }
                }
            } else {
                VStack{
                    SigninKakaoMem(kakaoID: $kakaoID, kakaoName: $kakaoName, isLogin: $isLogin)
              }
            }
        }
        Color.black.ignoresSafeArea(.all)
    }
}

struct Signin_Previews: PreviewProvider {
    @Binding var tag : Int
    static var previews: some View {
        Signin()
    }
}


struct SigninKakaoMem: View{
    @State private var tag:Int? = nil
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
                _ = user
                /* 사용자 정보는 User 클래스 객체로 전달된다.
                 회원번호 값을 조회하려면 user.id,
                 카카오계정 프로필 정보들은 user.kakaoAccount.profile,
                 이메일은 user.kakaoAccount.email과 같이 접근할 수 있다. */
                kakaoID = user?.id ?? 0
                kakaoName = String(user?.kakaoAccount?.profile?.nickname ?? "None")
                if(kakaoID != -1 && kakaoName != "None"){
                    isLogin = true
                } else {
                    isLogin = false
                }
                print("\(isLogin)")
            }
        }
    }
    
    var body: some View{
        ZStack{
            /* 기존 회원 Kakao 로그인 */
            Button(action:{
                if(isLogin) {
                    print("Already Sign-in")
                    print("\(isLogin)")
                } else {
                    loginKakao()
                }
            }, label: {
                if(isLogin) {
                    Text("MyPage")
                        .foregroundColor(.purple)
                        .background(Color.black)
                } else {
                    Text("Sign In")
                        .foregroundColor(.purple)
                        .background(Color.black)
                }
                    
            })
        }
    }
}


struct btnLogin: View{
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.purple)
                .frame(width: 100, height: 60)
            Text("LoginSIDER")
                .foregroundColor(.black)
        }
    }
}
