//
//  ViewController.swift
//  Swift-Tac-Toe
//
//  Created by Mohsin on 19/09/2014.
//  Copyright (c) 2014 Mohsin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var ticTacImg1: UIImageView!
    @IBOutlet var ticTacImg2: UIImageView!
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
    
    @IBOutlet var userMessage: UILabel!
    @IBOutlet var resetBtn: UIButton!
    @IBOutlet weak var lblDifficult: UILabel!
    @IBOutlet weak var lblModerate: UILabel!
    @IBOutlet weak var btnLevel: UISwitch!
    
    
    var plays = [Int](count: 10, repeatedValue: 2)
    var checkConditions = [1 : [1,2,3], 2 : [4,5,6], 3 : [7,8,9], 4 : [1,4,7], 5 : [2,5,8], 6 : [3,6,9], 7 : [1,5,9], 8 : [3,5,7] ]
    
    var aiDeciding = false
    var done = true
    var countTruns = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userMessage.text = "Let Play The Game!!"
        resetBtn.hidden = false
        userMessage.hidden = false
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func UIButtonClicked(sender: UIButton) {

        if plays[sender.tag] == 2 {
            if !aiDeciding && !done {
                countTruns++
                setImageForSpot(sender.tag, player: 1)
            }
            checkForWin()
            aiTurn()
        }

    
    }
    
    func setImageForSpot(spot: Int, player: Int){
        var playerMark = player == 1 ? "x" : "o"
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
        var whoWon = ["Computer":0, "you": 1]
        for (key, value) in whoWon{
            for x in 1...8 {
                let row = checkConditions[x]!
                
                if plays[row[0]] == value && plays[row[1]] == value && plays[row[2]] == value {
                    lblDifficult.hidden = false
                    lblModerate.hidden = false
                    btnLevel.hidden = false
                    userMessage.hidden = false
                    userMessage.text = "\(key) Win!!"
                    resetBtn.hidden = false
                    done = true
                    countTruns = 0
                }
            }
        }
        if !done && checkForFull() {
            lblDifficult.hidden = false
            lblModerate.hidden = false
            btnLevel.hidden = false
            userMessage.hidden = false
            userMessage.text = "Game is Tie"
            resetBtn.hidden = false
            done = true
            countTruns = 0
        }
    
    }


    @IBAction func reStart(sender: UIButton) {
        self.done = false
        self.aiDeciding = false
        lblDifficult.hidden = true
        lblModerate.hidden = true
        btnLevel.hidden = true
        userMessage.hidden = true
        resetBtn.hidden = true
        plays = [Int](count: 10, repeatedValue: 2)
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

    func aiTurn(){
        if done {
            return
        }
        
        aiDeciding = true
        
        if let positon = decidePosition() {
            setImageForSpot(positon, player: 0)
        }
        checkForWin()
        aiDeciding = false

    
    }
    
    func decidePosition() -> Int? {
        var firstPriority : Int?
        var secondPriority : Int?
        var thirdPriority : Int?
        countTruns++
        
        if btnLevel.on {
            
            // check for human cheats and play against it
            if (countTruns == 2) && (plays[1] == 1 || plays[3] == 1 || plays[7] == 1 || plays[9] == 1)
            {
                return 5
            }
                // check for human cheats and play against it
                
            else if (countTruns == 4) && (plays[2] == 2 || plays[4] == 2) && ( (plays[1] == 1 && plays[9] == 1) ||  (plays[3] == 1 && plays[7] == 1) )
            {
                if plays[2] == 2 {
                    return 2
                }
                else {
                    return 4
                }
            }
        }
        
        for x in 1...8 {
            let row = checkConditions[x]!
            if (plays[row[0]] == 2 && plays[row[1]] == 2 && plays[row[2]] == 2 ) ||            // all positions are full or empty
                ( plays[row[0]] != 2 && plays[row[1]] != 2 && plays[row[2]] != 2 )
            {
                continue
            }
            
            else if plays[row[0]] == 2 && plays[row[1]] == 2 ||
                    plays[row[1]] == 2 && plays[row[2]] == 2 ||
                    plays[row[0]] == 2 && plays[row[2]] == 2        // if only one of them is non empty
            {
                if plays[row[0]] == 2 {
                    thirdPriority = row[0]
                }
                else {                                              // we know that one of them is non empty if row [0] non empty means all others are empty
                    thirdPriority = row[1]
                }
            }
                
            else if plays[row[0]] == plays[row[1]] || plays[row[1]] == plays[row[2]] || plays[row[0]] == plays[row[2]]  // if only one of them is empty and other non empty are same
            {
                if plays[row[0]] == plays[row[1]] {
                    if plays[row[0]] == 0{
                        firstPriority = row[2]
                    }
                    else {
                        secondPriority = row[2]
                    }
                }
                else if plays[row[1]] == plays[row[2]]  {
                    if plays[row[1]] == 0{
                        firstPriority = row[0]
                    }
                    else {
                        secondPriority = row[0]
                    }
                }
                else if plays[row[0]] == plays[row[2]] {
                    if plays[row[1]] == 0{
                        firstPriority = row[1]
                    }
                    else {
                        secondPriority = row[1]
                    }
                }
            }
        }
        
        if let first = firstPriority {
            return first
        }
        
        else if let second = secondPriority {
            return second
        }
        
        else if let third = thirdPriority {
            return third
        }
        return nil
    }
    
    func checkForFull () -> Bool {
        var flag = true
        for x in 1...9 {
            if plays[x] == 2 {
                flag = false
            }
        }
        return flag
    }
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}


