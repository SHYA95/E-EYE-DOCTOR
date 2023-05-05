//
//  ReadyTestP2.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 05/05/2023.
//

import UIKit

class ReadyTestP2: UIViewController {
    static let ID = String(describing: ReadyTestP2.self)
    
    @IBOutlet weak var ReadyTestP2Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a border to the image view
        ReadyTestP2Image.layer.borderWidth = 1
        ReadyTestP2Image.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
    }
    @IBAction func NextButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReadyTestP3")
        navigationController?.pushViewController(vc, animated: true)
    }

}
