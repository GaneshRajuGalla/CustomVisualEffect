//
//  CustomVisualEffect.swift
//  CustomVisualEffect
//
//  Created by Ganesh Raju Galla on 06/07/24.
//

import SwiftUI


struct CustomVisualEffect: View {
    var body: some View {
        DynamicHueListView()
    }
}

struct DynamicHueListView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(0..<20, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.tint)
                        .frame(height: 100)
                        .visualEffect { content, proxy in
                            content
                                .rotationEffect(.degrees(proxy.frame(in: .global).origin.y / 45))
                                .hueRotation(.degrees(proxy.frame(in: .global).origin.y / 10))
                        }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CustomVisualEffect()
}
