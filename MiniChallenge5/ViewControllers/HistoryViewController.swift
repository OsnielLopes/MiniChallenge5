//
//  HistoryViewController.swift
//  
//
//  Created by Vinícius Cano Santos on 08/12/17.
//

import UIKit

class HistoryViewController: UIViewController {
    
    //MARK: Constraints
    @IBOutlet weak var historyLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var historyLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var historyLabelTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var signUpButtonTopConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Coloca imagem e filtro no background da view
        let backgroundImage = UIImageView(frame: self.view.frame)
        let filterImage = UIImageView(frame: self.view.frame)
        
        backgroundImage.image = UIImage(named: "background_image")
        filterImage.image = UIImage(named: "filter")
        
        self.view.insertSubview(filterImage, at: 0)
        self.view.insertSubview(backgroundImage, at: 0)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Definição das constraints
        historyLabelTopConstraint.constant = self.view.frame.size.height * 0.300
        historyLabelLeadingConstraint.constant = self.view.frame.size.width * 0.106
        historyLabelTrailingConstraint.constant = self.view.frame.size.width * 0.106
        
        signUpButtonTopConstraint.constant = self.view.frame.size.height * 0.760
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
