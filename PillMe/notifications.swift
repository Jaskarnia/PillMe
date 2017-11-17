//
//  notifications.swift
//  PillMe
//
//  Created by Jaskarn Bains on 11/17/17.
//  Copyright © 2017 Andy Yang. All rights reserved.
//

import UserNotifications
class MYNotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
}
