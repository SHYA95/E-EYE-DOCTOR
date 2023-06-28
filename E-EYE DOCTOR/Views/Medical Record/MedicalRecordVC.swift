//
//  MedicalRecordVC.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 05/05/2023.
//

import UIKit
import PDFKit


class MedicalRecordVC: UIViewController {
  
    
    @IBOutlet weak var NameTF: UITextField!
    
    @IBOutlet weak var DateTF: UITextField!
    
    @IBOutlet weak var AgeTF: UITextField!
    
    @IBOutlet weak var BloodTypeTF: UITextField!
    
    @IBOutlet weak var DiseaseTF: UITextField!
    
    
    @IBOutlet weak var MoreInfoTF: UITextField!
    func createPDF() -> Data? {
        let pdfMetaData = [        kCGPDFContextCreator: "Your App Name",        kCGPDFContextAuthor: "Your Name"    ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        let pageRect = CGRect(x: 0, y: 0, width: 8.5 * 72.0, height: 11 * 72.0)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let data = renderer.pdfData { (context) in
            context.beginPage()
            let attributes = [            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)        ]
            let name = NSAttributedString(string: "Name: \(NameTF.text ?? "")\n", attributes: attributes)
            name.draw(in: CGRect(x: 20, y: 20, width: pageRect.width - 40, height: 50))
            let date = NSAttributedString(string: "Date: \(DateTF.text ?? "")\n", attributes: attributes)
            date.draw(in: CGRect(x: 20, y: 70, width: pageRect.width - 40, height: 50))
            let age = NSAttributedString(string: "Age: \(AgeTF.text ?? "")\n", attributes: attributes)
            age.draw(in: CGRect(x: 20, y: 120, width: pageRect.width - 40, height: 50))
            let bloodType = NSAttributedString(string: "Blood Type: \(BloodTypeTF.text ?? "")\n", attributes: attributes)
            bloodType.draw(in: CGRect(x: 20, y: 170, width: pageRect.width - 40, height: 50))
            let disease = NSAttributedString(string: "Disease: \(DiseaseTF.text ?? "")\n", attributes: attributes)
            disease.draw(in: CGRect(x: 20, y: 220, width: pageRect.width - 40, height: 50))
            let moreInfo = NSAttributedString(string: "More Info: \(MoreInfoTF.text ?? "")\n", attributes: attributes)
            moreInfo.draw(in: CGRect(x: 20, y: 270, width: pageRect.width - 40, height: 50))
        }
        return data
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NameTF.setCustomStyle()
        DateTF.setCustomStyle()
        AgeTF.setCustomStyle()
        BloodTypeTF.setCustomStyle()
        DiseaseTF.setCustomStyle()
        MoreInfoTF.setCustomStyle()
    }

    @IBAction func Submit(_ sender: UIButton) {
        guard let data = createPDF() else { return }
        print("done")
        let pdfVC = PDFVC()
        pdfVC.pdfData = data
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PDFVC") as! PDFVC
        present(vc, animated: true)
    }

    
        }

extension UITextField {
    func setCustomStyle() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
       self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
    }
    
}
