//
//  EyeTestingHomeVC.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 01/07/2023.
//

import UIKit
//import ColorTestVC
//import VisionTestVC

class  EyeTestingHomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let cellReuseIdentifier = "MyCell"
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please select the test you want to take !"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 0.33, green: 0.71, blue: 0.71, alpha: 1.00)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
        // Add header label to view hierarchy
        view.addSubview(headerLabel)
        
        // Set header label constraints
        headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 34).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Create a circular button with diameter of 45
        let instbutton = UIButton(type: .system)
        instbutton.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        instbutton.layer.cornerRadius = 22.5 // half the width of the button to make it circular
        instbutton.backgroundColor = UIColor(red: 0.325, green: 0.706, blue: 0.714, alpha: 1)
        instbutton.tintColor = .white
        instbutton.setImage(UIImage(systemName: "exclamationmark"), for: .normal)
//        instbutton.addTarget(self, action: #selector(handlebuttonTapped), for: .touchUpInside)
        
        let backButton3 = UIBarButtonItem(title: "Scan", style: .plain, target: nil, action: nil)
        backButton3.tintColor = UIColor(red: 0.325, green: 0.706, blue: 0.714, alpha: 1)
        
        navigationItem.backBarButtonItem = backButton3
        
        // Add the button to the view
        view.addSubview(instbutton)
        instbutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instbutton.widthAnchor.constraint(equalToConstant: 45),
            instbutton.heightAnchor.constraint(equalToConstant: 45),
            instbutton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            instbutton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
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
            cell.imageView.image = UIImage(named: "10111494")
            cell.Photobutton.setTitle("Color vision", for: .normal)
        } else {
            cell.imageView.image = UIImage(named: "4")
            cell.Photobutton.setTitle("Symbol C", for: .normal)
        }
        cell.Photobutton.addTarget(self, action: #selector(handlePhotoButtonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 48) / 2 // Subtract 16px from leading and trailing edges and 16px spacing between cells
        let height: CGFloat = 250 // Set the cell height to 300
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: - Actions
    
    @objc func handlePhotoButtonTapped(sender: UIButton) {
        if let indexPath = self.collectionView.indexPath(for: sender.superview?.superview as! MyCollectionViewCell ) {
                if indexPath.row == 0 {
                    let newViewController = ColorTestVC()
                    navigationController?.pushViewController(newViewController, animated: true)
                } else {
                    let newViewController = VisionTestVC()
                    navigationController?.pushViewController(newViewController, animated: true)
                }
            }
        }

    // MARK: - Actions
    
    
}

class MyCollectionViewCell2: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    
    
    let Photobutton: UIButton = {
        let Photobutton = UIButton()
        Photobutton.translatesAutoresizingMaskIntoConstraints = false
        Photobutton.backgroundColor = UIColor(red: 0.325, green: 0.706, blue: 0.714, alpha: 1) // set button color to #53B4B6
        Photobutton.setTitleColor(.white, for: .normal)
        Photobutton.titleLabel?.font = UIFont(name: "comic sans ms", size:12) // set font to Comic Sans MS with size 14
        Photobutton.layer.cornerRadius = 10
        return Photobutton
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(Photobutton)
        
        // Add green border with corner radius to cell
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
        contentView.layer.cornerRadius = 10
        
        
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.8),
            
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
