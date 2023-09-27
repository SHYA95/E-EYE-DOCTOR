//
//  EyeCareViewController.swift
//  E-EYE DOCTOR
//
//  Created by Shrouk Yasser on 05/05/2023.
//
import UIKit
import UserNotifications

class EyeCareViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                print("Error requesting notification authorization: \(error)")
            } else if granted {
                print("Notification authorization granted.")
            } else {
                print("Notification authorization denied.")
            }
        }
    }

    @IBAction func morningReminderTapped(_ sender: UIButton) {
        scheduleLocalNotification(title: "Take Sunglasses", body: "If it's above 37°C, remind me to take my sunglasses.", hour: 0, minute: 1)
    }
    
    @IBAction func nightReminderTapped(_ sender: UIButton) {
        scheduleLocalNotification(title: "Take Eye Drops", body: "If it's below 12°C, remind me to take my eye drop.", hour: 21, minute: 0)
    }
    
    @IBAction func closePhoneReminderTapped(_ sender: UIButton) {
        scheduleLocalNotification(title: "Take a Rest", body: "Remind me to close my phone for 3 minutes every 45 minutes.", interval: 45 * 60)
        
        // Trigger the notification immediately
        triggerImmediateNotification()
    }
    
    func scheduleLocalNotification(title: String, body: String, hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling local notification: \(error)")
            } else {
                print("Local notification scheduled successfully.")
                DispatchQueue.main.async {
                    self.showAlert(message: "Your reminder is set.")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.showAlert(message: "This is a test alert after 2 seconds.")
                }
            }
        }
    }

    func scheduleLocalNotification(title: String, body: String, interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling local notification: \(error)")
            } else {
                print("Local notification scheduled successfully.")
                DispatchQueue.main.async {
                    self.showAlert(message: "Your reminder is set.")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.showAlert(message: "This is a test alert after 2 seconds.")
                }
            }
        }
    }
    
    func triggerImmediateNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Take a Rest"
        content.body = "It's time to close your phone for 3 minutes."
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error triggering immediate notification: \(error)")
            } else {
                print("Immediate notification triggered successfully.")
            }
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Reminder", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
