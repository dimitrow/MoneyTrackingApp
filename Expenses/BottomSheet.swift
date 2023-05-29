//
//  BottomSheet.swift
//  Expenses
//
//  Created by Gene Dimitrow on 30.11.2022.
//

import SwiftUI

struct BottomSheet: View {

    @State var translation: CGSize = .zero
    @State var offsetY: CGFloat = 500
    @State var height: CGFloat = .infinity

    var body: some View {
        GeometryReader { proxy in
            VStack{
                Capsule()
                    .frame(width: 44, height: 8)
                    .padding(.top, 12)
                Spacer()
                    .frame(height: 40)
                Text("New expense")
                Text("add something")
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue)
            .cornerRadius(30, corners: [.topLeft, .topRight])
            .offset(y: translation.height + offsetY)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        translation = value.translation
                        height = value.translation.height
                    }
                    .onEnded { value in
                        withAnimation(.interactiveSpring(response: 0.4,
                                                         dampingFraction: 0.9)) {

                            let snap = translation.height + offsetY
                            let quarter = proxy.size.height / 4

                            if snap > quarter {
                                offsetY = quarter * 2
                            } else {
                                offsetY = 0
                            }

                            translation = .zero
                        }
                    }

            )
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
    }
}



///
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
