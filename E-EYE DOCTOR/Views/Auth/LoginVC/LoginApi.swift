//
//  LoginApi.swift
//  MyWalletIos
//
//  Created by AliSharaf on 06/04/2023.
//
import Alamofire
import Foundation

protocol LoginDataLoaded {
    func isloginDone(userData: LoginModel)
    func isloginFail(message: String)
}

class LoginApiHandler {
    var delegate: LoginDataLoaded?
    static let instance = LoginApiHandler()
    
    func loginMethod(phone: String, pass: String) {
        let params: Parameters = [
            "Phone": phone,
            "Password": pass
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic UIOIKMJOYWRtaW46cGFzc3dvcmQ="
        ]
        
        guard let url = URL(string: "http://207.180.239.207:8000/api/login") else { return }
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: LoginModel.self) { response in
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case 200:
                    switch response.result {
                    case .success(let loginResponse):
                        // Save the user name and password in UserDefaults
                       
                        UserDefaults.standard.set(loginResponse.id, forKey: "UserId")
                        UserDefaults.standard.set(loginResponse.userName, forKey: "UserName")
                        UserDefaults.standard.set(pass, forKey: "Password")
                        UserDefaults.standard.set(loginResponse.balance, forKey: "Balance")

                        self.delegate?.isloginDone(userData: loginResponse)
                    case .failure(_):
                        let message = "Please try again"
                        self.delegate?.isloginFail(message: message)
                    }
                default:
                    let message = "User not found"
                    self.delegate?.isloginFail(message: message)
                }
            } else {
                let message = "Unexpected error occurred. Please try again later."
                self.delegate?.isloginFail(message: message)
            }
        }
    }
}
