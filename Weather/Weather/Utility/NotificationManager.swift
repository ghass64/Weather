//
//  NotificationManager.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 24/05/2022.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject {
    static let shared = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()

    private override init() {}

    func userRequest() {
           
           let options: UNAuthorizationOptions = [.alert, .sound, .badge]
       
           notificationCenter.requestAuthorization(options: options) {
               (didAllow, error) in
               if !didAllow {
                   print("User has declined notifications")
               }
           }
       }
    
    func scheduleNotification() {
            
            let content = UNMutableNotificationContent()
            let userActions = "com.hawish.weather.localNotificationCategory"
            
            content.title = "Weather"
            content.body = "We hope you enjoyed our app!"
            content.sound = UNNotificationSound.default
            content.badge = 1
            content.categoryIdentifier = userActions
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: Constants.NotificationIdentifier, content: content, trigger: trigger)
            
            notificationCenter.add(request) { (error) in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                }
            }
            
            let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
            let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
            let category = UNNotificationCategory(identifier: userActions,
                                                  actions: [snoozeAction, deleteAction],
                                                  intentIdentifiers: [],
                                                  options: [])
            
            notificationCenter.setNotificationCategories([category])
        }
    
    func clearAllRequestNotifications() {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [Constants.NotificationIdentifier])
    }
    
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == Constants.NotificationIdentifier {
                   print("Handling notifications with the Local Notification Identifier")
               }
               
               switch response.actionIdentifier {
               case UNNotificationDismissActionIdentifier:
                   print("Dismiss Action")
               case UNNotificationDefaultActionIdentifier:
                   print("Default")
               case "Snooze":
                   print("Snooze")
                   scheduleNotification()
               case "Delete":
                   print("Delete")
               default:
                   print("Unknown action")
               }
               completionHandler()
    }
}
