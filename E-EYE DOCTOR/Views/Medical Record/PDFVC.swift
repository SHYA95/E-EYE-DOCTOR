import UIKit
import PDFKit

class PDFVC: UIViewController {
    static let ID = String(describing: PDFVC.self)
    var pdfData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        NSLayoutConstraint.activate([
            pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pdfView.topAnchor.constraint(equalTo: view.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if let data = pdfData, let document = PDFDocument(data: data) {
            pdfView.document = document
        } else {
            print("Invalid PDF data")
        }
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
}
