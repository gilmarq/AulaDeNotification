//
//  AppDelegate.swift
//  Notificacaoes
//
//  Created by Usuário Convidado on 18/03/19.
//  Copyright © 2019 FIAP. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let center = UNUserNotificationCenter.current()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         center.delegate = self
        
        center.getNotificationSettings { (settings) in
            switch settings.authorizationStatus{
               case .authorized:
                print("autorizou")

               case .notDetermined:
                let options: UNAuthorizationOptions = [.alert,.sound,.carPlay,.badge]
                self.center.requestAuthorization(options: options, completionHandler: { (authorized, error) in
                    if error != nil {
                        print("Deu merda", error!)
                    }else {
                        print("Autorizado?", authorized)
                    }
                })
              case .denied:
               print("Negado")
            case .provisional:
                print("ver depois !!! é muito novo e top Eric nunca usou!")
            }
        }
        let confirmAction = UNNotificationAction(identifier: "Confirm", title: "J;a estudei 👍🏾", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "Cancel", title: "Cancelar 👎🏾", options: [])
        let category = UNNotificationCategory(identifier: "Lembrete", actions: [confirmAction , cancelAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: [.customDismissAction])
        
        center.setNotificationCategories([category])
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate :UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge,.alert,.sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
        let id = response.notification.request.identifier
        print("ID",id)
        switch response.actionIdentifier {
        case "Confirm":
            print("Usuário tocou no botão de confirmação")
        case "Cancel":
            print("Usuário tocou no botão de cancelar")
        case UNNotificationDefaultActionIdentifier:
            print("Usuário tocou notificação")
        case UNNotificationDismissActionIdentifier:
            print("Usuári dismissou a noticação ")
        default:
            print("Qq outra coisa")
        }
        completionHandler()
    }
}

