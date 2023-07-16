//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Shrouk Yasser on 04/02/2023.//
import UIKit
import WebKit

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, WKNavigationDelegate {

    @IBOutlet weak var SearchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var searchResults: [String] = []
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Set the delegate of the text field to self
        SearchTF.delegate = self

        // Set up the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() // Hide empty cells

        // Register the cell class for the identifier
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultCell")

        // Create a WKWebView for displaying search results
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        webView.isHidden = true
        view.addSubview(webView)
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard when the user taps the return key
        textField.resignFirstResponder()

        // Perform the search action
        performSearch()

        return true
    }

    // MARK: - UITableViewDelegate and UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        let result = searchResults[indexPath.row]
        cell.textLabel?.text = result
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle the selected search result
        let selectedResult = searchResults[indexPath.row]
        if let encodedSearchText = selectedResult.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let baseURL = URL(string: "https://www.webmd.com/eye-health/default.htm"),
           let url = URL(string: baseURL.absoluteString + encodedSearchText) {
            webView.isHidden = false
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    // MARK: - Actions

    @IBAction func searchButtonTapped(_ sender: UIButton) {
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

        // Prepare the URL for the search query
        if let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let baseURL = URL(string: "https://www.webmd.com/eye-health/default.htm"),
           let url = URL(string: baseURL.absoluteString + encodedSearchText) {

            // Create an URLSessionDataTask to perform the request
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error performing search: \(error)")
                    return
                }

                if let data = data {
                    // Parse the response data (if needed) and update the UI with the search results

                    // Simulating search results for demonstration
                    let searchResults = self.parseSearchResults(from: data)

                    DispatchQueue.main.async {
                        self.searchResults = searchResults
                        self.tableView.reloadData()
                    }
                }
            }

            // Start the network request
            task.resume()
        }
    }

    private func parseSearchResults(from data: Data) -> [String] {
        // Parse the data and extract the search results
        // Replace this with your own parsing logic based on the structure of the website's HTML or JSON response

        // Simulating search results for demonstration
        let searchResults = ["Most Relevant Result ", "Popular Result", "Recommended Result"]

        return searchResults
    }

    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Hide the web view after the page finishes loading
        webView.isHidden = false
    }
}
