//
//  MainViewController.swift
//  Quiz-Challenge
//
//  Created by Ramiro Lima Vale Neto on 21/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
	
	@IBOutlet weak var blankView: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var insertWordTF: UITextField!
	@IBOutlet weak var wordListTable: UITableView!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var controlButton: PrimaryButton!
	@IBOutlet weak var grayView: UIView!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	
	private var isPortrait: Bool {
		let orientation = UIDevice.current.orientation
		switch orientation {
		case .portrait, .portraitUpsideDown:
			return true
		case .landscapeLeft, .landscapeRight:
			return false
		default:
			return true
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configView()
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
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
		self.view.addGestureRecognizer(tapGesture)
	}
	
	
	//Mark: - Blank Functions
	private func hideView(){
		titleLabel.isHidden = true
		insertWordTF.isHidden = true
		wordListTable.isHidden = true
	}
	
	private func showView(){
		titleLabel.isHidden  = false
		insertWordTF.isHidden = false
		wordListTable.isHidden = false
	}
	
	//Mark: - Notifications Functions
	@objc private func keyboardWillShow(_ notification: Notification) {
		if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardRectangle = keyboardFrame.cgRectValue
			let keyboardHeight = keyboardRectangle.height
			self.bottomConstraint.constant = keyboardHeight
		}
	}
	
	@objc private func keyboardWillHide(_ notification: Notification) {
		self.bottomConstraint.constant = 0
	}
	
	@objc private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
		insertWordTF.resignFirstResponder()
	}
	
	
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = "Oi"
		return cell
	}
	
	
}
