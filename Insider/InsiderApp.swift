//
//  InsiderApp.swift
//  Insider
//
//  Created by 유수진 on 2023/09/06.
//
//  Keywords: KakaoSDKCommon/Auth, Access Token.
//  Ref.
//  - https://developers.kaka.com/docs/latest/ko/getting-started/sdk-ios#init
//  - https://velog.io/@youngking0914/iOSSwiftUI%EC%B9%B4%EC%B9%B4%EC%98%A4-%EB%A1%9C%EA%B7%B8%EC%9D%B8-%EA%B5%AC%ED%98%84-%EC%8B%9C-%ED%82%A4-%EA%B0%92-%EC%88%A8%EA%B8%B0%EA%B8%B0

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
        
        return true
    }
}

@main
struct InsiderApp: App {
    init(){
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
        /* Kakao SDK 초기화 */
        let NATIVE_APP_KEY: String = Bundle.main.infoDictionary?["NATIVE_APP_KEY"] as? String ?? "NATIVE_APP_KEY is nil"
        KakaoSDK.initSDK(appKey: NATIVE_APP_KEY)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL{ url in
                    if(AuthApi.isKakaoTalkLoginUrl(url)){
                        _ = AuthController.handleOpenUrl(url: url)
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
