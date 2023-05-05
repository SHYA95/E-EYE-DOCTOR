//
//  TestCollectionViewCell.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 05/05/2023.
//
//
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    let testImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(testImageView)
        // Add constraints to position the image view within the cell
        testImageView.translatesAutoresizingMaskIntoConstraints = false
        testImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        testImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        testImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        testImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

