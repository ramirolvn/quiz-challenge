//
//  MainViewModel.swift
//  Quiz-Challenge
//
//  Created by Ramiro Lima Vale Neto on 21/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewModelProtocol{
	func getWordsFromServer()
	func resetGame()
	func testIfExistWord(_ word: String) -> Bool
	func rowsCount() -> Int
	func buttonPressed()
	var isPlaying: Bool {get}
	var timeLabelText: Observable<String> {get}
	var scoreLabelText: Observable<String> {get}
	var wordsToShow: Observable<[String]> {get}
	var quiz1: Observable<Quiz1?> {get}
	var timeOver: Observable<Bool> {get}
	var gameCompleted: Observable<Bool>{get}
	var maxScore: Int {get}
	var userScore: Int {get}
	
}

class MainViewModel: MainViewModelProtocol {
	
	let provider = ServiceProvider<CodeChallengeService>()
	var quiz1: Observable<Quiz1?> = Observable(nil)
	var isPlaying: Bool = false
	var maxScore: Int = 50
	private var count: Int = 15
	private var timer: Timer!
	private let refreshFrequency: TimeInterval
	var userScore: Int = 0
	private var wordsFound: [String] = []
	var timeLabelText: Observable<String> = Observable("05:00")
	var scoreLabelText: Observable<String>
	var wordsToShow: Observable<[String]> = Observable([])
	var timeOver: Observable<Bool> = Observable(false)
	var gameCompleted: Observable<Bool> = Observable(false)
	
	init(refreshFrequency: TimeInterval = 1) {
		self.refreshFrequency = refreshFrequency
		self.scoreLabelText = Observable("00/\(maxScore)")
		print("INITIALIZATION -> MainViewModel")
	}
	
	deinit {
		print("DEINITIALIZATION -> MainViewModel")
	}
	
	func getWordsFromServer(){
		provider.load(service: .allWords, completion: {
			result in
			switch result {
			case .success(let resp):
				do{
					let quiz1 = try JSONDecoder().decode(Quiz1.self, from: resp)
					self.quiz1.value = quiz1
//					self.maxScore = quiz1.answer.count
					self.maxScore = 5
				}
				catch{
					self.quiz1.value = nil
				}
			case .failure(let error):
				self.quiz1.value = nil
				print(error.localizedDescription)
			case .empty:
				self.quiz1.value = nil
			}
		})
	}
	
	func testIfExistWord(_ word: String)->Bool{
		guard let quiz1 = self.quiz1.value else {return true}
		let quizAnswer = quiz1.answer
		let quizAux = quizAnswer.map { $0.lowercased()}
		let isFoundString = quizAux.contains(word.lowercased())
		if isFoundString && isPlaying{
			return self.countScore(word: word)
		}
		return true
	}
	
	private func countScore(word: String) -> Bool{
		if self.userScore < maxScore && !self.wordsFound.contains(word){
			self.userScore += 1
			let scoreToShow = self.userScore < 10 ? "0\(self.userScore)" : "\(self.userScore)"
			self.scoreLabelText.value = "\(scoreToShow)/\(maxScore)"
			self.wordsFound.append(word)
			self.wordsToShow.value = self.wordsFound
			if userScore == self.maxScore {
				self.gameCompleted.value = true
				self.pauseGame()
			}
			return false
		}
		return true
	}
	
	func buttonPressed(){
		if isPlaying{
			resetGame()
		}else{
			startGame()
		}
	}
	
	//MARK - Timer Control
	private func startGame(){
		self.count = 15
		isPlaying = true
		timer = Timer.scheduledTimer(timeInterval: refreshFrequency, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
	}
	
	func resetGame(){
		self.count = 15
		self.userScore = 0
		timeLabelText.value = "05:00"
		scoreLabelText.value = "00/\(maxScore)"
		self.wordsFound = []
		self.wordsToShow.value = self.wordsFound
		timeOver.value = false
		isPlaying = false
		timer.invalidate()
	}
	
	private func pauseGame(){
		timer.invalidate()
	}
	
	@objc func refreshData() {
		if(count >= 0){
			let minutes = String(count / 60).count == 1 ? "0\(String(count / 60))" : String(count / 60)
			let seconds = String(count % 60).count == 1 ? "0\(String(count % 60))" : String(count % 60)
			count-=1
			timeLabelText.value = minutes + ":" + seconds
		}else if !timeOver.value{
			timeOver.value = true
		}
	}
	
	//Mark: = TableView Controls
	
	func rowsCount() -> Int{
		return self.wordsFound.count
	}
}

