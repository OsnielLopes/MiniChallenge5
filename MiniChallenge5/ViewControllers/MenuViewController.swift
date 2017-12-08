//
//  testeViewController.swift
//  MiniChallenge5
//
//  Created by Vinícius Cano Santos on 09/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    //Declaração da constraint da imagem do círculo
    @IBOutlet weak var circleImageTopConstraint: NSLayoutConstraint!
    
    // Declaração das contraints dos botões
    @IBOutlet weak var playButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var locationsMapButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var aboutButtonConstraint: NSLayoutConstraint!
    
    // Audio
    var Sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("C", ofType: "m4a"))
    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataManagerTest: DataManagerTest = DataManagerTest()
//        dataManagerTest.testFactionDataManager()
//        dataManagerTest.testPlayerDataManager()
//        dataManagerTest.testCircuitDataManager()
//        dataManagerTest.testPlayDataManager()
        
        //Coloca imagem e filtro no background da view
        let backgroundImage = UIImageView(frame: self.view.frame)
        let filterImage = UIImageView(frame: self.view.frame)
        
        backgroundImage.image = UIImage(named: "background_image")
        filterImage.image = UIImage(named: "filter")
        
        self.view.insertSubview(filterImage, at: 0)
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        
        // Deixa a navigation bar transparente
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // Deixa a navigation bar sem sombra
            navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = nil
        
        // Constraints
        circleImageTopConstraint.constant = self.view.frame.size.height * 0.149
        
        playButtonConstraint.constant = self.view.frame.size.height * 0.523
        locationsMapButtonConstraint.constant = self.view.frame.size.height * 0.652
        aboutButtonConstraint.constant = self.view.frame.size.height * 0.779
    }
    
    @IBAction func playButton(_ sender: Any) {
        let CatSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: CatSound)
            audioPlayer.prepareToPlay()
        } catch {
            print("Audio problem!")
        }
        audioPlayer.play()
    }
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
