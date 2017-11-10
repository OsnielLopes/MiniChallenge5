//
//  SignInViewController.swift
//  MiniChallenge5
//
//  Created by Vinícius Cano Santos on 10/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    // Declaração de constraints
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var emailTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextFieldLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTextFieldLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var signInButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var signUpButtonTopConstraint: NSLayoutConstraint!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Implementação de constraints
        titleLabelTopConstraint.constant = self.view.frame.size.height * 0.149
        
        emailTextFieldTopConstraint.constant = self.view.frame.size.height * 0.350
        emailTextFieldLeadingConstraint.constant = self.view.frame.size.width * 0.106
        
        passwordTextFieldTopConstraint.constant = self.view.frame.size.height * 0.428
        passwordTextFieldLeadingConstraint.constant = self.view.frame.size.width * 0.106
        
        signInButtonTopConstraint.constant = self.view.frame.size.height * 0.523
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
