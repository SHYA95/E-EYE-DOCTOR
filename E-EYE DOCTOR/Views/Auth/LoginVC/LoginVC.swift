import UIKit
import Toast_Swift
import FirebaseAuth

class LoginVC: UIViewController {
    static let ID = String(describing: LoginVC.self)
   

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginButton.isUserInteractionEnabled = true
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1.0
            emailTextField.layer.cornerRadius = 5.0
            self.view.makeToast("Please enter your email")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 1.0
            passwordTextField.layer.cornerRadius = 5.0
            self.view.makeToast("Please enter your password")
            return
        }
        
        loginUser(with: email, password: password)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        navigate(storyBoard: "Main", ID: SignupVC.ID)
    }
    
    // Function to validate email address
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Function to log in the user using email and password
    private func loginUser(with email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.view.makeToast("Login failed: \(error.localizedDescription)")
                return
            }
            strongSelf.sendOTP(to: email)
            // Login successful, handle the result as desired
            strongSelf.handleLoginSuccess()
        }
    }
    // Send OTP to user's email
        private func sendOTP(to email: String) {
            // Generate a 6-digit OTP
            let otp = String(format: "%06d", arc4random_uniform(1000000))
            
            
            // Send the OTP to the user's email using your preferred method (e.g., email service, API)
            // Here, we use the Firebase Auth sendPasswordResetEmail function to send the OTP as a password reset email
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    print("Failed to send OTP: \(error.localizedDescription)")
                    return
                }
                
                print("OTP sent successfully")
            }
        }

    // Handle successful login
    private func handleLoginSuccess() {
        print("LoginDone")
        // Perform any additional tasks after successful login
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeTabBar")

        navigationController?.pushViewController(vc, animated: true)
    }
}
