//
//  MainViewController.swift
//  Quiz-Challenge
//
//  Created by Ramiro Lima Vale Neto on 21/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
	
	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var blankView: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var insertWordTF: UITextField!
	@IBOutlet weak var wordListTable: UITableView!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var controlButton: PrimaryButton!
	@IBOutlet weak var grayView: UIView!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var contentViewHeight: NSLayoutConstraint!
	
	private var keyboardHeight: CGFloat?
	
	private var wordsFounds: [String] = []
	
	
	
	var viewModel: MainViewModelProtocol!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewModel = MainViewModel()
		configView()
		getWords()
		
	}
	
	private func getWords(){
		self.showLoad()
		viewModel.getWordsFromServer()
	}
	
	private func configView(){
		wordListTable.delegate = self
		wordListTable.dataSource = self
		configTextField()
		notificationsObservers()
	}
	
	private func configTextField(){
		insertWordTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
		insertWordTF.layer.cornerRadius = 12
		insertWordTF.delegate = self
	}
	
	private func notificationsObservers(){
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow),
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillHide),
			name: UIResponder.keyboardWillHideNotification,
			object: nil
		)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(rotated),
			name: UIDevice.orientationDidChangeNotification,
			object: nil)
		
		viewModel.timeLabelText.addObserver { labeltext in
			self.timeLabel.text = labeltext
		}
		
		viewModel.scoreLabelText.addObserver({ labeltext in
			self.scoreLabel.text = labeltext
		})
		
		viewModel.wordsToShow.addObserver({ words in
			self.wordsFounds = words
			self.wordListTable.reloadData()
			self.insertWordTF.text = ""
			self.insertWordTF.becomeFirstResponder()
			
		})
		
		viewModel.quiz1.addObserver({ quiz in
			guard let quiz = quiz else { self.viewModel.getWordsFromServer();return}
			self.titleLabel.text = quiz.question
			self.hideLoad()
		})
		
		viewModel.timeOver.addObserver({ timeOver in
			if timeOver{
				self.showAlertTimeOver(userScore: self.viewModel.userScore, maxScore: self.viewModel.maxScore, tryAgainAction: {
					_ in
					self.playAgain()
				})
			}
		})
		
		viewModel.gameCompleted.addObserver({ gameCompleted in
			if gameCompleted{
				self.showAlertGameCompleted(playAgainAction: {_ in
					self.playAgain()
				})
			}
		})
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
		self.view.addGestureRecognizer(tapGesture)
	}
	
	private func playAgain(){
		self.controlButton.setTitle("Start", for: .normal)
		self.viewModel.resetGame()
	}
	
	
	//Mark: - Load Functions
	private func hideLoad(){
		self.stopLoad()
		titleLabel.isHidden = false
		insertWordTF.isHidden = false
		wordListTable.isHidden = false
	}
	
	private func showLoad(){
		self.startLoad()
		titleLabel.isHidden  = true
		insertWordTF.isHidden = true
		wordListTable.isHidden = true
	}
	
	//Mark: - Notifications Functions
	@objc private func keyboardWillShow(_ notification: Notification) {
		if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardRectangle = keyboardFrame.cgRectValue
			let keyboardHeight = keyboardRectangle.height
			self.keyboardHeight = keyboardHeight
			self.bottomConstraint.constant = keyboardHeight
			if UIDevice.current.orientation.isLandscape{
				self.contentViewHeight.constant = keyboardHeight
			}
			insertWordTF.becomeFirstResponder()
		}
	}
	
	@objc private func keyboardWillHide(_ notification: Notification) {
		self.bottomConstraint.constant = 16
		self.contentViewHeight.constant = 0
		self.keyboardHeight = nil
	}
	
	@objc private func rotated(){
		if UIDevice.current.orientation.isLandscape, let keyboardHeight = self.keyboardHeight{
			self.contentViewHeight.constant = keyboardHeight
		} else {
			self.contentViewHeight.constant = 0
		}
		
	}
	
	@objc private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
		insertWordTF.resignFirstResponder()
	}
	
	@IBAction func controlButtonAction(_ sender: PrimaryButton) {
		if viewModel.isPlaying{
			sender.setTitle("Start", for: .normal)
		}else{
			sender.setTitle("Reset", for: .normal)
		}
		viewModel.buttonPressed()
	}
	
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.rowsCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		let word = self.wordsFounds[indexPath.item]
		cell.textLabel?.text = word
		return cell
	}
}

extension MainViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField,
				   shouldChangeCharactersIn range: NSRange,
				   replacementString string: String) -> Bool {
		if let text = textField.text,
			let textRange = Range(range, in: text) {
			let updatedText = text.replacingCharacters(in: textRange,
													   with: string)
			return viewModel.testIfExistWord(updatedText)
		}
		return true
	}
}
