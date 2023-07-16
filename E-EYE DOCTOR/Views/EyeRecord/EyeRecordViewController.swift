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
        let cornerRadius: CGFloat = 10
        super.viewDidLoad()
        
        uploadEyeImage.layer.cornerRadius = cornerRadius
        uploadEyeImage.layer.borderWidth = 2
        uploadEyeImage.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
    }
}
