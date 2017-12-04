//
//  SignInViewController.swift
//  MiniChallenge5
//
//  Created by Vinícius Cano Santos on 10/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Constraints
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextFieldLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTextFieldLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var signInButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpButtonTopConstraint: NSLayoutConstraint!
    
    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    //MARK: Properties
    private var playerDataManager: PlayerDataManager = PlayerDataManager()
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpBackGround()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.updateButtonsState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Implementação de constraints
        titleLabelTopConstraint.constant = self.view.frame.size.height * 0.149
        
        emailTextFieldTopConstraint.constant = self.view.frame.size.height * 0.350
        emailTextFieldLeadingConstraint.constant = self.view.frame.size.width * 0.106
        emailTextField.setBottomBorder()
        emailTextField.attributedPlaceholder = NSAttributedString(string: " E-mail", attributes:[NSAttributedStringKey.foregroundColor : UIColor(red: 255.0/255.0, green: 255.0/255, blue: 255.0/255, alpha: 1)])
        
//        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
//        let emailBorder = CALayer()
//        let width = CGFloat(2.0)
//        emailBorder.borderColor = UIColor.black.cgColor
//        emailBorder.frame = CGRect(x: 0, y: emailTextField.frame.size.height, width: emailTextField.frame.size.width, height: emailTextField.frame.size.height)
//        emailBorder.borderWidth = width
//        emailTextField.layer.addSublayer(emailBorder)
//        emailTextField.layer.masksToBounds = true
        
        
        passwordTextFieldTopConstraint.constant = self.view.frame.size.height * 0.428
        passwordTextFieldLeadingConstraint.constant = self.view.frame.size.width * 0.106
        passwordTextField.setBottomBorder()
        passwordTextField.attributedPlaceholder = NSAttributedString(string: " Password", attributes:[NSAttributedStringKey.foregroundColor : UIColor(red: 255.0/255.0, green: 255.0/255, blue: 255.0/255, alpha: 1)])
        
        signInButtonTopConstraint.constant = self.view.frame.size.height * 0.523
        signUpButtonTopConstraint.constant = self.view.frame.size.height * 0.650
        
    }
    
    //MARK: UITextFieldDelegate functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.signInButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateButtonsState()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField{
            self.emailTextField.resignFirstResponder()
            self.passwordTextField.becomeFirstResponder()
        }else{
            self.passwordTextField.resignFirstResponder()
        }
        return true
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
        
        //Hiding the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //MARK: Actions
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        sender.isEnabled = false;
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        
        self.playerDataManager.readByEmail(email: email, callback: {
            if let player = $0{
                if player.password == password {
                    print("***Deu certo!***")
                    self.sendToMainMenu()
                }else{
                    self.showErrorMessage(errorMessage: "Wrong password!", handler: {_ in self.passwordTextField.becomeFirstResponder()
                    })
                }
            }else{
                self.showErrorMessage(errorMessage: "Wrong e-mail!", handler: {_ in self.emailTextField.becomeFirstResponder()
                    
                })
            }
        })
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
        self.signInButton.isEnabled = !(self.emailTextField.text ?? "").isEmpty && !(self.passwordTextField.text ?? "").isEmpty
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
