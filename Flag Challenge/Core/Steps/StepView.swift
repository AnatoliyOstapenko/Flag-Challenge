//
//  StepView.swift
//  Flag Challenge
//
//  Created by Anatoliy Ostapenko on 30.01.2025.
//

import SwiftUI

struct StepView: View {
    @ObservedObject var viewModel: InitialViewModel
    private let spacing: CGFloat = 30
    var body: some View {
        ZStack {
            VStack {
                if let currentQuestion = viewModel.currentQuestion {
                    FlagView(currentQuestion)
                    ButtonsView(currentQuestion)
                    Spacer()
                } else {
                    EmptyView()
                }
            }
            .blur(radius: viewModel.isSnackbarVisible ? 5 : 0)
            .padding(.horizontal)
            
            SnackbarView(
                state: viewModel.snackbar,
                isVisible: $viewModel.isSnackbarVisible
            )
        }
    }
    
    // MARK: Subviews
    @ViewBuilder
    private func FlagView(_ currentQuestion: Country) -> some View {
        VStack(spacing: spacing) {
            Text("Step: \(currentQuestion.step)")
                .font(.system(size: 20, weight: .bold))
            Text(currentQuestion.flag)
                .font(.system(size: spacing * 3))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .strokeBorder(color: .gray, lineWidth: 1)
    }
    
    @ViewBuilder
    private func ButtonsView(_ currentQuestion: Country) -> some View {
        VStack(spacing: spacing / 2) {
            ForEach(currentQuestion.button) { button in
                Button {
                    handleBtnTapped(button)
                } label: {
                    Text(button.buttonName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .strokeBorder(color: .gray, lineWidth: 1)
            }
        }
        .padding(.top, spacing)
    }
    
    // MARK: Actions
    private func handleBtnTapped(_ country: CountryButton) {
        withAnimation {
            viewModel.checkAnswer(for: country)
        }
    }
}
