//
//  ReadyTestP3.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 05/05/2023.
//
import UIKit

class ReadyTestP3: UIViewController {
    static let ID = String(describing: ReadyTestP3.self)
    
    @IBOutlet weak var readyTestP3Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        readyTestP3Image.layer.borderWidth = 1
        readyTestP3Image.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor

            }
    
    @IBAction func readyButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VisionTestVC")
        navigationController?.pushViewController(vc, animated: true)
    }
}
