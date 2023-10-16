//
//  FirstPage.swift
//  Insider
//
//  Created by 유수진 on 2023/10/17.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import KakaoSDKAuth
import KakaoSDKUser

struct FirstPage: View {
    @State private var tag:Int? = nil
    @Binding var kakaoID: Int64
    @Binding var kakaoName: String
    @Binding var isLogin: Bool
    
    var body: some View {
        
        NavigationView{
            VStack{
                Text("Hi, \(kakaoName)!")
                NavigationLink(destination: MyPage(kakaoID: $kakaoID, kakaoName: $kakaoName, isLogin: $isLogin), tag: 1, selection: self.$tag){
                        btnMyPage()
                }
            }
        }
        .navigationTitle("Welcome")
        .foregroundColor(.black)
        .navigationBarBackButtonHidden()
    }
}

//struct FirstPage_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstPage()
//    }
//}

struct btnMyPage: View{
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.purple)
                .frame(width: 100, height: 60)
            Text("MyPage")
                .foregroundColor(.black)
        }
    }
}
