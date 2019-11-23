//
//  AlertView+UIViewController.swift
//  Quiz-Challenge
//
//  Created by Ramiro Lima Vale Neto on 23/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import UIKit


extension UIViewController {
	
	
	func showAlertTimeOver(userScore: Int, maxScore: Int, tryAgainAction: ((UIAlertAction) -> (Void))?){
		let alert = UIAlertController(title: "Time finished", message: "Sorry, time is up! You got \(userScore) out of \(maxScore) answers", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: tryAgainAction))
		
		self.present(alert, animated: true, completion: nil)
	}
	
	func showAlertGameCompleted(playAgainAction: ((UIAlertAction) -> (Void))?){
		let alert = UIAlertController(title: "Congratulations", message: "Good job! You found all the answers on time. Keep up with the great work.", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: playAgainAction))
		
		self.present(alert, animated: true, completion: nil)
	}
	
}
