
//  ClassificationAnswer.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 01/07/2023.


//import UIKit
//
//class ClassificationAnswerVC: UIViewController {
//    var selectedImage: UIImage?
////    let classificationModel = ImageClassificationModel()
//
//    let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    let resultTextField: UITextField = {
//        let textField = UITextField()
//        textField.borderStyle = .roundedRect
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//        let imageClassifierWrapper = try? EyeImageClassification(configuration: defaultConfig)
//
//        view.addSubview(imageView)
//        NSLayoutConstraint.activate([
//            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            imageView.widthAnchor.constraint(equalToConstant: 200),
//            imageView.heightAnchor.constraint(equalToConstant: 200)
//        ])
//
//        view.addSubview(resultTextField)
//        NSLayoutConstraint.activate([
//            resultTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            resultTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            resultTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
//            resultTextField.heightAnchor.constraint(equalToConstant: 40)
//        ])
//
//        if let image = selectedImage {
//            imageView.image = image
//            let classificationResult = classificationModel.classifyImage(image)
//            resultTextField.text = classificationResult
//        }
//    }
//}











//import UIKit
//import Vision
//
//class ClassificationAnswerVC: UIViewController {
//    var selectedImage: UIImage?
//    let classificationModel = EyeImageClassification()
//
//    let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    let resultTextField: UITextField = {
//        let textField = UITextField()
//        textField.borderStyle = .roundedRect
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        view.addSubview(imageView)
//        NSLayoutConstraint.activate([
//            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            imageView.widthAnchor.constraint(equalToConstant: 200),
//            imageView.heightAnchor.constraint(equalToConstant: 200)
//        ])
//
//        view.addSubview(resultTextField)
//        NSLayoutConstraint.activate([
//            resultTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            resultTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            resultTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
//            resultTextField.heightAnchor.constraint(equalToConstant: 40)
//        ])
//
//        if let image = selectedImage {
//            imageView.image = image
//            let classificationResult = classificationModel.classifyImage(image)
//            resultTextField.text = classificationResult
//        }
//    }
//}
//
//class ImageClassificationModel: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    let imagePicker = UIImagePickerController()
//
//    override init() {
//        super.init()
//
//        imagePicker.delegate = self
//    }
//
//    func showImagePicker() {
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            imagePicker.sourceType = .photoLibrary
//            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
//        }
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage {
//            picker.dismiss(animated: true, completion: nil)
//            showClassificationResult(image: image)
//        }
//    }
//
//    func showClassificationResult(image: UIImage) {
//        let resultVC = ClassificationAnswerVC()
//        resultVC.selectedImage = image
//        UIApplication.shared.keyWindow?.rootViewController?.navigationController?.pushViewController(resultVC, animated: true)
//    }
//}




//
//
//
//
//
//import UIKit
//import CoreML
//import Vision
//
//
//class ClassificationAnswerVC: UIViewController {
//    var selectedImage: UIImage?
//    let classificationModel = ImageClassificationModel()
//    
//    let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    let resultTextField: UITextField = {
//        let textField = UITextField()
//        textField.borderStyle = .roundedRect
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .white
//        
//        view.addSubview(imageView)
//        NSLayoutConstraint.activate([
//            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            imageView.widthAnchor.constraint(equalToConstant: 200),
//            imageView.heightAnchor.constraint(equalToConstant: 200)
//        ])
//        
//        view.addSubview(resultTextField)
//        NSLayoutConstraint.activate([
//            resultTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            resultTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            resultTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
//            resultTextField.heightAnchor.constraint(equalToConstant: 40)
//        ])
//        
//        if let image = selectedImage {
//            imageView.image = image
//            let classificationResult = classificationModel.classifyImage(image)
//            resultTextField.text = classificationResult
//        }
//    }}
//
//    class ImageClassificationModel {
//        func classifyImage(_ image: UIImage) -> String {
//            // Perform image classification using your Core ML model
//            // Replace this placeholder code with your actual implementation
//            
//            // Convert the UIImage to a CVPixelBuffer
//            guard let pixelBuffer = image.pixelBuffer() else {
//                return "Error: Failed to convert image to pixel buffer."
//            }
//            
//            // Create a Vision request with your Core ML model
//            guard let model = try? VNCoreMLModel(for: EyeImageClassification().model) else {
//                return "Error: Failed to create Vision model."
//            }
//            let request = VNCoreMLRequest(model: model) { (request, error) in
//                if let error = error {
//                    print("Error classifying image: \(error.localizedDescription)")
//                    return
//                }
//                
//                guard let results = request.results as? [VNClassificationObservation],
//                      let topResult = results.first else {
//                    return
//                }
//                
//                let classificationResult = topResult.identifier
//                print("Classification result: \(classificationResult)")
//                // Update the UI with the classification result
//                // You can return the result if needed or update the UI directly in this method
//                // For example:
//                DispatchQueue.main.async {
//                    self.resultTextField.text = classificationResult
//                }
//            }
//            
//            // Perform the classification request
//            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
//            do {
//                try handler.perform([request])
//            } catch {
//                print("Error performing classification request: \(error.localizedDescription)")
//            }
//            
//            return "Classifying Image..."
//        }
//    }
