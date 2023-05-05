


import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    let imageView = UIImageView()
    let tableView = UITableView()



    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()

    let images = ["eye-test (1)", "youre-eye", "sight-measure", "care", "mediacal-record 1", "image6"]
    let buttonTitles = ["Eye Testing", "Your E-Eye", "Optometry", "Eye Care", "Eye Record", "Button 6"]


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = UIColor.systemBackground

        // Set up image view
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.5)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "eye")
        imageView.clipsToBounds = true
        view.addSubview(imageView)

        // creating the scan button
        let scanButton = UIButton()
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        scanButton.backgroundColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1)
        scanButton.setTitle("Scan Your Eye", for: .normal)
        scanButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        scanButton.layer.cornerRadius = 15
        view.addSubview(scanButton)

        let scanGesture = UITapGestureRecognizer(target: self, action: #selector(scanButtonTapped))
        scanButton.addGestureRecognizer(scanGesture)

        NSLayoutConstraint.activate([
            scanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            scanButton.widthAnchor.constraint(equalToConstant: 200),
            scanButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // create the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    @objc func scanButtonTapped() {
        print("it works")
        let eyeScanningVC = EyeScanningViewController()
        navigationController?.pushViewController(eyeScanningVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.imageView.image = UIImage(named: images[indexPath.row])
        cell.button.setTitle(buttonTitles[indexPath.row], for: .normal)
        cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cell.button.tag = indexPath.row // add tag to the button to identify which button is tapped
        cell.button.titleLabel?.font = UIFont(name: "comic sans ms", size:12)
        return cell
    }

    @objc func buttonTapped(_ sender: UIButton) {
        switch sender.tag {

        case 0:
            print ("done")
            let eyeTestingVC = OptometryViewController()
            navigationController?.pushViewController(eyeTestingVC, animated: true)
        case 1:
            print ("done1")
            let eEyeVC = OptometryViewController()
            navigationController?.pushViewController(eEyeVC, animated: true)
        case 2:
            print ("done2")
            let optometryVC = OptometryViewController()
            navigationController?.pushViewController(optometryVC, animated: true)
        case 3:
            print ("done3")
            let eyeCareVC = EyeCareViewController()
            navigationController?.pushViewController(eyeCareVC, animated: true)
        case 4:
            print ("done4")
            let eyeRecordVC = EyeRecordViewController()
            navigationController?.pushViewController(eyeRecordVC, animated: true)
        case 5:
            print ("done5")
            let button6VC = OptometryViewController()
            navigationController?.pushViewController(button6VC, animated: true)
        default:
            break
        }
    }

    //MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }


    

    //MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 48) / 3
        let cellHeight = cellWidth * 1.4
        return CGSize(width: cellWidth, height: cellHeight)
    }
    // button function
    func buttonTapped() {
        let newVC = EyeScanningViewController()
        self.navigationController?.pushViewController(newVC, animated: true)

    }

}

class CustomCollectionViewCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()



    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.325, green: 0.706, blue: 0.714, alpha: 1) // set button color to #53B4B6
        button.setTitleColor(.white, for: .normal)
        //        button.titleLabel?.font = UIFont(name: "comic sans ms", size:10) // set font to Comic Sans MS with size 14
        button.layer.cornerRadius = 10
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        contentView.addSubview(button)

        // Add green border with corner radius to cell
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1).cgColor
        contentView.layer.cornerRadius = 10




        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.5),

            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
























//import UIKit
//
//class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    let imageView = UIImageView()
//    let tableView = UITableView()
//
//    let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 16
//        layout.minimumLineSpacing = 16
//        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.backgroundColor = .white
//        return collectionView
//    }()
//
//    let images = ["eye-test (1)", "youre-eye", "sight-measure", "care", "mediacal-record 1", "image6"]
//    let buttonTitles = ["Eye Testing", "Your E-Eye", "Optometry", "Eye Care", "Eye Record", "Button 6"]
//    let viewControllers: [UIViewController.Type] = [
//        EyeScanningViewController.self,
//        YourEEyeViewController.self,
//        OptometryViewController.self,
//        EyeCareViewController.self,
//        EyeRecordViewController.self,
//        UIViewController.self // Placeholder view controller for the last cell
//    ]
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//            view.backgroundColor = .systemBackground
//            collectionView.backgroundColor = UIColor.systemBackground
//
//            // Set up image view
//            imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.5)
//            imageView.contentMode = .scaleAspectFill
//            imageView.image = UIImage(named: "eye")
//            imageView.clipsToBounds = true
//            view.addSubview(imageView)
//
//            // creating the scan button
//            let Scanbutton = UIButton()
//            Scanbutton.translatesAutoresizingMaskIntoConstraints = false
//            Scanbutton.backgroundColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1)
//            Scanbutton.setTitle("Scan Your Eye", for: .normal)
//            Scanbutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//            Scanbutton.layer.cornerRadius = 15
//            view.addSubview(Scanbutton)
//
//
//            NSLayoutConstraint.activate([
//                Scanbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                Scanbutton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
//                Scanbutton.widthAnchor.constraint(equalToConstant: 200),
//                Scanbutton.heightAnchor.constraint(equalToConstant: 50)
//            ])
//
//
//
//
//
//
//            // create the collection view
//            collectionView.dataSource = self
//            collectionView.delegate = self
//            collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//
//            view.addSubview(collectionView)
//
//            NSLayoutConstraint.activate([
//                collectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
//                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//                collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
//            ])
//
//        }
//    //
//    // MARK: - UICollectionViewDataSource
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return images.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
//        cell.imageView.image = UIImage(named: images[indexPath.row])
//        cell.button.setTitle(buttonTitles[indexPath.row], for: .normal)
//        cell.button.addTarget(self, action: #selector(cellButtonTapped(_:)), for: .touchUpInside)
//        return cell
//        }
//
//
//    // MARK: - UICollectionViewDelegateFlowLayout
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.bounds.width - 48) / 2
//        let height = width * 1.5
//        return CGSize(width: width, height: height)
//    }
//
//    // MARK: - Actions
//
//    @objc func scanButtonTapped() {
//        // Handle scan button tap
//    }
//
//    @objc func cellButtonTapped(_ sender: UIButton) {
//        let index = sender.tag
//        let vc = viewControllers[index].init()
//        vc.title = buttonTitles[index]
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//class CustomCollectionViewCell: UICollectionViewCell {
//    let imageView = UIImageView()
//    let button = UIButton()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.backgroundColor = .white
//        contentView.layer.cornerRadius = 8
//        contentView.clipsToBounds = true
//
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFill
//        contentView.addSubview(imageView)
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = UIColor(red: 83/255, green: 180/255, blue: 182/255, alpha: 1)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 15
//        contentView.addSubview(button)
//
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: button.topAnchor),
//
//            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
//            button.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
