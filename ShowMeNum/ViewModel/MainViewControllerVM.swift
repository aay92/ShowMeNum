//
//  MainViewControllerVM.swift
//  ShowMeNum
//
//  Created by Aleksey Alyonin on 23.10.2023.
//

import UIKit
import Combine
import CombineCocoa

class MainViewControllerVM {
    
    struct Input {
        let numberPublisher: AnyPublisher<Double, Never>
        let inputNumber: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewScreen: AnyPublisher<ModelNumber, Never>
        let resetPublisher: AnyPublisher<Void, Never>
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {
        
        //        input.splitPublisher.sink { text in
        //            print("split :\(text)")
        //        }.store(in: &cancellable)
        
        let updateView = Publishers.CombineLatest(
            input.numberPublisher,
            input.numberPublisher).flatMap { num1, num2 in
                let result = ModelNumber(number: num1 + num2)
                return Just(result)
            }.eraseToAnyPublisher()
        
        input.inputNumber.sink { bool in
            
        }.store(in: &cancellable)
        
        let resetPublisher = input.inputNumber.eraseToAnyPublisher()
        
        return Output(
            updateViewScreen: updateView,
            resetPublisher: resetPublisher)
    }
}
