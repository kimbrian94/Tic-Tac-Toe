//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Brian Kim on 2020-06-18.
//  Copyright © 2020 Brian Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /*
     0 is empty
     1 is O
     2 is X
     */
    var board: [String] = ["", "", "", "", "", "", "", "", ""]
    var winCombination = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2 ,4, 6]]
    var isOTurn = true
    var gameActive = true

    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLabel.center = CGPoint(x: outputLabel.center.x - 500, y: outputLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
        
        outputLabel.isHidden = true
        playAgainButton.isHidden = true
    }

    @IBAction func move(_ sender: AnyObject) {
        if gameActive {
            if let tag = sender.tag {
                if isOTurn && board[tag - 1] == "" {
                    board[tag - 1] = "o"
                    sender.setImage(UIImage(named: "nought.png"), for: [])
                    isOTurn = false
                } else if isOTurn == false && board[tag - 1] == "" {
                    board[tag - 1] = "x"
                    sender.setImage(UIImage(named: "cross.png"), for: [])
                    isOTurn = true
                }
            }
            checkOver()
        }
    }
    
    @IBAction func playAgain(_ sender: Any) {
        board = ["", "", "", "", "", "", "", "", ""]
        
        outputLabel.text = ""
        
        gameActive = true
        
        isOTurn = true
                
        for i in 1...9 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
        
        viewDidLoad()
    }
    
    func checkOver() {
        var result = false
        var winner = "Cross"
        for combination in winCombination {
            if board[combination[0]] == "o" && board[combination[1]] == "o" && board[combination[2]] == "o" {
                winner = "Circle"
                result = true
            } else if board[combination[0]] == "x" && board[combination[1]] == "x" && board[combination[2]] == "x" {
                result = true
            }
        }
        
        if !result && (board[0] != "" && board[1] != "" && board[2] != "" && board[3] != "" && board[4] != "" && board[5] != "" && board[6] != "" && board[7] != "" && board[8] != "") {
            winner = "Tie"
            result = true
        }
        
        if result {
            gameOver(winner: winner)
        }
    }
    
    func gameOver(winner: String) {
        if winner == "Cross" {
            outputLabel.text = "Cross has won!"
        } else if winner == "Circle" {
            outputLabel.text = "Circle has won!"
        } else {
            outputLabel.text = "Game is tied!"
        }
        
        outputLabel.isHidden = false
        playAgainButton.isHidden = false
        
        UIView.animate(withDuration: 1, animations: {
            self.outputLabel.center = CGPoint(x: self.outputLabel.center.x + 500, y: self.outputLabel.center.y)
        })
        UIView.animate(withDuration: 1, animations: {
            self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x + 500, y: self.playAgainButton.center.y)
        })
        gameActive = false
    }
}

