//
//  ViewController.swift
//  PoliticalParty
//
//  Created by Brian Hans on 10/13/16.
//  Copyright © 2016 Brian Hans. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, AnswerButtonDelegate {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var question1btn: AnswerButton!
    @IBOutlet weak var question2btn: AnswerButton!
    @IBOutlet weak var question3btn: AnswerButton!
    @IBOutlet weak var question4btn: AnswerButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
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
                timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
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
        game = Game()
        setupQuestion(question: game.getNextQuestion()!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        countDown = false
    }
    
    func setupQuestion(question: Question) {
        countDown = true
        self.questionLabel.text = question.text
        self.categoryLabel.text = question.category.rawValue
        for i in 0..<question.options.count{
            self.buttons[i].answer = question.options[i]
            self.buttons[i].isSelected = false
        }
        
        enableButtons()
        self.startTime = NSDate.timeIntervalSinceReferenceDate
    }
    
    
    func pressed(sender: AnswerButton) {
        sender.isSelected = true
        selectRightAnswer()
        
        //Prevent issues with timer
        countDown = false
        
        //Delay 4 seconds so they can see correct answer
        self.game.sendAnswer(answer: sender.answer)
        disableButtons()
        selectRightAnswer()
        perform(#selector(nextQuestion), with: sender, afterDelay: 2)
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
    
    func disableButtons(){
        for button in buttons{
            button.isUserInteractionEnabled = false
        }
    }
    
    func enableButtons(){
        for button in buttons{
            button.isUserInteractionEnabled = true
        }
    }
    
    func nextQuestion(){
        countDown = false
        if let question = self.game.getNextQuestion(){
            setupQuestion(question: question)
        }else{
            performSegue(withIdentifier: "GameOver", sender: nil)
        }
    }
    
    func updateTimer(){
        let currentTimeDifference = NSDate.timeIntervalSinceReferenceDate - startTime
        if(questionTime - currentTimeDifference <= 0){
            game.timeUp()
            countDown = false
            nextQuestion()
        }else{
            timerLabel.text = String(Int(questionTime - currentTimeDifference))
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!countDown){
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            nextQuestion()
        }
    }
    
}

