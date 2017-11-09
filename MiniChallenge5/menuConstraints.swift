//
//  testeViewController.swift
//  MiniChallenge5
//
//  Created by Vinícius Cano Santos on 09/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class menuConstraints: UIViewController {
    
    @IBOutlet weak var playButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var createCircuitButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var aboutButtonConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        playButtonConstraint.constant = self.view.frame.size.height * 0.397
        createCircuitButtonConstraint.constant = self.view.frame.size.height * 0.523
        aboutButtonConstraint.constant = self.view.frame.size.height * 0.650
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
