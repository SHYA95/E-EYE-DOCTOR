import UIKit

    class ColorTestVC: UIViewController {
        
        @IBOutlet weak var btnTest4: UIButton!
        
        @IBOutlet weak var btnTest3: UIButton!
        
        @IBOutlet weak var btnTest2: UIButton!
        
        @IBOutlet weak var btnTest1: UIButton!
        
        
        @IBOutlet weak var visionTestImage: UIImageView!
        @IBOutlet weak var testView: UIView!
        
        var images: [UIImage] = [
            UIImage(named: "44")!,
            UIImage(named: "11")!,
            UIImage(named: "33")!,
            UIImage(named: "4")!
        ]
        
        var currentImageIndex: Int = 0
        var selectedButton: UIButton?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            testView.layer.cornerRadius = 10
            testView.layer.borderWidth = 2
            testView.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
            
            showNextImage()
        }
        
        @IBAction func btnTest1(_ sender: UIButton) {
            handleButtonSelection(sender)
        }
        
        @IBAction func btnTest2(_ sender: UIButton) {
            handleButtonSelection(sender)
        }
        
        @IBAction func btnTest3(_ sender: UIButton) {
            handleButtonSelection(sender)
        }
        
        @IBAction func btnTest4(_ sender: UIButton) {
            handleButtonSelection(sender)
        }
        
        func showNextImage() {
            guard currentImageIndex < images.count else {
                let numMatches = countMatches()
                let message: String
                
                switch numMatches {
                case 4:
                    message = "You have healthy eyes."
                case 3:
                    message = "Take care of your eyes."
                case 2:
                    message = "You may have color blindness. You should consult a doctor."
                case 1:
                    message = "You have 1 match and 3 mismatches. You may have color blindness. You should consult a doctor."
                default:
                    message = "You are definitely color blind."
                }
                
                let alertController = UIAlertController(title: "Test Result", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.navigationController?.popToRootViewController(animated: true)
                }
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                
                return
            }
            
            visionTestImage.image = images[currentImageIndex]
            selectedButton?.isSelected = false
            selectedButton = nil
            currentImageIndex += 1
        }
        
        func handleButtonSelection(_ button: UIButton) {
            selectedButton?.isSelected = false
            button.isSelected = true
            selectedButton = button
            
            if currentImageIndex == images.count  {
                checkTestResult()
            }
        }
        
        func checkTestResult() {
            let numMatches = countMatches()
            let message: String
            
            switch numMatches {
            case 4:
                message = "You have healthy eyes."
            case 3:
                message = "Take care of your eyes."
            case 2:
                message = "You may have color blindness. You should consult a doctor."
            case 1:
                message = "You have 1 match and 3 mismatches. You may have color blindness. You should consult a doctor."
            default:
                message = "You are definitely color blind."
            }
            
            let alertController = UIAlertController(title: "Test Result", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.showNextImage()
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        
        func countMatches() -> Int {
                var count = 0
                if btnTest4.isSelected {
                    count += 1
                }
                if btnTest3.isSelected {
                    count += 1
                }
                if btnTest2.isSelected {
                    count += 1
                }
                if btnTest1.isSelected {
                    count += 1
                }
                return count
            }
        
        
        @IBAction func nextButtonTapped(_ sender: Any) {
            showNextImage()
        }
    }
