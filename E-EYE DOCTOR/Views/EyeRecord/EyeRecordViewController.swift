//
//  EyeRecordViewController.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 05/05/2023.
//

import UIKit

class EyeRecordViewController: UIViewController {
    
    @IBOutlet weak var uploadEyeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a border to the image view
        uploadEyeImage.layer.borderWidth = 1
        uploadEyeImage.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
    }
}
