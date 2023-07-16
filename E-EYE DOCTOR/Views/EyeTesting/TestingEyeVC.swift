//
//  TestingEyeVC.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 05/07/2023.
//

import UIKit

class TestingEyeVC: UIViewController {
    
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add borders to the views
        View1.layer.borderWidth = 2
        View1.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
        View2.layer.borderWidth = 2
        View1.layer.cornerRadius=10
        View2.layer.cornerRadius=10
        View2.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
    }
    
    @IBAction func SightMeasure(_ sender: UIButton) {
    }
    
    @IBAction func ColorVision(_ sender: UIButton) {
//        let colorVisionVC = ColorTestVC() // Replace with the actual view controller class name for ColorVisionVC
//        navigationController?.pushViewController(colorVisionVC, animated: true)
    }
}
