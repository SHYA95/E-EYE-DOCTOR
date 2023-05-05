//
//  ReadyTestP3.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 05/05/2023.
//

import UIKit

class ReadyTestP3: UIViewController {
    static let ID = String(describing: ReadyTestP3.self)
    @IBOutlet weak var ReadyTestP3Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a border to the image view
        ReadyTestP3Image.layer.borderWidth = 1
        ReadyTestP3Image.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
    }
    
    @IBAction func ReadyButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReadyTestP2")
        navigationController?.pushViewController(vc, animated: true)
    }
}
