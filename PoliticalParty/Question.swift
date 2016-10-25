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
    
    init(json: [String : String]){
        self.text = json[Constants.question]!
        
        self.options = [];

        var answers = [Answer(text: json[Constants.answer1]!, correct: true),
                       Answer(text: json[Constants.answer2]!, correct: false),
                       Answer(text: json[Constants.answer3]!, correct: false),
                       Answer(text: json[Constants.answer4]!, correct: false)]

        for _ in 0..<4{
            options.append(answers.remove(at: Int(arc4random_uniform(UInt32(answers.count - 1)))))
        }
        
        self.category = QuestionCategory(rawValue: json[Constants.category]!.lowercased())!
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

enum QuestionCategory: String{
    case history, canidates, policies
}
