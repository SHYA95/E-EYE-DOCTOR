import UIKit
import AEOTPTextField
import FirebaseAuth

class OTPVC: UIViewController, AEOTPTextFieldDelegate {
    static let ID = String(describing: OTPVC.self)
    
    var otp: String? // Property to hold the OTP value
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var otpTextField: AEOTPTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.setTitle(NSLocalizedString("Submit", comment: "Submit"), for: .normal)
        
        otpTextField.otpDelegate = self
        otpTextField.configure(with: 6)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let enteredOTP = otpTextField.text else {
            return
        }
        
        if let otp = otp, otp == enteredOTP {
            // OTP verification successful
            handleOTPVerificationSuccess()
        } else {
            // OTP verification failed
            handleOTPVerificationFailure()
        }
    }
    
    private func handleOTPVerificationSuccess() {
        // Perform any actions needed when OTP verification is successful
        // For example, navigate to the home screen
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeTabBar")
        navigationController?.pushViewController(homeVC, animated: true)
    }
    
    private func handleOTPVerificationFailure() {
        // Show an alert or display an error message to the user
        // For example, display an alert indicating that the entered OTP is incorrect
        
        let alert = UIAlertController(title: "Invalid OTP", message: "The entered OTP is incorrect. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func didUserFinishEnter(the code: String) {
        print("User finished entering OTP: \(111111)")
    }
}
