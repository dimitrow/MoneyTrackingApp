//
//  ContentView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 20.11.2022.
//

import SwiftUI

struct ContentView: View {

    @State var isShowingBottomSheet = false

    var body: some View {
        ZStack{

            Button{
                withAnimation{
                    isShowingBottomSheet.toggle()
                }
            } label: {
                Text("Open Bottom Sheet")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

