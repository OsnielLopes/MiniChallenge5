//
//  SignUpViewController.swift
//  MiniChallenge5
//
//  Created by Vinícius Cano Santos on 24/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Constraints
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextFieldLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTextFieldLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordTextFieldLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameTextFieldLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpButtonTopConstraint: NSLayoutConstraint!
    
    //MARK: Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: Properties
    private var playerDataManager: PlayerDataManager = PlayerDataManager()
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpBackGround()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.nameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Implementação de constraints
        titleLabelTopConstraint.constant = self.view.frame.size.height * 0.149
        
        emailTextFieldTopConstraint.constant = self.view.frame.size.height * 0.350
        emailTextFieldLeadingConstraint.constant = self.view.frame.size.width * 0.106
        emailTextField.setBottomBorder()
        emailTextField.attributedPlaceholder = NSAttributedString(string: " E-mail", attributes:[NSAttributedStringKey.foregroundColor : UIColor(red: 255.0/255.0, green: 255.0/255, blue: 255.0/255, alpha: 1)])
        
        passwordTextFieldTopConstraint.constant = self.view.frame.size.height * 0.428
        passwordTextFieldLeadingConstraint.constant = self.view.frame.size.width * 0.106
        passwordTextField.setBottomBorder()
        passwordTextField.attributedPlaceholder = NSAttributedString(string: " Password", attributes:[NSAttributedStringKey.foregroundColor : UIColor(red: 255.0/255.0, green: 255.0/255, blue: 255.0/255, alpha: 1)])
        
        confirmPasswordTextFieldTopConstraint.constant = self.view.frame.size.height * 0.506
        confirmPasswordTextFieldLeadingConstraint.constant = self.view.frame.size.width * 0.106
        confirmPasswordTextField.setBottomBorder()
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: " Confirm Password", attributes:[NSAttributedStringKey.foregroundColor : UIColor(red: 255.0/255.0, green: 255.0/255, blue: 255.0/255, alpha: 1)])
        
        usernameTextFieldTopConstraint.constant = self.view.frame.size.height * 0.584
        usernameTextFieldLeadingConstraint.constant = self.view.frame.size.width * 0.106
        nameTextField.setBottomBorder()
        nameTextField.attributedPlaceholder = NSAttributedString(string: " Username", attributes:[NSAttributedStringKey.foregroundColor : UIColor(red: 255.0/255.0, green: 255.0/255, blue: 255.0/255, alpha: 1)])
        
        signUpButtonTopConstraint.constant = self.view.frame.size.height * 0.650
    }
    
    //MARK: UITextFieldDelegate functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.signUpButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateButtonsState()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.emailTextField:
            self.emailTextField.resignFirstResponder()
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.passwordTextField.resignFirstResponder()
            self.confirmPasswordTextField.becomeFirstResponder()
        case self.confirmPasswordTextField:
            self.confirmPasswordTextField.resignFirstResponder()
            self.nameTextField.becomeFirstResponder()
        default:
            self.nameTextField.resignFirstResponder()
        }
        return true
    }
    
    //MARK: actions
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        let confirmPassword = self.confirmPasswordTextField.text!
        let username = self.nameTextField.text!
        
        if username.count < 5{
            self.showErrorMessage(errorMessage: "Your user name must have 5 characters minimum!", handler: {_ in
                self.nameTextField.becomeFirstResponder()
            })
            return
        }
        
        if !email.contains("@") {
            self.showErrorMessage(errorMessage: "Insert a valid e-mail address!", handler: {_ in self.emailTextField.becomeFirstResponder()
            })
            return
        }
        
        if password.count < 8{
            self.showErrorMessage(errorMessage: "Your password must have 8 characters minimum!", handler: {_ in
                self.passwordTextField.becomeFirstResponder()
            })
            return
        }
        
        if password != confirmPassword{
            self.showErrorMessage(errorMessage: "The fields \"Passwords\" and \"Confirm Password\" have different values!", handler: {_ in
                self.confirmPasswordTextField.becomeFirstResponder()
            })
            return
        }
        
//        playerDataManager.create(player: <#T##Player#>, callback: <#T##(Player) -> Void#>)
    }
    
    //MARK: Aux functions
    private func showErrorMessage(errorMessage: String, handler: @escaping (_ : UIAlertAction) -> Void){
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("OK", comment: "Dados errados"),
                style: .default,
                handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func updateButtonsState(){
        self.signUpButton.isEnabled = !(self.emailTextField.text ?? "").isEmpty
                                    && !(self.passwordTextField.text ?? "").isEmpty
                                    && !(self.confirmPasswordTextField.text ?? "").isEmpty
                                    && !(self.nameTextField.text ?? "").isEmpty
    }
    
    //MARK: Set up functions
    private func setUpBackGround(){
        //Put the image and the filter in the view background
        let backgroundImage = UIImageView(frame: self.view.frame)
        let filterImage = UIImageView(frame: self.view.frame)
        
        backgroundImage.image = UIImage(named: "background_image")
        filterImage.image = UIImage(named: "filter")
        
        self.view.insertSubview(filterImage, at: 0)
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    // MARK: - Navigation
    private func sendToMainMenu(){
        self.performSegue(withIdentifier: "MainMenu", sender: self)
    }

    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
