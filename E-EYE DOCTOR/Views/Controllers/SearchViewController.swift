//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Shrouk Yasser on 04/02/2023.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var SearchTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Set the delegate of the text field to self
        SearchTF.delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard when the user taps the return key
        textField.resignFirstResponder()
        
        // Perform the search action
        performSearch()
        
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func Searchbutton(_ sender: UIButton) {
        // Hide the keyboard when the user taps the search button
        SearchTF.resignFirstResponder()
        
        // Perform the search action
        performSearch()
    }
    
    // MARK: - Private methods
    
    private func performSearch() {
        // Get the search text from the text field
        guard let searchText = SearchTF.text, !searchText.isEmpty else {
            // Show an alert if the search text is empty
            let alert = UIAlertController(title: "Search Error", message: "Please enter a search term", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Perform the search action
        // ...
    }
}
