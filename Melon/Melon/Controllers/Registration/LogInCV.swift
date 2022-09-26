//
//  LogInCV.swift
//  Melon
//
//  Created by Артем Пашевич on 25.09.22.
//

import UIKit

class LogInCV: UIViewController {

    @IBOutlet weak var errorEmailLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var logInTF: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInTF.isEnabled = false
        designViews()
    }
    
    
    private var isValidEmail = false { didSet {btnIsEnabled()}}
    private var isValidPassword = false {didSet {btnIsEnabled()}}
    
    
    @IBAction func checkEmail(_ sender: UITextField) {
        if let email = sender.text, !email.isEmpty {
            isValidEmail = true
            isEnabledViewBtn()
        } else {
            isValidEmail = false
            isEnabledViewBtn()
        }
        borderColorError(isValid: isValidEmail, textField: emailTF)
    }
    
    @IBAction func checkPassword(_ sender: UITextField) {
        if let password = sender.text, !password.isEmpty {
            isValidPassword = true
            isEnabledViewBtn()
        } else {
            isValidPassword = false
            isEnabledViewBtn()
        }
        errorEmailLbl.isHidden = isValidPassword
        borderColorError(isValid: isValidPassword, textField: passwordTF)
    }
  
    @IBAction func goToApp(_ sender: UIButton) {

    }
    
    private func btnIsEnabled() {
        logInTF.isEnabled = isValidEmail && isValidPassword 
    }
    
    private func designViews() {
        emailTF.layer.cornerRadius = 25
        passwordTF.layer.cornerRadius = 25
        logInTF.layer.cornerRadius = 25
    }
    
    private func isEnabledViewBtn() {
        if logInTF.isEnabled {
            logInTF.layer.cornerRadius = 25
            logInTF.layer.backgroundColor = #colorLiteral(red: 0.9953046441, green: 0.8822001815, blue: 0.04041770101, alpha: 1)
        } else {
            logInTF.layer.cornerRadius = 25
            logInTF.layer.backgroundColor = #colorLiteral(red: 0.9987029433, green: 0.9838122725, blue: 0.8668205142, alpha: 1)
        }
    }
    
    private func borderColorError(isValid: Bool, textField: UITextField) {
        if isValid {
            textField.layer.borderWidth = 0
        } else {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor(red: 0.913, green: 0.295, blue: 0.16, alpha: 1).cgColor
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
