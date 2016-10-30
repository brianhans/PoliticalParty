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
    var incorrect: [Question] = []{
        didSet{
            print(incorrect.last ?? "")
        }
    }
    var questions: [Question]
    
    init(){
        questions = []
        self.questions = generateQuestions(10)
    }
    
    init(questions: [Question]){
        self.questions = questions
    }
    
    func generateQuestions(_ amount: Int) -> [Question]{
        var allQuestions: [Question] = []
        var tempQuestions: [Question] = []
        
        if let path = Bundle.main.path(forResource: "questions", ofType: "js")
        {
            do{
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.dataReadingMapped)
                if let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                {
                    if let questions = jsonResult["questions"] as? [[String: String]]
                    {
                        for question in questions{
                            allQuestions.append(Question(json: question))
                        }
                    }
                }
            }catch{
                print("error" + #function)
            }
            
        }
        
        for _ in 0..<amount{
            let randomNumber = Int(arc4random_uniform(UInt32(allQuestions.count - 1)))
            print(randomNumber)
            tempQuestions.append(allQuestions.remove(at: randomNumber))
        }
        
        
        return tempQuestions
    }
    
    func sendAnswer(_ answer: Answer) -> Bool{
        
        if(answer.correct){
            correct.append(questions.removeFirst())
            return true
        }else{
            incorrect.append(questions.removeFirst())
            return false
        }
    }
    
    func getNextQuestion() -> Question?{
        if(questions.count < 1){
            return nil
        }else{
            return questions[0]
        }
    }
    
    func timeUp(){
        if questions.count > 0{
            incorrect.append(questions.removeFirst())
        }
        
    }
    
}
