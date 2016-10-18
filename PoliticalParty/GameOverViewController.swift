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
    
    var game: Game!
    
    override func viewDidLoad() {
        scoreLabel.text = String(game.correct.count * 10)
    }
    
}
