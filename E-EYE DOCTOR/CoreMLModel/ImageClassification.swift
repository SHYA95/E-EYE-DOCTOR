//
//  ImageClassification.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 01/07/2023.
//
//import CoreML
//import UIKit
//import Vision
//
//class ImageClassificationModel {
//    private let model: VNCoreMLModel
//
//    init() {
//        guard let modelURL = Bundle.main.url(forResource: "EyeImageClassification", withExtension: "mlmodel") else {
//            fatalError("Failed to find the Core ML model.")
//        }
//
//        do {
//            let model = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
//            self.model = model
//        } catch {
//            fatalError("Failed to create the Core ML model: \(error.localizedDescription)")
//        }
//    }
//
//    func classifyImage(_ image: UIImage) -> String? {
//        guard let ciImage = CIImage(image: image) else {
//            fatalError("Failed to create CIImage from UIImage.")
//        }
//
//        let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage)
//
//        do {
//            let classificationRequest = VNCoreMLRequest(model: model) { request, error in
//                if let error = error {
//                    print("Classification error: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let classifications = request.results as? [VNClassificationObservation],
//                      let topClassification = classifications.first else {
//                    print("No classifications found.")
//                    return
//                }
//
//                let classificationIdentifier = topClassification.identifier
//                let classificationConfidence = topClassification.confidence
//                let classificationResult = "\(classificationIdentifier) - Confidence: \(classificationConfidence)"
//                print("Classification result: \(classificationResult)")
//
//                // You can update the UI here with the classification result
//            }
//
//            try imageRequestHandler.perform([classificationRequest])
//        } catch {
//            print("Failed to perform classification request: \(error.localizedDescription)")
//        }
//
//        return nil
//    }
//}
