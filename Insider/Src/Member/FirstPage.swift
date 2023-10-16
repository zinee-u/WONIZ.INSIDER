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
        VStack{
            Text("Hello \(kakaoName)")
        }
        
        VStack{
            Button(action:{
                EmptyView()
            }, label:{
                Text("MyPage")
                    .foregroundColor(.purple)
                    .background(Color.black)
            })
        }
        
    }
}

//struct FirstPage_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstPage()
//    }
//}
