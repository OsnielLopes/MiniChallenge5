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
    
    @IBOutlet weak var image2TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var image2LeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var image3TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var image3LeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel1TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel1LeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel2TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel2LeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel3TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel3LeadingConstraint: NSLayoutConstraint!
    
    
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
        // Implementação das constraints
        titleLabelConstraint.constant = self.view.frame.size.height * 0.119

        image1TopConstraint.constant = self.view.frame.size.height * 0.194
        image1LeadingConstraint.constant = self.view.frame.size.width * 0.106

        image2TopConstraint.constant = self.view.frame.size.height * 0.354
        image2LeadingConstraint.constant = self.view.frame.size.width * 0.106
        
        image3TopConstraint.constant = self.view.frame.size.height * 0.514
        image3LeadingConstraint.constant = self.view.frame.size.width * 0.106
        
        nameLabel1TopConstraint.constant = self.view.frame.size.height * 0.243
        nameLabel1LeadingConstraint.constant = self.view.frame.size.width * 0.050
        
        nameLabel2TopConstraint.constant = self.view.frame.size.height * 0.403
        nameLabel2LeadingConstraint.constant = self.view.frame.size.width * 0.050
        
        nameLabel3TopConstraint.constant = self.view.frame.size.height * 0.563
        nameLabel3LeadingConstraint.constant = self.view.frame.size.width * 0.050
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
