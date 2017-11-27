//
//  SignUpViewController.swift
//  MiniChallenge5
//
//  Created by Vinícius Cano Santos on 24/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //Declaração de constraints
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
    
    // Declaração de text field
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Coloca imagem e filtro no background da view
        let backgroundImage = UIImageView(frame: self.view.frame)
        let filterImage = UIImageView(frame: self.view.frame)
        
        backgroundImage.image = UIImage(named: "background_image")
        filterImage.image = UIImage(named: "filter")
        
        self.view.insertSubview(filterImage, at: 0)
        self.view.insertSubview(backgroundImage, at: 0)

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
        usernameTextField.setBottomBorder()
        usernameTextField.attributedPlaceholder = NSAttributedString(string: " Username", attributes:[NSAttributedStringKey.foregroundColor : UIColor(red: 255.0/255.0, green: 255.0/255, blue: 255.0/255, alpha: 1)])
        
        signUpButtonTopConstraint.constant = self.view.frame.size.height * 0.650
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
