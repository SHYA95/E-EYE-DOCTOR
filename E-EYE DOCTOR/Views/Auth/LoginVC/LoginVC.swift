//
//  LoginVC.swift
//  MyWalletIos
//
//  Created by AliSharaf on 06/04/2023.
//

import UIKit
import Toast_Swift

class LoginVC: UIViewController, LoginDataLoaded {
    static let ID = String(describing: LoginVC.self)
    
    @IBOutlet weak var userPhoneTX: UITextField!
    @IBOutlet weak var passwordTX: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let api = LoginApiHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginButton.isUserInteractionEnabled = true
    }
    
    func isloginDone(userData: LoginModel) {
        print("LoginDone")
        UserDefaults.standard.set(userData.userName, forKey: "username")
        UserDefaults.standard.set(userData.token, forKey: "accessToken")
        UserDefaults.standard.set(userData.phone, forKey: "phone")
     
        print("yall")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeTabBar")
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func isloginFail(message: String) {
        self.view.makeToast("\(message)")
    }
    
    @IBAction func loginButton(_ sender: Any) {
        api.delegate = self
        guard let phoneNumber = userPhoneTX.text, !phoneNumber.isEmpty else {
            userPhoneTX.layer.borderColor = UIColor.red.cgColor
            userPhoneTX.layer.borderWidth = 1.0
            userPhoneTX.layer.cornerRadius = 5.0
            self.view.makeToast("Please enter your phone number")
            return
        }
        guard let password = passwordTX.text, !password.isEmpty else {
            passwordTX.layer.borderColor = UIColor.red.cgColor
            passwordTX.layer.borderWidth = 1.0
            passwordTX.layer.cornerRadius = 5.0
            self.view.makeToast("Please enter your password")
            return
        }
        
        guard isValidPhone(phoneNumber) else {
            userPhoneTX.layer.borderColor = UIColor.red.cgColor
            userPhoneTX.layer.borderWidth = 1.0
            userPhoneTX.layer.cornerRadius = 5.0
            self.view.makeToast("Please enter a valid phone number")
            return
        }
        
        userPhoneTX.layer.borderWidth = 0.0
        passwordTX.layer.borderWidth = 0.0
        api.loginMethod(phone: phoneNumber, pass: password)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        navigate(storyBoard: "Main", ID: SignupVC.ID)
    }
    
    // function to validate phone number
    func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^\\d{11}$" // regex to match 10-digit phone number
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
    
}
