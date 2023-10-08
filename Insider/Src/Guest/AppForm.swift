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
//  - https://ios-development.tistory.com/1161

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class UserInfo: ObservableObject {
    @Published var name: String = ""
    @Published var birthday: String = ""
    @Published var gender: String = ""
    @Published var height: String = ""
    @Published var company: String = ""
    @Published var jobtitle: String = ""
    @Published var location: String = ""
    @Published var _1stNode: String = ""

    @Published var hobby: String = ""
    @Published var mbti: String = ""
    @Published var smoking: String = ""
    @Published var alcohol: String = ""
    @Published var pet: String = ""
    @Published var religion: String = ""
}

struct AppForm: View {
    @State private var tag:Int? = nil
    @Binding var kakaoID: Int64
    @Binding var kakaoName: String
    @Binding var isLogin: Bool
    @StateObject var guestInfo = UserInfo()
    
    
    func isButtonValid() -> Bool {
        return isLogin
        //        return guestInfo.name.count > 1 && guestInfo.birthday.count > 1 && guestInfo.isLogin == true
    }
    
    var body: some View {
            VStack{
                    Text("필수 정보")
                        .font(.system(size: 40))
                        .fontWeight(.medium)
                        .frame(width: 350, alignment: .leading)
                        .padding(.bottom, 10)
                    Spacer()
                NavigationLink(destination: AppFormOpt(kakaoID: $kakaoID, kakaoName: $kakaoName).environmentObject(guestInfo), tag: 1, selection: self.$tag){
                    }

                Spacer()
                Group{
                    VStack {
                        NameView().environmentObject(guestInfo)
                    }
                        
                    VStack {
                        BirthView().environmentObject(guestInfo)
                    }
                        
                    VStack {
                        GenderView().environmentObject(guestInfo)
                    }
                        
                    VStack {
                        HeightView().environmentObject(guestInfo)
                    }
                        
                    VStack {
                        CompantView().environmentObject(guestInfo)
                    }
                        
                    VStack {
                        JobView().environmentObject(guestInfo)
                    }
                        
                    VStack {
                        LocationView().environmentObject(guestInfo)
                    }
                        
                    VStack {
                        HostIDView().environmentObject(guestInfo)
                            .disableAutocorrection(false)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                }
                    
                HStack{
                    Button(action:{
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

struct AppFormOpt: View{
    @State private var tag:Int? = nil
    @Binding var kakaoID: Int64
    @Binding var kakaoName: String
    @EnvironmentObject var guestInfo : UserInfo
    
    var body: some View{
        VStack{

                Text("선택 정보")
                    .font(.system(size: 40))
                    .fontWeight(.medium)
                    .frame(width: 350, alignment: .leading)
                    .padding(.bottom, 10)
                Spacer()
                NavigationLink(destination: Submit(), tag: 2, selection: self.$tag){
                }
            
            Spacer()
            Group
            {
                HStack{
                    TextField("취미: ", text: $guestInfo.hobby)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("MBTI: ", text: $guestInfo.mbti)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("흡연유무: ", text: $guestInfo.smoking)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("주량: ", text: $guestInfo.alcohol)
                        .frame(width: 300, height: 30)
                        .keyboardType(.decimalPad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("반려동물: ", text: $guestInfo.pet)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("종교: ", text: $guestInfo.religion)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    Button(action:{
//                        var uid = Auth.auth().currentUser?.uid
                        let rootRef = Database.database().reference()

                        let hostsRef = rootRef.child("host")
                        let hostRef = hostsRef.childByAutoId()
                        
                        let guestsRef = rootRef.child("guest")
//                        let guestRef = guestsRef.child(String(kakaoID))
                        var kakaoUInfo : String = "None"
                            
                        // ID
                        kakaoUInfo = String(kakaoID)
                            
                        let guestRef = guestsRef.child(kakaoUInfo)
                        
                        var values: [String: Any] = ["name": guestInfo.name, "birthday": guestInfo.birthday, "gender": guestInfo.gender, "height": guestInfo.height, "job": ["company": guestInfo.company, "jobtitle": guestInfo.jobtitle], "location": guestInfo.location, "1stnode": guestInfo._1stNode, "hobby": guestInfo.hobby, "mbti": guestInfo.mbti, "smoking": guestInfo.smoking, "alcohol": guestInfo.alcohol, "pet": guestInfo.pet, "religion": guestInfo.religion]
                        
                        print(guestInfo.name)

                        guestRef.setValue(values)
                        self.tag = 2
                    }, label:{
                        Text("제출")
                    })
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
            }

        }
    }
}


//struct AppForm_Previews: PreviewProvider {
//    @Binding var kakaoID: Int64
//    @Binding var kakaoName: String
//    @Binding var isLogin: Bool
//    static var previews: some View {
//        AppForm(kakaoID: $kakaoID, kakaoName: $kakaoName, isLogin: $isLogin)
//    }
//}

struct NameView: View {
    @EnvironmentObject var guestInfo : UserInfo
    var body: some View {
        HStack{
            Image(systemName: "person").frame(width: 20)
                .font(.system(size: 20))
                .foregroundColor(.gray)
            TextField("이름: ", text: $guestInfo.name)
                .frame(width: 300, height: 30)
                .keyboardType(.namePhonePad)
                .autocapitalization(.none)
                .disableAutocorrection(false)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
    }
}

struct BirthView: View {
    @EnvironmentObject var guestInfo : UserInfo
    var body: some View {
        HStack{
            TextField("생년월일[yymmdd]: ", text: $guestInfo.birthday)
                .frame(width: 300, height: 30)
                .keyboardType(.numbersAndPunctuation)
                .autocapitalization(.none)
                .disableAutocorrection(false)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
    }
}

struct GenderView: View {
    @EnvironmentObject var guestInfo : UserInfo
    var body: some View {
        HStack{
            TextField("성별[남/여]: ", text: $guestInfo.gender)
                .frame(width: 300, height: 30)
                .keyboardType(.namePhonePad)
                .autocapitalization(.none)
                .disableAutocorrection(false)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
    }
}

struct HeightView: View {
    @EnvironmentObject var guestInfo : UserInfo
    var body: some View {
        HStack{
            TextField("키[cm]: ", text: $guestInfo.height)
                .frame(width: 300, height: 30)
                .keyboardType(.decimalPad)
                .autocapitalization(.none)
                .disableAutocorrection(false)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
    }
}

struct CompantView: View {
    @EnvironmentObject var guestInfo : UserInfo
    var body: some View {
        HStack{
            TextField("회사: ", text: $guestInfo.company)
                .frame(width: 300, height: 30)
                .keyboardType(.namePhonePad)
                .autocapitalization(.none)
                .disableAutocorrection(false)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
    }
}

struct JobView: View {
    @EnvironmentObject var guestInfo : UserInfo
    var body: some View {
        HStack{
            TextField("직무: ", text: $guestInfo.jobtitle)
                .frame(width: 300, height: 30)
                .keyboardType(.namePhonePad)
                .autocapitalization(.none)
                .disableAutocorrection(false)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
    }
}

struct LocationView: View {
    @EnvironmentObject var guestInfo : UserInfo
    var body: some View {
        HStack{
            TextField("거주지: ", text: $guestInfo.location)
                .frame(width: 300, height: 30)
                .keyboardType(.namePhonePad)
                .autocapitalization(.none)
                .disableAutocorrection(false)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
    }
}

struct HostIDView: View {
    @EnvironmentObject var guestInfo : UserInfo
    var body: some View {
        TextField("주선자ID: ", text: $guestInfo._1stNode)
            .frame(width: 300, height: 30)
            .keyboardType(.namePhonePad)
            .autocapitalization(.none)
            .disableAutocorrection(false)
    }
}
