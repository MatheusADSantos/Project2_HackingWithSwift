//
//  ViewController.swift
//  Project2_HackingWithSwift
//
//  Created by macbook-estagio on 03/03/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var times = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let url = Bundle.main.url(forResource: "Assets", withExtension: "png") {
//            do {
//                let myData = try Data(contentsOf: url)
//                print(myData.count)
//            } catch {
//                print(error)
//            }
//        }
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(askQuestion))
//        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(askQuestion))
        
        
        let change = UIBarButtonItem(title: "Change", style: .done, target: self, action: #selector(askQuestion(action:)))
        navigationItem.leftBarButtonItem = change
        
        let scoreTotal = UIBarButtonItem(title: "SCORE: \(score)", style: .plain, target: self, action: #selector(showTimeLineScore(action:)))
        navigationItem.rightBarButtonItem = scoreTotal
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
//        askQuestion()
    }

    @objc func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
        times += 1
//        print("countries", countries, "correctAnswer", correctAnswer, "title", title)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        controllerTimes(times: times)
    }
    
    func controllerTimes(times: Int) {
        print("Times: \(times)")
        if times >= 10 {
            let ac = UIAlertController(title: "Final", message: """
                Congratulations!
                Your score is \(score)
                """ ,preferredStyle: .alert)
            let tryAgain = UIAlertAction(title: "Try again", style: .default) { (action) in
                self.score = 0
                self.times = 0
                self.navigationItem.rightBarButtonItem?.title = "SCORE: \(0)"
                self.askQuestion(action: nil)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
                self.button1.isEnabled = false
                self.button2.isEnabled = false
                self.button3.isEnabled = false
                self.navigationItem.leftBarButtonItem?.isEnabled = false
            }
            ac.addAction(tryAgain)
            ac.addAction(cancel)
            present(ac, animated: true)
        }
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print(sender.tag)
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            askQuestion(action: nil)
        } else {
            title = "Wrong"
            score -= 1
            let ac = UIAlertController(title: "Atention", message: "Wrong! That’s the flag of \(countries[sender.tag])", preferredStyle: .alert)
            let aa = UIAlertAction(title: "Try Again!"  , style: .default, handler: askQuestion(action:))
            ac.addAction(aa)
            present(ac, animated: true)

        }
        if let buttonRight = self.navigationItem.rightBarButtonItem {
            buttonRight.title = "SCORE: \(score)"
            if self.score >= 0 {
                buttonRight.tintColor = .blue
            } else {
                buttonRight.tintColor = .red
            }
        }
        
        
                
        
//        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
//        present(ac, animated: true)
    }
    
    @objc func showTimeLineScore(action : UIBarButtonItem! = nil) {
        print("showing")
    }
    
}

