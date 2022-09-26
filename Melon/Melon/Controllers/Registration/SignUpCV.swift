//
//  SignUpCV.swift
//  Melon
//
//  Created by Артем Пашевич on 25.09.22.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        designViews()
        registerLbl.isEnabled = false
    }
    
    @IBAction func checkEmail(_ sender: UITextField) {
        if let email = sender.text, Validation.isValidEmail(email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        errorEmail.isHidden = isValidEmail
    }
    
    @IBAction func checkPhone(_ sender: UITextField) {
        if let phone = sender.text, Validation.validatePhone(value: phone) {
            isValidPhone = true
        } else {
            isValidPhone = false
        }
        errorPhone.isHidden = isValidPhone
    }
    
    @IBAction func checkPassword(_ sender: UITextField) {
        if let password = sender.text, Validation.isPasswordValid(password) {
            isValidPassword = true
        } else {
            isValidPassword = false
        }
        errorPassword.isHidden = isValidPassword
    }
    
    
    @IBAction func goToApp() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "MainFeedCVC") as! MainFeedCVC
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true, completion: nil)
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

}
