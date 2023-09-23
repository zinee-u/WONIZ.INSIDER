//
//  InsiderApp.swift
//  Insider
//
//  Created by 유수진 on 2023/09/06.
//
//  Keywords: Binding
//  Ref:
//  - https://insubkim.tistory.com/263


import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    /* Firebase 초기화 */
    FirebaseApp.configure()

    return true
  }
}

@main
struct InsiderApp: App {
    
    @State private var kakaoID: Int64 = 0
    @State private var kakaoName: String = ""
    
    init(){
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//        FirebaseApp.configure()
        
        /* Kakao SDK 초기화 */
        let NATIVE_APP_KEY: String = Bundle.main.infoDictionary?["NATIVE_APP_KEY"] as? String ?? "NATIVE_APP_KEY is nil"
        KakaoSDK.initSDK(appKey: NATIVE_APP_KEY)
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView(kakaoID: $kakaoID, kakaoName: $kakaoName)
                    .onOpenURL{ url in
                        if(AuthApi.isKakaoTalkLoginUrl(url)){
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                    }
            }
        }
    }
}

struct Previews_InsiderApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
