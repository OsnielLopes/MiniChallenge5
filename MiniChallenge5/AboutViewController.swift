//
//  AboutViewController.swift
//  MiniChallenge5
//
//  Created by Vinícius Cano Santos on 09/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    // Declaração das constraints
    @IBOutlet weak var titleLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var image1TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var image1LeadingConstraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        // Implementação das constraints
        titleLabelConstraint.constant = self.view.frame.size.height * 0.119

        image1TopConstraint.constant = self.view.frame.size.height * 0.194
        image1LeadingConstraint.constant = self.view.frame.size.width * 0.106


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
