//
//  CustomVisualEffect.swift
//  CustomVisualEffect
//
//  Created by Ganesh Raju Galla on 06/07/24.
//

import SwiftUI


struct CustomVisualEffect: View {
    var body: some View {
        //DynamicHueListView()
        DynamicHueWithScaleListView()
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

struct DynamicHueWithScaleListView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(0..<20) {_ in
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(
                            red: Double.random(in: 0...1),
                            green: Double.random(in: 0...1),
                            blue: Double.random(in: 0...1)
                        ).gradient)
                        .frame(height: 100)
                        .visualEffect { content, proxy in
                            let frame = proxy.frame(in: .scrollView(axis: .vertical))
                            let distance = min(0, frame.minY)
                            return content
                                .hueRotation(.degrees(frame.origin.y / 2))
                                .scaleEffect(1 + distance / 700)
                                .offset(y: -distance / 1.25)
                                .brightness(-distance / 400)
                                .blur(radius: -distance / 50)
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
