//
//  SignUpCV.swift
//  Melon
//
//  Created by Артем Пашевич on 25.09.22.
//

import UIKit
import Firebase

class SignUpCV: UIViewController {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var registerLbl: UIButton!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPhone: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    
    private var isValidEmail = false { didSet {btnIsEnabled()}}
    private var isValidPassword = false {didSet {btnIsEnabled()}}
    private var isValidPhone = false {didSet {btnIsEnabled()}}
    var iconClick = false
    let imageIcon = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTextField()
        designViews()
        showPassword(textField: passwordTF)
        registerLbl.isEnabled = false
    }
    
    @IBAction func checkEmail(_ sender: UITextField) {
        if let email = sender.text, Validation.isValidEmail(email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        errorEmail.isHidden = isValidEmail
        Design.borderColorError(isValid: isValidEmail, textField: emailTF)
    }
    
    @IBAction func checkPhone(_ sender: UITextField) {
        if let phone = sender.text, Validation.validatePhone(value: phone) {
            isValidPhone = true
        } else {
            isValidPhone = false
        }
        Design.addTire(textField: phoneTF)
        errorPhone.isHidden = isValidPhone
        Design.borderColorError(isValid: isValidPhone, textField: phoneTF)
    }
    
    @IBAction func checkPassword(_ sender: UITextField) {
        if let password = sender.text, Validation.isPasswordValid(password) {
            isValidPassword = true
        } else {
            isValidPassword = false
        }
        errorPassword.isHidden = isValidPassword
        Design.borderColorError(isValid: isValidPassword, textField: passwordTF)
    }
    
    
    @IBAction func goToApp() {
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { result, error in
            if error == nil {
                if let result = result {
                    let ref = Database.database().reference().child("Users")
                    ref.child(result.user.uid).updateChildValues(["Phone": self.phoneTF.text!, "Email": self.emailTF.text!])
                    self.presentHome()
                } else {
                    Design.showError(errorLbl: self.errorPassword)
                    self.passwordTF.text = ""
                    self.emailTF.text = ""
                    self.phoneTF.text = ""
                }
            }
        }
    }
    
    private func presentHome() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "testVC") as! testVC
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func btnIsEnabled() {
        registerLbl.isEnabled = isValidEmail && isValidPassword && isValidPhone
    }
    
    private func designViews() {
        emailTF.layer.cornerRadius = 25
        passwordTF.layer.cornerRadius = 25
        phoneTF.layer.cornerRadius = 25
        registerLbl.layer.cornerRadius = 25
    }
    
    private func delegateTextField () {
        passwordTF.delegate = self
        emailTF.delegate = self
        phoneTF.delegate = self
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

extension SignUpCV: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
