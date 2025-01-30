//
//  SnackbarView.swift
//  Flag Challenge
//
//  Created by Anatoliy Ostapenko on 30.01.2025.
//

import SwiftUI

struct SnackbarInfo {
    let text: String
    let color: Color
}

enum SnackbarState {
    case success, fail
    
    var content: SnackbarInfo {
        switch self {
        case .success:
            return .init(
                text: "Success! Well done!",
                color: .green)
        case .fail:
            return .init(
                text: "It's wrong :( You can do better, let go!",
                color: .red)
        }
    }
}

struct SnackbarView: View {
    let state: SnackbarState
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack {
            Spacer()
            if isVisible {
                Text(state.content.text)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(state.content.color)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 6)
                    .padding(.horizontal, 16)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                isVisible = false
                            }
                        }
                    }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isVisible)
    }
}


