//
//  ViewController.swift
//  Notificacaoes
//
//  Created by Usuário Convidado on 18/03/19.
//  Copyright © 2019 FIAP. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var tfCourse: UITextField!
    @IBOutlet weak var tfSubject: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func scheduleNotification(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Curso: \(tfCourse.text!)"
        content.body = "Está na hora de estudar \(tfSubject.text!)"
        content.badge = 1
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "Lembrete"
        
        let date = dpDate.date
        let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: date)
        
        let trigger =  UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats:false)
       // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: "Lembrete", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print("Erro na notificação:", error)
            }
            
        }
        
        
        
        
        
    }
    
}

