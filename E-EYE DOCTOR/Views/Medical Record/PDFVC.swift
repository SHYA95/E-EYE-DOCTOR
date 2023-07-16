import UIKit
import PDFKit

class PDFVC: UIViewController, PDFViewDelegate {
    static let ID = String(describing: PDFVC.self)
    var pdfData: Data?
    var pdfView: PDFView!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Add a headline label in the top middle of the page
        let headlineLabel = UILabel()
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineLabel.text = "PDF Viewer"
        headlineLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headlineLabel.textColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1) // Set the tint color of the app
        view.addSubview(headlineLabel)
        
        // Add constraints to center the headline label horizontally and position it at the top of the view
        NSLayoutConstraint.activate([
            headlineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headlineLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
        
        pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.delegate = self // Set the delegate to enable searching
        view.addSubview(pdfView)
        
        NSLayoutConstraint.activate([
            pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pdfView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 60),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        ])
        
        pdfView.layer.borderWidth = 2 // Add border to the PDF view
        pdfView.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor // Set the border color (e.g., red)
        
        if let data = pdfData, let document = PDFDocument(data: data) {
            pdfView.document = document
        } else {
            print("Invalid PDF data")
        }
        
        configureSearchController()
    }
    
    func configureSearchController() {
//        searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.delegate = self
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func savePDFDataToFile() {
        guard let pdfData = pdfData else {
            print("No PDF data to save")
            return
        }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filename = "medicalRecord.pdf"
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        
        do {
            try pdfData.write(to: fileURL)
            print("PDF data saved to file: \(fileURL.absoluteString)")
        } catch {
            print("Error saving PDF data to file: \(error.localizedDescription)")
        }
    }
    
    // Implement the PDFViewDelegate method to handle searching manually
    func didMatchString(_ instance: PDFSelection) {
        pdfView.highlightedSelections = [instance]
        pdfView.go(to: instance)
    }
}

//extension PDFVC: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if let searchTerm = searchBar.text {
//            pdfView.highlightedSelections = [] // Clear previous highlights
//
//            if let document = pdfView.document {
//                for pageIndex in 0..<document.pageCount {
//                    let page = document.page(at: pageIndex)
////                    if let selections = page?.findOccurrences(of: searchTerm, options: [.caseInsensitive]) {
////                        pdfView.highlightedSelections.append(contentsOf: selections)
//                    //}
//                }
//
//                if let firstSelection = pdfView.highlightedSelections?.first {
//                    pdfView.go(to: firstSelection)
//                }
//            }
//        }
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        pdfView.highlightedSelections = [] // Clear highlights
//    }
//}
//
//extension PDFVC: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        // No implementation needed
//    }
//}
