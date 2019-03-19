//
//  SettingsViewController.swift
//  Notificacaoes
//
//  Created by Usuário Convidado on 18/03/19.
//  Copyright © 2019 FIAP. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var swSounds: UISwitch!
    @IBOutlet weak var sqColors: UISegmentedControl!
    @IBOutlet weak var tfName: UITextField!
    
    var ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfName.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        swSounds.isOn = ud.bool(forKey: "sounds")
        sqColors.selectedSegmentIndex = ud.integer(forKey: "color")
        tfName.text = ud.string(forKey: "name")
      
    }
    
    @IBAction func changesSound(_ sender: UISwitch) {
        ud.set(sender.isOn, forKey:"sounds")
        ud.synchronize()
    }
    @IBAction func changeColor(_ sender: UISegmentedControl) {
        ud.set(sender.selectedSegmentIndex, forKey:"color")
    }
}
extension SettingsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ud.set(textField.text!, forKey: "name")
        view.endEditing(true)
        return true
    }
}
