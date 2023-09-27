////
////  EyeScanningViewController.swift
////  E-Eye Doctor
////
////  Created by Shrouk Yasser on 06/03/2023.
////
////
////
//
import UIKit
import CoreML
import Vision
let classificationOrder = ["Dry Eye", "Cataract", "Bulging", "Normal Eye", "Not an Eye"]


class EyeScanningViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    var selectedImage: UIImage?
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please select which method using to scan your eye.\n"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 0.33, green: 0.71, blue: 0.71, alpha: 1.00)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    let classifyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.325, green: 0.706, blue: 0.714, alpha: 1)
        button.setTitle("Classify", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(classifyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let classificationTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Classification Answer"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        textField.textColor = .darkGray
//        textField.textColor = UIColor(red: 0.325, green: 0.706, blue: 0.714, alpha: 1)
        textField.textAlignment = .center
        return textField
    }()

    private let cellReuseIdentifier = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        if let modelURL = Bundle.main.url(forResource: "EyeClassifier", withExtension: "mlmodel") {
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(headerLabel)
        setupCollectionView()
        setupImageView()
        setupClassifyButton()
        setupClassificationTextField()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            collectionView.heightAnchor.constraint(equalToConstant: 150),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    
    
    func setupImageView() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setupClassifyButton() {
        view.addSubview(classifyButton)
        
        NSLayoutConstraint.activate([
            classifyButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            classifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            classifyButton.widthAnchor.constraint(equalToConstant: 200),
            classifyButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupClassificationTextField() {
        view.addSubview(classificationTextField)
        
        NSLayoutConstraint.activate([
            classificationTextField.topAnchor.constraint(equalTo: classifyButton.bottomAnchor, constant: 8),
            classificationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            classificationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            classificationTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! MyCollectionViewCell
        
        // Configure the cell with an image and a button
        if indexPath.row == 0 {
            cell.imageView.image = UIImage(named: "2")
            cell.Photobutton.setTitle("Upload photo", for: .normal)
        } else {
            cell.imageView.image = UIImage(named: "1")
            cell.Photobutton.setTitle("Take a photo", for: .normal)
        }
        cell.Photobutton.tag = indexPath.row
        cell.Photobutton.addTarget(self, action: #selector(handlePhotoButtonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 48) / 2
        let height: CGFloat = 100
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: - Actions
    
    
    @objc func handlePhotoButtonTapped(sender: UIButton) {
        if sender.tag == 0 {
            // Upload photo button tapped
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            // Take a photo button tapped
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //    @objc func classifyButtonTapped() {
    //           guard let image = selectedImage else {
    //               // Show an error message asking the user to select an image
    //               let alert = UIAlertController(title: "Error", message: "Please select an image first.", preferredStyle: .alert)
    //               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    //               alert.addAction(okAction)
    //               present(alert, animated: true, completion: nil)
    //               return
    //           }
    //
    //           // Perform classification using Core ML model
    //           if let modelURL = Bundle.main.url(forResource: "EyeClassifier", withExtension: "mlmodel"),
    //              let model = try? VNCoreMLModel(for: MLModel(contentsOf: modelURL)) {
    //
    //               var classificationIndex = 0
    //               var classificationResult: VNClassificationObservation?
    //
    //               let request = VNCoreMLRequest(model: model) { (request, error) in
    //                   if let results = request.results as? [VNClassificationObservation], let topResult = results.first {
    //                       classificationResult = topResult
    //                   }
    //               }
    //
    //               let imageRequestHandler = VNImageRequestHandler(ciImage: CIImage(image: image)!, options: [:])
    //               DispatchQueue.global(qos: .userInitiated).async {
    //                               while classificationResult == nil && classificationIndex < classificationOrder.count {
    //                                   let classification = classificationOrder[classificationIndex]
    //                                   classificationIndex += 1
    //
    //                                   request.imageCropAndScaleOption = .centerCrop // Optional: Adjust imageCropAndScaleOption if needed
    //
    //                                   do {
    //                                       try imageRequestHandler.perform([request])
    //                                   } catch {
    //                                       print("Error: \(error)")
    //                                   }
    //                               }
    //
    //                               DispatchQueue.main.async {
    //                                   if let topResult = classificationResult {
    //                                       self.classificationTextField.text = topResult.identifier
    //                                   } else {
    //                                       self.classificationTextField.text = "Classification not available"
    //                                   }
    //                               }
    //                           }
    //                       }
    //                   }
    
    var tapCounter = 0
    
    @objc func classifyButtonTapped() {
        guard let image = selectedImage else {
            // Display an alert if no image is selected
            let alert = UIAlertController(title: "Error", message: "Please select an image first.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        tapCounter += 1
        
        // Perform classification on the selected image using your ML model
        if let classificationResult = performClassification(image) {
            classificationTextField.text = classificationResult
        } else {
//            classificationTextField.text = "Normal eye"
            if tapCounter < 5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.classifyButtonTapped()
                }
            }
        
        }
    }
    
    func performClassification(_ image: UIImage) -> String? {
        // Replace this with your classification logic using the ML model
        
        switch tapCounter {
        case 1:
            return classificationOrder[0]
        case 2:
            return classificationOrder[1]
        case 3:
            return classificationOrder[2]
        case 4:
            return classificationOrder[3]
        case 5:
            return classificationOrder[4]
        default:
            return classificationOrder.randomElement()
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            self.selectedImage = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Classification
    
    //    func performClassification(_ image: UIImage) -> String? {
    //        guard let model = try? EyeClassifier(configuration: MLModelConfiguration()) else {
    //
    //            print("Failed to load the Core ML model")
    //            return nil
    //        }
    //
    //        guard let pixelBuffer = image.pixelBuffer(width: 224, height: 224) else {
    //            print("Failed to convert image to pixel buffer")
    //            return nil
    //        }
    //
    //        guard let output = try? model.prediction(image: pixelBuffer) else {
    //            print("Failed to perform classification")
    //            return nil
    //        }
    //
    //        let classificationResult = output.classLabel
    //
    //        return classificationResult
    //    }}
    //
    //
    
}


class MyCollectionViewCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()

    let Photobutton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.325, green: 0.706, blue: 0.714, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "comic sans ms", size: 12)
        button.layer.cornerRadius = 10
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        contentView.addSubview(Photobutton)

        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
        contentView.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.5),

            Photobutton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            Photobutton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            Photobutton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            Photobutton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            Photobutton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {
    func pixelBuffer(width: Int, height: Int) -> CVPixelBuffer? {
        let attrs = [
            kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
            kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue
        ] as CFDictionary

        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            width,
            height,
            kCVPixelFormatType_32ARGB,
            attrs,
            &pixelBuffer
        )

        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            return nil
        }

        CVPixelBufferLockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(buffer)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(
            data: pixelData,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
        )

        guard let cgImage = self.cgImage, let ctx = context else {
            return nil
        }

        ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        CVPixelBufferUnlockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))

        return buffer
    }
}

class ClassificationAnswerVC: UIViewController {
    var selectedImage: UIImage?

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    let classifyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.325, green: 0.706, blue: 0.714, alpha: 1)
        button.setTitle("Classify", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(classifyButtonTapped), for: .touchUpInside)
        return button
    }()

    let classificationTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Classification Answer"
        textField.borderStyle = .roundedRect
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupImageView()
        setupClassifyButton()
        setupClassificationTextField()
    }

    func setupImageView() {
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }

    func setupClassifyButton() {
        view.addSubview(classifyButton)

        NSLayoutConstraint.activate([
            classifyButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            classifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            classifyButton.widthAnchor.constraint(equalToConstant: 200),
            classifyButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupClassificationTextField() {
        view.addSubview(classificationTextField)

        NSLayoutConstraint.activate([
            classificationTextField.topAnchor.constraint(equalTo: classifyButton.bottomAnchor, constant: 16),
            classificationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            classificationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            classificationTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }


    // MARK: - Actions

    @objc func classifyButtonTapped() {
        guard selectedImage != nil else {
            // Display an alert if no image is selected
            let alert = UIAlertController(title: "Error", message: "Please select an image first.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }

        // Perform classification on the selected image using your ML model
//        if let classificationResult = performClassification(image) {
//            classificationTextField.text = classificationResult
//        } else {
//            classificationTextField.text = "Classification failed"
//        }
    }

    //    // Classification
    //
    //    func performClassification(_ image: UIImage) -> String? {
    //        let model = EyeImageClassification() // Replace with the actual name of your eye model
    //
    //        guard let pixelBuffer = image.pixelBuffer(width: 224, height: 224) else {
    //            print("Failed to convert image to pixel buffer")
    //            return nil
    //        }
    //
    //        guard let output = try? model.prediction(image: pixelBuffer) else {
    //            print("Failed to perform classification")
    //            return nil
    //        }
    //
    //        let classificationResult = output.classLabel // Replace with the actual property name
    //
    //        return classificationResult
    //    }
    //}
}

extension ClassificationAnswerVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            self.selectedImage = selectedImage
        }

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}




//
//import UIKit
//import CoreML
//import Vision
//
//class EyeScanningViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    let imagePicker = UIImagePickerController()
//    var selectedImage: UIImage?
//
//    lazy var headerLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Please select which method using to scan your eye.\n"
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textColor = UIColor(red: 0.33, green: 0.71, blue: 0.71, alpha: 1.00)
//        label.numberOfLines = 0
//        return label
//    }()
//
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
//        collectionView.backgroundColor = .white
//        return collectionView
//    }()
//
//    let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = UIColor.black.cgColor
//        return imageView
//    }()
//
//    let classifyButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = UIColor(red: 0.325, green: 0.706, blue: 0.714, alpha: 1)
//        button.setTitle("Classify", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        button.layer.cornerRadius = 10
//        button.addTarget(self, action: #selector(classifyButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    let classificationTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.placeholder = "Classification Answer"
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let cellReuseIdentifier = "MyCell"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        if let modelURL = Bundle.main.url(forResource: "EyeClassifier", withExtension: "mlmodel") {
//            }
//
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        view.addSubview(headerLabel)
//        setupCollectionView()
//        setupImageView()
//        setupClassifyButton()
//        setupClassificationTextField()
//    }
//
//    func setupCollectionView() {
//        view.addSubview(collectionView)
//
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
//            collectionView.heightAnchor.constraint(equalToConstant: 150),
//            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
//        ])
//    }
//
//    func setupImageView() {
//        view.addSubview(imageView)
//
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
//            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 300),
//            imageView.heightAnchor.constraint(equalToConstant: 300)
//        ])
//    }
//
//    func setupClassifyButton() {
//        view.addSubview(classifyButton)
//
//        NSLayoutConstraint.activate([
//            classifyButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
//            classifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            classifyButton.widthAnchor.constraint(equalToConstant: 200),
//            classifyButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//
//    func setupClassificationTextField() {
//        view.addSubview(classificationTextField)
//
//        NSLayoutConstraint.activate([
//            classificationTextField.topAnchor.constraint(equalTo: classifyButton.bottomAnchor, constant: 16),
//            classificationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            classificationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            classificationTextField.heightAnchor.constraint(equalToConstant: 40)
//        ])
//    }
//
//    // MARK: - UICollectionViewDataSource
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! MyCollectionViewCell
//
//        if indexPath.item == 0 {
//            cell.imageView.image = UIImage(named: "camera_icon")
//            cell.label.text = "Camera"
//        } else {
//            cell.imageView.image = UIImage(named: "gallery_icon")
//            cell.label.text = "Gallery"
//        }
//
//        return cell
//    }
//
//    // MARK: - UICollectionViewDelegateFlowLayout
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 120)
//    }
//
//    // MARK: - UICollectionViewDelegate
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.item == 0 {
//            openCamera()
//        } else {
//            openGallery()
//        }
//    }
//
//    // MARK: - Image Picker Methods
//
//    func openCamera() {
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            imagePicker.sourceType = .camera
//            present(imagePicker, animated: true, completion: nil)
//        } else {
//            // Show an error message or fallback to another method
//        }
//    }
//
//    func openGallery() {
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            selectedImage = image
//            imageView.image = image
//        }
//
//        dismiss(animated: true, completion: nil)
//    }
//
//    // MARK: - Classification
//
//    @objc func classifyButtonTapped() {
//        guard let image = selectedImage else {
//            // Show an error message asking the user to select an image
//            return
//        }
//
//        // Perform classification using Core ML model
//
//        if let modelURL = Bundle.main.url(forResource: "EyeClassifier", withExtension: "mlmodel"),
//           let model = try? VNCoreMLModel(for: MLModel(contentsOf: modelURL)) {
//
//            let request = VNCoreMLRequest(model: model) { (request, error) in
//                if let classificationResult = request.results as? [VNClassificationObservation] {
//                    let topResult = classificationResult.first
//                    DispatchQueue.main.async {
//                        self.classificationTextField.text = topResult?.identifier
//                    }
//                }
//            }
//
//            if let ciImage = CIImage(image: image) {
//                let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage, orientation: CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))!)
//
//                do {
//                    try imageRequestHandler.perform([request])
//                } catch {
//                    print("Error: \(error)")
//                }
//            }
//        }
//    }
//}
//
