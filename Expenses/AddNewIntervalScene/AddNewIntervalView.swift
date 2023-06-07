//
//  AddNewIntervalView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 04.06.2023.
//

import SwiftUI

struct AddNewIntervalView<Model: AddNewIntervalViewModelType>: View {

    @ObservedObject var viewModel: Model

    @State private var interval = 30.0
    @State private var intervalAmount: String = "--"

    var body: some View {
        GeometryReader { geometry in
            NavigationStack{
                VStack(spacing: 0.0) {
                    ZStack{
                        Color(.systemBackground)
                            .edgesIgnoringSafeArea(.bottom)
                            .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                        VStack(spacing: 0.0) {
                            Color.white
                                .frame(height: 160)
                            Text("IntervalAmount: \(intervalAmount)")
                                .padding(.bottom, 28)
                            Text("Present data \(viewModel.duration)")
                                .padding(.bottom, 28)
                            Slider(value: viewModel.durationBinding,
                                   in: 10...30,
                                   step: 1)
                            .padding(.horizontal, 28)
                        }
                    }
                    ZStack {
                        Color.white
                            .cornerRadius(8, corners: [.topLeft, .topRight])
                            .padding(.top, 2)
                        VStack {
                            Button {
                                viewModel.createNewInterval()
                            } label: {
                                Text("Add new Interval")
                                    .padding()
                            }
                            VStack {
                                HStack {
                                    VStack {
                                        HStack {
                                            numberButton(1, proxy: geometry)
                                            numberButton(2, proxy: geometry)
                                            numberButton(3, proxy: geometry)
                                        }
                                        HStack {
                                            numberButton(4, proxy: geometry)
                                            numberButton(5, proxy: geometry)
                                            numberButton(6, proxy: geometry)
                                        }
                                        HStack {
                                            numberButton(7, proxy: geometry)
                                            numberButton(8, proxy: geometry)
                                            numberButton(9, proxy: geometry)
                                        }
                                    }
                                    VStack {
                                        numberButton(33, proxy: geometry)
                                        numberButton(25, proxy: geometry)
                                    }
                                }
                                HStack {
                                    numberButton(0, proxy: geometry)
                                    numberButton(11, proxy: geometry)
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                    }
                    .frame(height: geometry.size.height / 2)
                }
                .navigationTitle("Create an Interval")
                .background(.black)
                .ignoresSafeArea(.all, edges: .all)
            }
        }
    }

    @ViewBuilder
    func numberButton(_ value: Int, proxy: GeometryProxy) -> some View {
        ZStack {
            Text("\(value)")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
                .padding(20)
        }
        .frame(width: proxy.size.width / 5, height: proxy.size.height / 12)
        .overlay(content: {
            let borderWidth = 2.0
            RoundedRectangle(cornerRadius: 20)
                .inset(by: borderWidth / 2)
                .stroke(.black,
                    lineWidth: borderWidth)
        })
        .background(Color.gray)
        .clipShape(
            RoundedRectangle(cornerRadius: 20.0)
        ).onTapGesture {
            updateAmount(value)
        }
    }

    func updateAmount(_ tag: Int) {
        self.intervalAmount.append("\(tag)")
    }
}

struct AddNewIntervalView_Previews: PreviewProvider {

    static let storageService = StorageService(storageManager: StorageManager.shared,
                                        storageMapper: StorageMapper())
    static let viewModel = AddNewIntervalViewModel(storageService: storageService,
                                                   router: Router())

    static var previews: some View {
        AddNewIntervalView(viewModel: viewModel)
    }
}
