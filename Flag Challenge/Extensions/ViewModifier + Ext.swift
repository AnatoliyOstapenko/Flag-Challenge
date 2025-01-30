//
//  ViewModifier + Ext.swift
//  Flag Challenge
//
//  Created by Anatoliy Ostapenko on 30.01.2025.
//

import SwiftUI

struct StrokeBorderModifier: ViewModifier {
    let corner: CGFloat
    let color: Color
    let lineWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .stroke(color, lineWidth: lineWidth)
            }
            .mask {
                RoundedRectangle(cornerRadius: corner, style: .continuous)
            }
    }
}

extension View {
    func strokeBorder(with corner: CGFloat = 0, color: Color, lineWidth: CGFloat = 2) -> some View {
        modifier(StrokeBorderModifier(corner: corner, color: color, lineWidth: lineWidth))
    }
}
