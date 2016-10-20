//
//  ViewController.swift
//  PoliticalParty
//
//  Created by Brian Hans on 10/13/16.
//  Copyright © 2016 Brian Hans. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameDelegate, AnswerButtonDelegate {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var question1btn: AnswerButton!
    @IBOutlet weak var question2btn: AnswerButton!
    @IBOutlet weak var question3btn: AnswerButton!
    @IBOutlet weak var question4btn: AnswerButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var game: Game!
    var buttons: [AnswerButton] = []
    var startTime: TimeInterval!
    
    let questionTime: Double = 10
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttons = [question1btn, question2btn, question3btn, question4btn]
        game = Game(self)
        
        //Sets up timer
        startTime = NSDate.timeIntervalSinceReferenceDate
        let runLoop = RunLoop.current
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        runLoop.add(timer, forMode: RunLoopMode.commonModes)
        runLoop.add(timer, forMode: RunLoopMode.UITrackingRunLoopMode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    func newQuestion(question: Question) {
        questionLabel.text = question.text
        for i in 0..<question.options.count{
            buttons[i].answer = question.options[i]
        }
        startTime = NSDate.timeIntervalSinceReferenceDate
    }
    
    func gameOver() {
        performSegue(withIdentifier: "GameOver", sender: nil)
    }
    
    func pressed(sender: AnswerButton) {
        if(!game.checkAnswer(answer: sender.answer)){
            print("wrong")
        }else{
            print("correct")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GameOver"){
            let controller = segue.destination as! GameOverViewController
            controller.game = self.game
        }
    }
    
    func updateTimer(){
        let currentTimeDifference = NSDate.timeIntervalSinceReferenceDate - startTime
        if(questionTime - currentTimeDifference <= 0){
            game.timeUp()
        }else{
            timerLabel.text = String(Int(questionTime - currentTimeDifference))
        }
        
    }
    
}

