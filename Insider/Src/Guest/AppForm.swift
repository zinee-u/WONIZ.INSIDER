//
//  AppForm.swift
//  Insider
//
//  Created by 유수진 on 2023/09/11.
//
//  Keywords: Realtime Database, Host, Guest, Member
//  Ref.
//  - https://developers.kakao.com/docs/latest/ko/kakaologin/ios#req-user-info
//  - https://eunjin3786.tistory.com/58

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct AppForm: View {
    @State private var tag:Int? = nil
    @State var name: String = ""
    @State var birthday: String = ""
    @State var gender: String = ""
    @State var height: String = ""
    @State var company: String = ""
    @State var jobtitle: String = ""
    @State var location: String = ""
    @State var _1stNode: String = ""
    @State var isLogin: Bool = false
    @Binding var kakaoID: Int64
    @Binding var kakaoName: String
    
    func isButtonValid() -> Bool {
        return name.count > 1 && birthday.count > 1 && isLogin == true
    }
    
    /* ID field */
    var body: some View {
        VStack{
            Group{
                Text("필수 정보")
                    .font(.system(size: 40))
                    .fontWeight(.medium)
                    .frame(width: 350, alignment: .leading)
                    .padding(.bottom, 10)
                Spacer()
                NavigationLink(destination: Submit(), tag: 1, selection: self.$tag){
                }
            }
            Spacer()
            Group{
                HStack{
                    Image(systemName: "person").frame(width: 20)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    TextField("이름: ", text: $name)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("생년월일[yymmdd]: ", text: $birthday)
                        .frame(width: 300, height: 30)
                        .keyboardType(.numbersAndPunctuation)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("성별[남/여]: ", text: $gender)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("키[cm]: ", text: $height)
                        .frame(width: 300, height: 30)
                        .keyboardType(.decimalPad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("회사: ", text: $company)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("직무: ", text: $jobtitle)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("거주지: ", text: $location)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("주선자ID: ", text: $_1stNode)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    Button(action:{
                        let rootRef = Database.database().reference()
                        
                        let hostsRef = rootRef.child("host")
                        // hostRef = HostID
                        let hostRef = hostsRef.childByAutoId()
                        
                        let guestsRef = rootRef.child("guest")
                        // guestRef = guestID
                        
                        // ID_Nickname
                        let kakaoUInfo = "_ID_" + String(kakaoID) + "_NAME_" + kakaoName
                        
                        let guestRef = guestsRef.child(kakaoUInfo)
                        
                        let values: [String: Any] = ["name": name, "birthday": birthday, "gender": gender, "height": height, "job": ["company":company, "jobtitle":jobtitle], "location": location, "1stnode": _1stNode]
                        
                        guestRef.setValue(values)
                        
                        
                        self.tag = 1
                    }, label:{
                        Text("다음")
                    })
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
            }
        }
    }
}

//struct AppForm_Previews: PreviewProvider {
//    static var previews: some View {
//        AppForm()
//    }
//}
