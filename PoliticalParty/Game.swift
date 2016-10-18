//
//  Gmae.swift
//  PoliticalParty
//
//  Created by Brian Hans on 10/17/16.
//  Copyright © 2016 Brian Hans. All rights reserved.
//

import Foundation

class Game{
    
    var score: Int = 0
    var correct: [Question] = []
    var incorrect: [Question] = []
    var questions: [Question]
    var currentQuestionIndex = 0
    
    
    init(){
        questions = []
        self.questions = generateQuestions()
    }
    
    init(questions: [Question]){
        self.questions = questions
    }
    
    func generateQuestions() -> [Question]{
        var questions: [Question] = []
        questions.append(Question(text: "In what year was the Constitution signed?", category: .history, options: [Answer(text: "1787", correct: true)]))
        return []
    }

}
