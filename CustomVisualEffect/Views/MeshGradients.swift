//
//  MeshGradients.swift
//  CustomVisualEffect
//
//  Created by Ganesh Raju Galla on 07/07/24.
//

import SwiftUI

enum MeshGradientType: String, CaseIterable {
    case simple
    case animate
}

struct MeshGradients: View {
    
    // MARK: - Properties
    @State private var gradientType:MeshGradientType = .simple
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            switch gradientType {
            case .simple:
                MeshGradient1()
            case .animate:
                MeshGradient2()
            }
            
            Picker("", selection: $gradientType) {
                ForEach(MeshGradientType.allCases, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .pickerStyle(.palette)
            .padding(.horizontal)
            .padding(.top)
        }
    }
}

struct MeshGradient1: View {
    
    var body: some View {
        MeshGradient(width: 3,
                     height: 3,
                     points: [
                        [0, 0], [0.5, 0], [1.0, 0],
                        [0.0, 0.5], [0.8, 0.2], [1.0, 0.5],
                        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                     ],
                     colors: [
                        .black, .black, .black,
                        .blue, .blue, .blue,
                        .green, .green, .green
                     ])
        .edgesIgnoringSafeArea(.all)
    }
}

struct MeshGradient2: View {
    @State var colors: [Color] = [
           .black, .black, .black,
           .blue, .blue, .blue,
           .green, .green, .green
       ]
    
    var body: some View {
        MeshGradient(width: 3,
                     height: 3,
                     points: [
                        [0, 0], [0.4, 0], [1.0, 0],
                        [0.0, 0.5], [0.7, 0.4], [1.0, 0.5],
                        [0.0, 1.0], [0.3, 1.0], [1.0, 1.0]
                     ],
                     colors: colors)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            startTimer()
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            withAnimation(.easeInOut(duration: 1.0)) {
                colors = [
                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)),
                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                ]
            }
        }
    }
}

#Preview {
    MeshGradients()
}
