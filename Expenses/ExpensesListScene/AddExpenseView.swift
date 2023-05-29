//
//  AddExpenseView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 24.11.2022.
//

import SwiftUI

struct AddExpenseView: View {

    var body: some View {
        VStack {
            Spacer()
            HandleBar()
            TitleBar()
        }
        .background(Color.blue)
        .cornerRadius(20, antialiased: true)
//        .frame(height: 300)
        .offset(y: 600)
        .edgesIgnoringSafeArea(.all)
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
            .background(Color.black.opacity(0.3))
            .edgesIgnoringSafeArea(.all)
    }
}

struct HandleBar: View {
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 5)
            .foregroundColor(Color(.systemGray5))
            .cornerRadius(10)
    }
}

struct TitleBar: View {
    var body: some View {
        HStack {
            Text("Restaurant Details")
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
        }
        .padding()
    }
}
