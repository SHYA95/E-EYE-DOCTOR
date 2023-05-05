//
//  SignupVC.swift
//  MyWalletIos
//
//  Created by AliSharaf on 07/04/2023.
//

import UIKit
import Toast_Swift

class SignupVC: UIViewController, SignUPDataLoaded {
    static let ID = String(describing: SignupVC.self)
    
    @IBOutlet weak var userNameTX: UITextField!
    
    @IBOutlet weak var phoneTX: UITextField!
    
    @IBOutlet weak var passwordTX: UITextField!
    let api = SignUPApiHandler()
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    func isSignUPDone(message: String) {
        self.view.makeToast("\(message)")
    }
    
    func isSignUPFail(message: String) {
        self.view.makeToast("\(message)")
    }
    

    @IBAction func SingUpButton(_ sender: Any) {
        api.delegate = self
        guard let userName = userNameTX.text , !userName.isEmpty else { return }
        guard let phone = phoneTX.text , !phone.isEmpty else {
            phoneTX.layer.borderColor = UIColor.red.cgColor // set border color to red
            phoneTX.layer.borderWidth = 1.0 // set border width to 1.0
            phoneTX.layer.cornerRadius = 5.0 // set corner radius to 5.0
            return
        }
        guard let password = passwordTX.text , !password.isEmpty else { return }
        let pass = password // assign value to pass constant

        guard isValidPhone(phone) else {
            phoneTX.layer.borderColor = UIColor.red.cgColor // set border color to red
            phoneTX.layer.borderWidth = 1.0 // set border width to 1.0
            phoneTX.layer.cornerRadius = 5.0 // set corner radius to 5.0
            self.view.makeToast("Invalid phone number")
            return
            
        }
        phoneTX.layer.borderWidth = 0.0 // reset border width to 0.0
        api.registerMethod(phone: phone, userName: userName, password: pass)
    }

    // function to validate phone number
    func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^\\d{10}$" // regex to match 10-digit phone number
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
    

    
    @IBAction func LoginButton(_ sender: Any) {
        popScreen()
    }
    
}
