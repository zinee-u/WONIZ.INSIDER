//
//  ContentView.swift
//  Insider
//
//  Created by 유수진 on 2023/09/06.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

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
                Text("Sign In")
                    .foregroundColor(.purple)
                    .background(Color.black)
            })
        }
        /* 글자 영역의 배경색 */
        .background(Color.black)
    }
}
