//
//  Quiz_ChallengeTests.swift
//  Quiz-ChallengeTests
//
//  Created by Ramiro Lima Vale Neto on 21/11/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import XCTest
@testable import Quiz_Challenge

class Quiz_ChallengeTests: XCTestCase {
	let mainViewModel = MainViewModel()
	let quizTest = Quiz1(question: "What is the best company to work for?", answer: ["Arc", "Touch"])
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testRows(){
		XCTAssertEqual(mainViewModel.wordsToShow.value.count, mainViewModel.rowsCount())
		mainViewModel.wordsToShow.value = quizTest.answer
		XCTAssertEqual(mainViewModel.rowsCount(), 2)
	}
	
	func testIsPlaying(){
		mainViewModel.isPlaying = false
		mainViewModel.buttonPressed()
		XCTAssertEqual(mainViewModel.isPlaying, true)
	}
	
	func testUserScore(){
		mainViewModel.isPlaying = true
		mainViewModel.quiz1.value = quizTest
		XCTAssertEqual(mainViewModel.userScore, 0)
		_ = mainViewModel.testIfExistWord("ArcTouch")
		_ = mainViewModel.testIfExistWord("Touch")
		_ = mainViewModel.testIfExistWord("Arc")
		XCTAssertEqual(mainViewModel.userScore, 2)
	}
	
}
