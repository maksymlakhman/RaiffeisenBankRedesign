//
//  ProgressView.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 25.05.2024.
//

import SwiftUI


struct CustomProgressView: View {
    
    @State private var trimEnd: CGFloat = 0.0
    let gradient = LinearGradient(
        stops: [
            Gradient.Stop(color: .primary, location: 0.1),
            Gradient.Stop(color: .primary.opacity(0.8), location: 0.4),
            Gradient.Stop(color: .primary.opacity(0.4), location: 0.8)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        ZStack {
            Color.mainYellow.ignoresSafeArea(.all)
            Circle()
                .trim(from: 0.0, to: trimEnd)
//                .fill(gradient)
                .frame(width: 120, height: 120)
                .animation(
                    Animation.easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: true)
                    , value: trimEnd
                )
                .onAppear {
                    trimEnd = 1
                }
            LoadingContent()

        }
    }
}


struct LoadingContent: View {
    @State var degreesRotating = 0.0
    
    var body: some View {
        Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
            .font(.system(size: 70))
            .foregroundStyle(
                    .linearGradient(colors: [.yellow, .black], startPoint: .top, endPoint: .bottomTrailing)
                )
            .rotationEffect(.degrees(degreesRotating))
        
            .onAppear {
                withAnimation(.linear(duration: 0.3)
                    .speed(0.1).repeatForever(autoreverses: false)) {
                        degreesRotating = 360.0
                    }
            }
    }
}


#Preview {
    CustomProgressView()
}







