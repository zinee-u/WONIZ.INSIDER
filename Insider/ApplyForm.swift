//
//  ApplyForm.swift
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

struct ApplyForm: View {
    @State var name: String = ""
    @State var birthday: String = ""
    @State var gender: String = ""
    @State var height: String = ""
    @State var job: String = ""
    @State var location: String = ""
    @State var _1stNode: String = ""
    @State var isLogin: Bool = false
    
    func isButtonValid() -> Bool {
        return name.count > 1 && birthday.count > 1 && isLogin == true
    }
    
    /* ID field */
    var body: some View {
        VStack{
            Text("필수 정보")
                .font(.system(size: 40))
                .fontWeight(.medium)
                .frame(width: 350, alignment: .leading)
                .padding(.bottom, 10)
            Spacer()

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
                TextField("직업(회사/직무): ", text: $job)
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
                    let guestInfo = Database.database().reference(withPath: "guestInfo")
                    let userItemRef = guestInfo.child("user")
                    let values: [String: Any] = [ "name": name, "birthday": birthday, "gender": gender, "height": height, "job": job, "location": location, "1stnode": _1stNode]
                    userItemRef.setValue(values)
                }, label:{
                    Text("Submit")
                })
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
        }
    }
}

struct ApplyForm_Previews: PreviewProvider {
    static var previews: some View {
        ApplyForm()
    }
}
