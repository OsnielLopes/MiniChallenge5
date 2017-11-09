//
//  createCircuit.swift
//  MiniChallenge5
//
//  Created by Vinícius Cano Santos on 09/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class createCircuitViewController: UIViewController {
    
    // Declaração das constraints
    
    @IBOutlet weak var labelConstraints: NSLayoutConstraint!
    @IBOutlet weak var labelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelTrailingConstraint: NSLayoutConstraint!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        labelConstraints.constant = self.view.frame.size.height * 0.149
        labelLeadingConstraint.constant = self.view.frame.size.width * 0.106
        labelTrailingConstraint.constant = self.view.frame.size.width * 0.106
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
