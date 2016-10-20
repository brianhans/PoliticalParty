//
//  QuestionButton.swift
//  PoliticalParty
//
//  Created by Brian Hans on 10/17/16.
//  Copyright © 2016 Brian Hans. All rights reserved.
//

import UIKit

class AnswerButton: UIButton{
    var answer: Answer!{
        didSet{
            self.setTitle(answer.text, for: .normal)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if(isSelected){
                self.backgroundColor = answer.correct ? UIColor.green : UIColor.red
            }else{
                self.backgroundColor = .clear
            }
        }
    }
    
    @IBOutlet var delegate: AnswerButtonDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    func tapped(){
        delegate.pressed(sender: self)
    }
    
}

@objc protocol AnswerButtonDelegate {
    func pressed(sender: AnswerButton)
}
