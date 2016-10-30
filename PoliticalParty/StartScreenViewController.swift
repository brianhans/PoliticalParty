//
//  StartScreenViewController.swift
//  PoliticalParty
//
//  Created by Brian Hans on 10/20/16.
//  Copyright © 2016 Brian Hans. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController{
    
    var questions: [Question] = []
    
    override func viewDidLoad() {
        loadQuestions()
    }
    
    func loadQuestions(){
        if let path = Bundle.main.path(forResource: "questions", ofType: "json")
        {
            do{
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.dataReadingMapped)
                if let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                {
                    if let questions = jsonResult["questions"] as? [[String: String]]
                    {
                        for question in questions{
                            self.questions.append(Question(json: question))
                        }
                    }
                }
            }catch{
                print("error" + #function)
            }

            
        }
    }
    @IBAction func startButtonPressed(_ sender: AnyObject) {
        let viewController = GameViewController()
        present(viewController, animated: true, completion: nil)
    }
}
