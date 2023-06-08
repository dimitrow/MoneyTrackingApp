//
//  AddNewIntervalView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 04.06.2023.
//

import SwiftUI

enum KeyboardOperation {
    case submit
    case removeLast
    case clearAll
}

struct AddNewIntervalView<Model: AddNewIntervalViewModelType>: View {

    @ObservedObject var viewModel: Model

    var body: some View {
        VStack {
            Text("IntervalAmount: \(viewModel.amount)")
                .padding(.bottom, 128)
            Text("Duration \(viewModel.duration) days")
                .padding(.bottom, 28)
            Slider(value: viewModel.durationBinding,
                   in: 10...30,
                   step: 1)
            .padding(.bottom, 64)
            .padding(.horizontal, 64)
            KeyboardView(value: viewModel.amountBinding)
//            GeometryReader { geometry in
//                VStack{
//                    HStack {
//                        VStack {
//                            numberButton(1)
//                            numberButton(4)
//                            numberButton(7)
//                        }
//                        VStack {
//                            numberButton(2)
//                            numberButton(5)
//                            numberButton(8)
//                        }
//                        VStack {
//                            numberButton(3)
//                            numberButton(6)
//                            numberButton(9)
//                        }
//                        VStack {
//                            funcButton(.submit)
//                            funcButton(.submit)
//                        }
//                    }
//                    .frame(height: geometry.size.height * 0.75)
//                    HStack {
//                        numberButton(0)
//                        funcButton(.submit)
//                    }
//                    .frame(height: geometry.size.height * 0.25)
//                }
//                .padding(.horizontal, 16)
//            }
//            .padding(.bottom, 32)
        }
        .background(Color.eaBackground)
        .navigationTitle("Create an Interval")
    }

//    @ViewBuilder
//    func numberButton(_ value: Int) -> some View {
//        ZStack {
//            Color.eaBackground
//            Text("\(value)")
//                .font(.system(size: 28, weight: .light))
//                .foregroundColor(.eaButtonOutline)
//                .padding(20)
//        }
//        .overlay(content: {
//            let borderWidth = 1.0
//            RoundedRectangle(cornerRadius: 20)
//                .inset(by: borderWidth / 2)
//                .stroke(Color.eaButtonOutline,
//                        lineWidth: borderWidth)
////                .shadow(color: .white, radius: 5)
//        })
//        .clipShape(
//            RoundedRectangle(cornerRadius: 20.0)
//        )
//        .shadow(color: .white, radius: 1)
//        .onTapGesture {
//            updateAmount(value)
//        }
//    }

//    @ViewBuilder
//    func funcButton(_ operation: KeyboardOperation) -> some View {
//        ZStack {
//            Color.eaBackground
//            Text("op")
//                .font(.system(size: 28, weight: .light))
//                .foregroundColor(.eaButtonOutline)
//                .padding(20)
//        }
//        .overlay(content: {
//            let borderWidth = 1.0
//            RoundedRectangle(cornerRadius: 20)
//                .inset(by: borderWidth / 2)
//                .stroke(Color.eaButtonOutline,
//                    lineWidth: borderWidth)
////                .shadow(color: .white, radius: 5)
//        })
//        .clipShape(
//            RoundedRectangle(cornerRadius: 20.0)
//        )
//        .shadow(color: .white, radius: 1)
//        .onTapGesture {
////            updateAmount(value)
//        }
//    }

//    func updateAmount(_ tag: Int) {
//        self.intervalAmount.append("\(tag)")
//    }
}

struct KeyboardView: View {

    @Binding var value: String

    var body: some View {
        GeometryReader { geometry in
            VStack{
                HStack {
                    VStack {
                        numberButton(1)
                        numberButton(4)
                        numberButton(7)
                    }
                    VStack {
                        numberButton(2)
                        numberButton(5)
                        numberButton(8)
                    }
                    VStack {
                        numberButton(3)
                        numberButton(6)
                        numberButton(9)
                    }
                    VStack {
                        funcButton(.submit)
                        funcButton(.submit)
                    }
                }
                .frame(height: geometry.size.height * 0.75)
                HStack {
                    numberButton(0)
                    funcButton(.submit)
                }
                .frame(height: geometry.size.height * 0.25)
            }
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 32)
    }

    @ViewBuilder
    func numberButton(_ value: Int) -> some View {
        ZStack {
            Color.eaBackground
            Text("\(value)")
                .font(.system(size: 28, weight: .light))
                .foregroundColor(.eaButtonOutline)
                .padding(20)
        }
        .overlay(content: {
            let borderWidth = 1.0
            RoundedRectangle(cornerRadius: 20)
                .inset(by: borderWidth / 2)
                .stroke(Color.eaButtonOutline,
                        lineWidth: borderWidth)
//                .shadow(color: .white, radius: 5)
        })
        .clipShape(
            RoundedRectangle(cornerRadius: 20.0)
        )
        .shadow(color: .white, radius: 1)
        .onTapGesture {
            updateAmount(value)
        }
    }

    @ViewBuilder
    func funcButton(_ operation: KeyboardOperation) -> some View {
        ZStack {
            Color.eaBackground
            Text("op")
                .font(.system(size: 28, weight: .light))
                .foregroundColor(.eaButtonOutline)
                .padding(20)
        }
        .overlay(content: {
            let borderWidth = 1.0
            RoundedRectangle(cornerRadius: 20)
                .inset(by: borderWidth / 2)
                .stroke(Color.eaButtonOutline,
                    lineWidth: borderWidth)
//                .shadow(color: .white, radius: 5)
        })
        .clipShape(
            RoundedRectangle(cornerRadius: 20.0)
        )
        .shadow(color: .white, radius: 1)
        .onTapGesture {
//            updateAmount(value)
        }
    }

    func updateAmount(_ tag: Int) {
        value.append("\(tag)")
    }
}


struct AddNewIntervalView_Previews: PreviewProvider {

    static let storageService = StorageService(storageManager: StorageManager.shared,
                                        storageMapper: StorageMapper())
    static let viewModel = AddNewIntervalViewModel(storageService: storageService,
                                                   router: Router())

    static var previews: some View {
        NavigationStack {
            AddNewIntervalView(viewModel: viewModel)
        }
    }
}
