//
//  AppForm.swift
//  Insider
//
//  Created by 유수진 on 2023/09/11.
//
//  Keywords: Mandatory info., Property
//  Ref.
//  - https://jinshine.github.io/2018/05/22/Swift/6.%ED%94%84%EB%A1%9C%ED%8D%BC%ED%8B%B0(Property)/
//  - https://sy-catbutler.tistory.com/18
//  - https://huniroom.tistory.com/entry/SwiftUI-state-property

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
                NavigationLink(destination: AppFormOpt(), tag: 1, selection: self.$tag){
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
                        let hostRef = rootRef.childByAutoId()
                        
                        let guestsRef = rootRef.child("guest")
                        // guestRef = guestID
                        let guestRef = rootRef.childByAutoId()
                        
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

struct AppForm_Previews: PreviewProvider {
    static var previews: some View {
        AppForm()
    }
}
