//
//  MenuVC.swift
//  MyWalletIos
//
//  Created by apple on 07/04/2023.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let cellTitles = ["My Medical Records", "Support", "Privacy,Secuirty", "About", "Log out"]

    let cellImages = [ "doc.on.clipboard.fill", "phone.circle", "lock.shield.fill", "info.circle","rectangle.portrait.and.arrow.right"]
    

    @IBOutlet weak var MenuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuTableView.delegate = self
        MenuTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        cell.menuLabel.text = cellTitles[indexPath.row]
        cell.menuIcon.image = UIImage(systemName: cellImages[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // Navigate to My Medical Records view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MedicalRecordVC")
          //  navigationController.ishi
            present(vc, animated: true)
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            // Navigate to Support view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SupportViewController")
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            // Navigate to Privacy and Security view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PrivacySecurityVC")
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            // Navigate to About view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AboutVC")
            navigationController?.pushViewController(vc, animated: true)
        default:
            showAlert()
       
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            // Perform log out here
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.removeObject(forKey: "accessToken")
            UserDefaults.standard.removeObject(forKey: "phone")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    }
