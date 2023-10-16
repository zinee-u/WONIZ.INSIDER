//
//  MyPage.swift
//  Insider
//
//  Created by 유수진 on 2023/10/17.
//
//  Keywords: getData, observeSingleEvent
//  Ref.:
//  - https://stackoverflow.com/questions/68770630/type-void-cannot-conform-to-view-swift
//  - https://stackoverflow.com/questions/60900554/swiftui-binding-default-value-argument-labels-wrappedvalue-do-not-match-an

import SwiftUI
import FirebaseDatabase

class getMemTree: ObservableObject{
    @Binding var kakaoID: Int64
    @Published var childeren : [String] = []
    
    private var ref = Database.database().reference()
    
    func getChildren(kID: Binding<Int64>) {
        ref.child("guest").observeSingleEvent(of: .value, with: { snapshot in
            // memInfo
            self.childeren = snapshot.children.map{ snap in
                (snap as AnyObject).value
            }
//            var value = snapshot.value as? NSDictionary
//            memName = value?["name"] as? String ?? ""
        }){ error in
            print(error.localizedDescription)
        }
        
    }
    
    init(kakaoID: Binding<Int64> = .constant(-1)) {
        _kakaoID = kakaoID
        getChildren(kID: kakaoID)
    }
}

struct MyPage: View {
//    @State private var imageProfile = UIImage()
    @State private var tag:Int? = nil
    @Binding var kakaoID: Int64
    @Binding var kakaoName: String
    @Binding var isLogin: Bool
    @StateObject private var memTree = getMemTree()
    
    
    var body: some View {
        /* Basic View */
        let default_image = UIImage(named: "Default_Img")
//        var memNameRef = Database.database().reference()
        
        
        
        /*
        /* 친구 목록 */
        HStack{
            // 사진
            VStack{
                // 필수 정보
            }
            VStack{
                // 선택 정보
                HStack{
                    // Bnt: 좋아요
                }
            }
        }
        */
        
        /* 내 정보 */
        VStack{
            /* 내 사진 */
            VStack{
                Image(uiImage: default_image!)
                    .resizable()
                    .frame(width:100, height: 100)
                    .scaledToFill()
            }
            VStack{
                /* 내 이름 */
                ForEach(memTree.childeren, id: \.self){ child in
                    if(child == String(kakaoID)){
                        VStack{
                            Text("\(child)")
                        }
                    }
                    
                }
            }
        }
        
    }
}

//struct MyPage_Previews: PreviewProvider {
//    static var previews: some View {
//        MyPage()
//    }
//}

