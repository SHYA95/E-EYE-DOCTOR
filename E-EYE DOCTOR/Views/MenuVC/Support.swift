//
//  Support.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 05/05/2023.
//


import UIKit
import Cosmos

class SupportViewController: UIViewController {
    static let ID = String(describing: SupportViewController.self)
    @IBOutlet weak var RateStar: CosmosView!
    
    @IBOutlet weak var FeedBackTV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FeedBackTV.layer.borderWidth = 1
        FeedBackTV.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
        FeedBackTV.layer.cornerRadius = 5
        RateStar.settings.fillMode = .half
        RateStar.settings.updateOnTouch = true
        RateStar.didTouchCosmos = { rating in
            // Handle the rating change
            print("Rating: \(rating)")
        }


       }
    @IBAction func Send(_ sender: UIButton) {
        // Show alert
        let alert = UIAlertController(title: "Thank you for your feedback!", message: "We appreciate your input.", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (_) in
            // Navigate to home view controller
            if let navController = self.navigationController {
                navController.popToRootViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }

}

