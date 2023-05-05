////
////  SignupApi.swift
////  MyWalletIos
////
////  Created by apple on 07/04/2023.
////
import SwiftUI
import Alamofire
import Foundation

protocol SignUPDataLoaded{
    func isSignUPDone(message:String)
    func isSignUPFail(message:String)
}

class SignUPApiHandler{
    var delegate:SignUPDataLoaded?
    static let instance = SignUPApiHandler()
    func registerMethod(phone: String, userName: String, password: String) {
        let params: Parameters = [
            "Phone": phone,
            "Password":password,
            "userName":userName
        ]
        let headers : HTTPHeaders = [
                   "Authorization": "Basic UIOIKMJOYWRtaW46cGFzc3dvcmQ="
    ]
        guard let url = URL(string: "http://207.180.239.207:8000/api/signup") else {return}
        AF.request(url, method: .post,parameters: params,encoding: JSONEncoding.default,headers:headers).responseDecodable(of:SignupModel.self ) { respone in
            switch respone.result{
            case.success(let register):
                self.delegate?.isSignUPDone(message: register.date ?? "")
            case.failure(_):
                let message = "Please try agine"
                self.delegate?.isSignUPFail(message: message)
            }
        }
    }
}
