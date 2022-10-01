//
//  LogInCV.swift
//  Melon
//
//  Created by Артем Пашевич on 25.09.22.
//

import UIKit
import Firebase

class LogInCV: UIViewController {

    @IBOutlet var errorEmailLbl: UILabel!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var logInTF: UIButton!
    
    var iconClick = false
    let imageIcon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTextField()
        logInTF.isEnabled = false
        designViews()
        showPassword(textField: passwordTF)
    }
    
    private var isValidEmail = false { didSet { btnIsEnabled() }}
    private var isValidPassword = false { didSet { btnIsEnabled() }}
    
    @IBAction func checkEmail(_ sender: UITextField) {
        if let email = sender.text, !email.isEmpty {
            isValidEmail = true
            isEnabledViewBtn()
        } else {
            isValidEmail = false
            isEnabledViewBtn()
        }
        Design.borderColorError(isValid: isValidEmail, textField: emailTF)
    }
    
    @IBAction func checkPassword(_ sender: UITextField) {
        if let password = sender.text, !password.isEmpty {
            isValidPassword = true
            isEnabledViewBtn()
        } else {
            isValidPassword = false
            isEnabledViewBtn()
        }
        
        Design.borderColorError(isValid: isValidPassword, textField: passwordTF)
    }
  
    @IBAction func goToApp(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) {_, error in
            if error == nil {
                self.presentHome()
            } else {
                Design.showError(errorLbl: self.errorEmailLbl)
                self.passwordTF.text = ""
                self.emailTF.text = ""
            }
        }
    }
    
    private func btnIsEnabled() {
        logInTF.isEnabled = isValidEmail && isValidPassword
    }
    
    private func designViews() {
        emailTF.layer.borderWidth = 0
        emailTF.layer.cornerRadius = 25
        passwordTF.layer.cornerRadius = 25
        logInTF.layer.cornerRadius = 25
    }
    
    private func isEnabledViewBtn() {
        if logInTF.isEnabled {
            logInTF.layer.cornerRadius = 25
            logInTF.layer.backgroundColor = #colorLiteral(red: 0.9953046441, green: 0.8822001815, blue: 0.04041770101, alpha: 1)
        } else {
            logInTF.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            logInTF.layer.cornerRadius = 25
            logInTF.layer.backgroundColor = #colorLiteral(red: 0.9987029433, green: 0.9838122725, blue: 0.8668205142, alpha: 1)
        }
    }
    
    private func presentHome() {
//        performSegue(withIdentifier: "goToMainFromLogIn", sender: nil)
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "testVC") as! testVC
      //  self.present(newViewController, animated: true, completion: nil)
        performSegue(withIdentifier: "goToMain", sender: nil)
    }
    
    private func delegateTextField () {
        passwordTF.delegate = self
        emailTF.delegate = self
    }
    
    func showPassword(textField: UITextField) {
        imageIcon.image = UIImage(named: "closeEye")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "closeEye")!.size.width, height: UIImage(named: "closeEye")!.size.height)
        
        imageIcon.frame = CGRect(x: -10, y: 0, width: UIImage(named: "closeEye")!.size.width, height: UIImage(named: "closeEye")!.size.height)
        
        textField.rightView = contentView
        textField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if iconClick {
            iconClick = false
            tappedImage.image = UIImage(named: "openEye")
            passwordTF.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage.image = UIImage(named: "closeEye")
            passwordTF.isSecureTextEntry = true
        }
    }

}

extension LogInCV: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
