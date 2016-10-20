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
    
    var countDown: Bool = false{
        didSet{
            if(countDown){
                startTime = NSDate.timeIntervalSinceReferenceDate
                let runLoop = RunLoop.current
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
                runLoop.add(timer, forMode: RunLoopMode.commonModes)
                runLoop.add(timer, forMode: RunLoopMode.UITrackingRunLoopMode)
            }else{
                timer.invalidate()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttons = [question1btn, question2btn, question3btn, question4btn]
        game = Game(self)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        countDown = false
    }
    
    func newQuestion(question: Question) {
        countDown = true
        self.questionLabel.text = question.text
        for i in 0..<question.options.count{
            self.buttons[i].answer = question.options[i]
            self.buttons[i].isSelected = false
        }
        self.startTime = NSDate.timeIntervalSinceReferenceDate
        
        
    }
    
    func gameOver() {
        performSegue(withIdentifier: "GameOver", sender: nil)
    }
    
    func pressed(sender: AnswerButton) {
        sender.isSelected = true
        selectRightAnswer()
        
        //Prevent issues with timer
        countDown = false
        
        //Delay 4 seconds so they can see correct answer
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            if(!self.game.checkAnswer(answer: sender.answer)){
                print("wrong")
            }else{
                print("correct")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GameOver"){
            let controller = segue.destination as! GameOverViewController
            controller.game = self.game
        }
    }
    
    func selectRightAnswer(){
        for button in buttons{
            if(button.answer.correct){
                button.isSelected = true
                return
            }
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

