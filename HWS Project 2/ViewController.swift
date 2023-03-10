//
//  ViewController.swift
//  HWS Project 2
//
//  Created by Walker Lockard on 3/9/23.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    let MAX_TURNS = 10
    
    var countries = [String]()
    var score: UInt = 0
    var correctAnswer = 0
    var turns = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countries += [
            "estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria",
            "poland", "russia", "spain", "uk", "us"
        ]
        
        setupNavigation()
        setupButtons()
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        self.turns += 1
        
        self.countries.shuffle()
        self.correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: self.countries[0]), for: .normal)
        button2.setImage(UIImage(named: self.countries[1]), for: .normal)
        button3.setImage(UIImage(named: self.countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) (\(self.score))"
    }
    
    private func resetGame(action: UIAlertAction! = nil) {
        self.score = 0
        self.turns = 0
        self.askQuestion()
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == self.correctAnswer {
            title = "Correct"
            self.updateScore(correct: true)
        } else {
            let mistake = self.countries[sender.tag]
            title = "Wrong (\(mistake.uppercased()))"
            self.updateScore(correct: false)
        }
        
        var message: String
        if self.isGameOver() {
            let percent = Double(self.score) / Double(self.turns) * 100
            message = "Game Over! Your score is \(self.score) of \(self.turns), " +
                "or \(String(format: "%.0f", percent))."
        } else {
            message = "Your score is: \(self.score)."
        }
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        var alertAction: UIAlertAction
        if self.isGameOver() {
            alertAction = UIAlertAction(
                title: "Start Over",
                style: .default,
                handler: resetGame
            )
        } else {
            alertAction = UIAlertAction(
                title: "Continue",
                style: .default,
                handler: askQuestion
            )
        }
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true)
    }
    
    /**
     Increment the score if correct, decrement if wrong. Can't do less than 0 points.
     */
    private func updateScore(correct: Bool) {
        if correct {
            self.score += 1
            return
        }
        
        if self.score == 0 {
            // Prevent score < 0
            return
        }
        
        score -= 1
    }
    
    private func isGameOver() -> Bool {
        self.turns == self.MAX_TURNS
    }
    
    private func setupNavigation() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = .systemGray6
        navAppearance.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 20.0),
            .foregroundColor: UIColor.black
        ]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = navAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navAppearance
    }
    
    private func setupButtons() {
        self.button1.layer.borderWidth = 1
        self.button1.layer.borderColor = UIColor.lightGray.cgColor
        
        self.button2.layer.borderWidth = 1
        self.button2.layer.borderColor = UIColor.lightGray.cgColor
        
        self.button3.layer.borderWidth = 1
        self.button3.layer.borderColor = UIColor.lightGray.cgColor
    }
}

