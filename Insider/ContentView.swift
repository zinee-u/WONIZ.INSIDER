//
//  ContentView.swift
//  Insider
//
//  Created by 유수진 on 2023/09/06.
//
//  Keywords: Page 전환, Stack, Text
//  Ref.
//  - https://growingsaja.tistory.com/797
//  - https://babbab2.tistory.com/160
//  - https://careerly.co.kr/qnas/3141
//  - https://www.vbflash.net/128
//  - https://applexcode.com/swiftui-text-color/

import SwiftUI

struct ContentView: View {
    var body: some View {
        ContentView_Previews()
    }
}

/* 기본 화면 */
struct ContentView_Previews: View{
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
        }
        /* 글자 영역의 배경색 */
        .background(Color.black)
    }
}
