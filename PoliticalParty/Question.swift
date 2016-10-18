//
//  Question.swift
//  PoliticalParty
//
//  Created by Brian Hans on 10/17/16.
//  Copyright © 2016 Brian Hans. All rights reserved.
//

import Foundation

class Question{
    var text: String
    var category: QuestionCategory
    var options: [Answer]
    
    init(text: String, category: QuestionCategory, options: [Answer]){
        self.text = text
        self.category = category
        self.options = options
    }
}

class Answer{
    var text: String
    var correct: Bool
    
    init(text: String, correct: Bool) {
        self.text = text
        self.correct = correct
    }
}

enum QuestionCategory{
    case history, candidates, policies
}
