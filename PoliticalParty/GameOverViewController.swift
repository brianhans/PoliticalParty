//
//  GameOverViewController.swift
//  PoliticalParty
//
//  Created by Brian Hans on 10/18/16.
//  Copyright © 2016 Brian Hans. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController{

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var game: Game!
    
    override func viewDidLoad() {
        let currentScore = game.correct.count * 10
        var highScore: Int = UserDefaults.standard.integer(forKey: Constants.highScore)
        if(currentScore > highScore){
            highScore = currentScore
            UserDefaults.standard.set(highScore, forKey: Constants.highScore)
            UserDefaults.standard.synchronize()
        }
        
        scoreLabel.text = String(currentScore)
        //highScoreLabel.text = String(highScore)
    }
    
}
