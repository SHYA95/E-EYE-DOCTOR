import UIKit
import Toast_Swift
import FirebaseAuth
import FirebaseFirestore

class SignupVC: UIViewController {
    static let ID = String(describing: SignupVC.self)
    
    @IBOutlet weak var userNameTX: UITextField!
    @IBOutlet weak var emailTX: UITextField!
    @IBOutlet weak var passwordTX: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SingUpButton(_ sender: Any) {
        guard let username = userNameTX.text, !username.isEmpty else {
            self.view.makeToast("Please enter your username")
            return
        }
        
        guard let email = emailTX.text, !email.isEmpty else {
            self.view.makeToast("Please enter your email")
            return
        }
        
        guard let password = passwordTX.text, !password.isEmpty else {
            self.view.makeToast("Please enter your password")
            return
        }
        
        signUpUser(with: email, password: password, username: username)
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        popScreen()
    }
    
    // Function to validate email address
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Function to sign up the user using email and password
    private func signUpUser(with email: String, password: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.view.makeToast("Sign up failed: \(error.localizedDescription)")
                return
            }
            
            // User registration successful, save additional data
            guard let resultUser = result?.user else {
                strongSelf.view.makeToast("Sign up failed. Please try again.")
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email
                ]) { error in
                    if let error = error {
                        strongSelf.view.makeToast("Sign up failed: \(error.localizedDescription)")
                        return
                    }
                   
                    strongSelf.handleSignUpSuccess()
                }
        }
    }
    
    
    // Handle successful signup
    private func handleSignUpSuccess() {
        self.view.makeToast("Sign up successful!")
    }
}
