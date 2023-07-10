//
//  ProgressView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 04.07.2023.
//

import SwiftUI

struct ProgressView: View {

    var colors: [Color] = [Color.eaMainBlue.opacity(0.7), Color.eaMainBlue]
    @Binding var progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.eaMainBlue, lineWidth: 16).opacity(0.25)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: progress > 0.3 ? colors : [Color.eaMainBlue]),
                                    center: .center,
                                    startAngle: .degrees(0),
                                    endAngle: .degrees(360 * progress - 3)),
                    style: StrokeStyle(lineWidth: 16, lineCap: .round)
                )
                .rotationEffect(.degrees(90))
            Circle()
                .trim(from: 0.25, to: 0.75)
                .frame(width: 14, height: 14)
                .foregroundColor(Color.eaMainBlue)
                .offset(y: 64)
                .rotationEffect(Angle.degrees(360 * progress))
                .shadow(color: Color.black.opacity(0.6), radius: 3)
            Circle()
                .frame(width: 16, height: 16)
                .foregroundColor(Color.eaMainBlue)
                .offset(y: 64)
                .rotationEffect(Angle.degrees(360 * progress))

        }
        .padding(.bottom, 8)
        .frame(width: 128)
        .animation(.easeOut, value: progress)
    }
}
