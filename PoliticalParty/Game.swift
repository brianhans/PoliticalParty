//
//  Gmae.swift
//  PoliticalParty
//
//  Created by Brian Hans on 10/17/16.
//  Copyright © 2016 Brian Hans. All rights reserved.
//

import Foundation

class Game{
    
    var correct: [Question] = []
    var incorrect: [Question] = []
    var questions: [Question]
    
    var delegate: GameDelegate

    init(_ delegate: GameDelegate){
        self.delegate = delegate
        questions = []
        self.questions = generateQuestions()
        delegate.newQuestion(question: questions[0])
    }
    
    init(_ delegate: GameDelegate, questions: [Question]){
        self.questions = questions
        self.delegate = delegate
        delegate.newQuestion(question: questions[0])
    }

    func generateQuestions() -> [Question]{
        var questions: [Question] = []
        questions.append(Question(text: "In what year was the Constitution signed?", category: .history, options: [Answer(text: "1787", correct: true), Answer(text: "1776", correct: false), Answer(text: "1790", correct: false), Answer(text: "1782", correct: false)]))
        
        questions.append(Question(text: "What was not a former political party?", category: .history, options: [Answer(text: "Democratic-Republicans Party", correct: false), Answer(text: "Whigs", correct: false), Answer(text: "Anti-Masonic Party", correct: false), Answer(text: "Tax-free Party", correct: true)]))
        
        return questions
    }
    
    func checkAnswer(answer: Answer) -> Bool{
        
        if(answer.correct){
            correct.append(questions.removeFirst())
        }else{
            incorrect.append(questions.removeFirst())
        }
        
        if(questions.count < 1){
            delegate.gameOver()
        }else{
            delegate.newQuestion(question: questions[0])
        }
        
        return answer.correct
    }
    
    func timeUp(){
        incorrect.append(questions.removeFirst())
        if(questions.count < 1){
            delegate.gameOver()
        }else{
            delegate.newQuestion(question: questions[0])
        }
    }

}

protocol GameDelegate {
    func newQuestion(question: Question)
    func gameOver()
}
