//
//  ScrollEffectsBootCamp.swift
//  CustomVisualEffect
//
//  Created by Ganesh Raju Galla on 05/07/24.
//

import SwiftUI

enum ScrollEffects: String, CaseIterable {
    case noEffect = "No Effect"
    case effect1 = "Effect-1"
    case effect2 = "Effect-2"
    case effect3 = "Effect-3"
}

struct Photo: Identifiable {
    let image: String
    let id: UUID = .init()
}


struct ScrollEffectsBootCamp: View {
    
    let photos: [Photo] = (1...10).map { Photo(image: "image\($0)") }
    
    // MARK: - Properties
    @State private var selectedEffect:ScrollEffects = .noEffect
    
    // MARK: - Body
    var body: some View {
        VStack {
            Picker("", selection: $selectedEffect) {
                ForEach(ScrollEffects.allCases, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .pickerStyle(.palette)
            .padding(.horizontal)
            switch selectedEffect {
            case .noEffect:
                StandardScrollView(photos: photos)
            case .effect1:
                RotatingScrollItems(photos: photos)
            case .effect2:
                HorizontalOffsetEffect(photos: photos)
            case .effect3:
                VerticalOffsetEffect(photos: photos)
            }
        }
    }
}

struct StandardScrollView: View {
    let photos: [Photo]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(photos, id: \.id) { photo in
                    ScrollItem(photo: photo)
                }
            }
        }
        .contentMargins(30)
        .scrollTargetBehavior(.paging)
    }
}

struct RotatingScrollItems: View {
    let photos: [Photo]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(photos, id: \.id) { photo in
                    VStack {
                        ZStack {
                            ScrollItem(photo: photo)
                                .scrollTransition(axis: .horizontal) { content, phase in
                                    content
                                        .rotationEffect(.degrees(phase.value * 3.5))
                                        .offset(y: phase.isIdentity ? 0 : 16)
                                }
                        }
                        .containerRelativeFrame(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 36))
                    }
                }
            }
        }
        .contentMargins(36)
        .scrollTargetBehavior(.paging)
    }
}


struct HorizontalOffsetEffect: View {
    let photos: [Photo]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(photos, id: \.id) { photo in
                    VStack {
                        ZStack {
                            ScrollItem(photo: photo)
                                .scrollTransition(axis: .horizontal) { content, phase in
                                    content
                                        .offset(x: phase.isIdentity ? 0 : phase.value * -200)
                                }
                        }
                        .containerRelativeFrame(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 36))
                    }
                }
            }
        }
        .contentMargins(36)
        .scrollTargetBehavior(.paging)
    }
}


struct VerticalOffsetEffect: View {
    let photos: [Photo]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(photos, id: \.id) { photo in
                    VStack {
                        ZStack {
                            ScrollItem(photo: photo)
                                .scrollTransition(axis: .horizontal) { content, phase in
                                    content
                                        .offset(y: phase.isIdentity ? 0 : phase.value * -150)
                                }
                        }
                        .containerRelativeFrame(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 36))
                    }
                }
            }
        }
        .contentMargins(36)
        .scrollTargetBehavior(.paging)
    }
}

struct ScrollItem: View {
    let photo:Photo
    
    var body: some View {
        Image(photo.image)
            .resizable()
            .scaledToFill()
            .frame(height: 500)
            .containerRelativeFrame(.horizontal)
            .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    ScrollEffectsBootCamp()
}
