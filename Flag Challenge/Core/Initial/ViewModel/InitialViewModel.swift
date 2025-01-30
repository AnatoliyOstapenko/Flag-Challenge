//
//  InitialViewModel.swift
//  Flag Challenge
//
//  Created by Anatoliy Ostapenko on 30.01.2025.
//

import SwiftUI
import Combine

class InitialViewModel: ObservableObject {
    // Game items
    @Published var result: String?
    @Published var countries: [Country] = []
    @Published var currentQuestion: Country?
    let gameOver = PassthroughSubject<Void, Never>()
    // Snackbar
    @Published var isSnackbarVisible = false
    @Published var snackbar: SnackbarState = .fail
    // Counter
    private var correctAnswer: Int = 0
    private var wrongAnswer: Int = 0
    private var step: Int = 1
        
    init() {
        countries = Country.mockCountries
    }

    func checkAnswer(for selectedCountry: CountryButton) {
        if selectedCountry.buttonName == currentQuestion?.rightAnswer {
            correctAnswer += 1
            snackbar = .success
        } else {
            wrongAnswer += 1
            snackbar = .fail
        }
        isSnackbarVisible.toggle()
        nextStep()
    }
    
    func resetGame() {
        isSnackbarVisible = false
        step = 1
        wrongAnswer = 0
        correctAnswer = 0
        getCurrentQuestion()
    }
    
    private func getCurrentQuestion() {
        currentQuestion = countries.first(where: {$0.step == step})
    }
    
    private func nextStep() {
        if step < countries.count {
            step += 1
            getCurrentQuestion()
        } else {
            result = "Last game result: \nCorrect: \(correctAnswer) \nWrong: \(wrongAnswer)"
            gameOver.send()
        }
    }
}
