//
//  ApplyFormOpt.swift
//  Insider
//
//  Created by 유수진 on 2023/09/16.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct ApplyFormOpt: View {
    @State private var tag:Int? = nil
    @State var hobby: String = ""
    @State var mbti: String = ""
    @State var smoking: String = ""
    @State var alcohol: String = ""
    @State var pet: String = ""
    @State var religion: String = ""
    
    var body: some View {
        VStack{
            Group{
                Text("선택 정보")
                    .font(.system(size: 40))
                    .fontWeight(.medium)
                    .frame(width: 350, alignment: .leading)
                    .padding(.bottom, 10)
                Spacer()
                NavigationLink(destination: Submit(), tag: 2, selection: self.$tag){
                }
            }
            Spacer()
            Group
            {
                HStack{
                    TextField("취미: ", text: $hobby)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("MBTI: ", text: $mbti)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("흡연유무: ", text: $smoking)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("주량: ", text: $alcohol)
                        .frame(width: 300, height: 30)
                        .keyboardType(.decimalPad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("반려동물: ", text: $pet)
                        .frame(width: 300, height: 30)
                        .keyboardType(.namePhonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                
                HStack{
                    TextField("종교: ", text: $religion)
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
                        var uid = 1
                        let guestInfo = Database.database().reference(withPath: "guestInfo")
                            .child(String(uid))
//                            .childByAutoId()
                        uid += 1
                        let userItemRef = guestInfo.child("user")
                        let values: [String: Any] = [ "hobby": hobby, "mbti": mbti, "smoking": smoking, "alcohol": alcohol, "pet": pet, "religion": religion]
                        userItemRef.setValue(values)
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

struct ApplyFormOpt_Previews: PreviewProvider {
    static var previews: some View {
        ApplyFormOpt()
    }
}
