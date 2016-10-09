//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Peter Lee on 9/24/16.
//  Copyright © 2016 JPL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var ticTacImg1: UIImageView!
    @IBOutlet var ticTacImg2: UIImageView!
    @IBOutlet var thisIsATest: UIImageView!
    @IBOutlet var ticTacImg3: UIImageView!
    @IBOutlet var ticTacImg4: UIImageView!
    @IBOutlet var ticTacImg5: UIImageView!
    @IBOutlet var ticTacImg6: UIImageView!
    @IBOutlet var ticTacImg7: UIImageView!
    @IBOutlet var ticTacImg8: UIImageView!
    @IBOutlet var ticTacImg9: UIImageView!
    
    @IBOutlet var ticTacBtn1: UIButton!
    @IBOutlet var ticTacBtn2: UIButton!
    @IBOutlet var ticTacBtn3: UIButton!
    @IBOutlet var ticTacBtn4: UIButton!
    @IBOutlet var ticTacBtn5: UIButton!
    @IBOutlet var ticTacBtn6: UIButton!
    @IBOutlet var ticTacBtn7: UIButton!
    @IBOutlet var ticTacBtn8: UIButton!
    @IBOutlet var ticTacBtn9: UIButton!
    
    
    @IBOutlet var resetBtn: UIButton!
    
    
    @IBOutlet var userMessage: UILabel!
    
    var plays = Dictionary<Int,Int>()
    var done = false
    var aiDeciding = false
    
      @IBAction func UIButtonClicked(sender: UIButton){
        userMessage.isHidden = true
        if !(plays [sender.tag] != nil) && !aiDeciding && !done {
            setImageForSpot(spot: sender.tag, player:1)
        }
        checkForWin()
        aiTurn()
        
    }
    
    func setImageForSpot(spot:Int, player:Int){
        let playerMark = player == 1 ? "x" : "o"
        plays[spot] = player
        switch spot{
        case 1:
            ticTacImg1.image = UIImage(named: playerMark)
        case 2:
            ticTacImg2.image = UIImage(named: playerMark)
        case 3:
            ticTacImg3.image = UIImage(named: playerMark)
        case 4:
            ticTacImg4.image = UIImage(named: playerMark)
        case 5:
            ticTacImg5.image = UIImage(named: playerMark)
        case 6:
            ticTacImg6.image = UIImage(named: playerMark)
        case 7:
            ticTacImg7.image = UIImage(named: playerMark)
        case 8:
            ticTacImg8.image = UIImage(named: playerMark)
        case 9:
            ticTacImg9.image = UIImage(named: playerMark)
        default:
            ticTacImg5.image = UIImage(named: playerMark)
            
        }
   
    }
    func checkForWin(){
        let whoWon = ["I":0, "you":1]
        for(key,value) in whoWon {
            if ((plays[7] == value && plays[8] == value && plays[9] == value) || //across the bottom)
            (plays[4] == value && plays[5] == value && plays[6] == value) || //across the middle)
            (plays[1] == value && plays[2] == value && plays[3] == value) || //accross the top)
            (plays[1] == value && plays[4] == value && plays[7] == value) || //down the left)
            (plays[3] == value && plays[6] == value && plays[9] == value) || //down the right)
            (plays[2] == value && plays[5] == value && plays[8] == value) || //down the middle)
            (plays[1] == value && plays[5] == value && plays[9] == value) || //diag left right)
                (plays[3] == value && plays[5] == value && plays[7] == value)){ //diag right left
                    userMessage.isHidden = false
                    userMessage.text = "Looks like \(key) won!"
                    resetBtn.isHidden = false
                    done = true
            }
        }
        
    }
    
    @IBAction func resetBtnClicked(sender:UIButton){
        done = false
        resetBtn.isHidden = true
        userMessage.isHidden = true
        reset()
    }
    func reset() {
        plays = [:]
        ticTacImg1.image = nil
        ticTacImg2.image = nil
        ticTacImg3.image = nil
        ticTacImg4.image = nil
        ticTacImg5.image = nil
        ticTacImg6.image = nil
        ticTacImg7.image = nil
        ticTacImg8.image = nil
        ticTacImg9.image = nil
        
    }
    func rowCheck(#value:Int) -> (location:String, pattern:String)? {
        var acceptableFinds = ["011", "110", "101"]
        var findFuncs = [checkTop, checkBottom, checkLeft, checkRight, checkMiddleAcross, checkMiddleDown, checkDiagLeftRight, checkDiagRightLeft]
        for algorithm in findFuncs{
            var algorithmResults = algorithm(value:value)
            if find(acceptableFinds, algorithmResults.pattern)
                return algorithmResults
        }
    }
    
    func aiTurn(){
        if done {
            return
        }
        
        aiDeciding = true
        
      
        //We (the computer) have two in a row
        if let result = rowCheck(value:0) {
            
        }
        
        aiDeciding = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // add a comment
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
