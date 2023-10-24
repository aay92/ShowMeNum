//
//  MainViewController.swift
//  ShowMeNum
//
//  Created by Aleksey Alyonin on 21.10.2023.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class MainViewController: UIViewController {
        
    let logoView = LogoView()
    let viewNumber = ViewNumber()
    let inputNun = InputNumber()
    
    ///combine property
    let vm = MainViewControllerVM()
    var cancellable = Set<AnyCancellable>()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews:
                [logoView,
                 UIView(),
                 viewNumber,
                 inputNun]
        )
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    ///gesture
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: nil)
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configure()
        layoutSnapKit()
        bind()
        observe()
        keyboardGoing()
    }
    
    private func observe() {
        viewTapPublisher.sink { [unowned self] taps in
            view.endEditing(true)///грубо говоря убираем клавиатуру при нажатие на любой участок вью
        }.store(in: &cancellable)
    }
    
    private func configure(){
        view.backgroundColor = ColorApp.ColorBack.bg
        view.layer.borderColor = ColorApp.ColorBack.bgBorder.cgColor
        view.layer.cornerRadius = 75
        view.layer.borderWidth = 10
    }
    
    func bind(){
        ///view model Input
        let input = MainViewControllerVM.Input(
            numberPublisher: inputNun.valuePublisher, inputNumber: viewTapPublisher)
        
        ///output
        let output = vm.transform(input: input)
        
        output.updateViewScreen.sink { modelNumber in
            self.viewNumber.configure(number: modelNumber)
        }.store(in: &cancellable)
        
        if inputNun.isChangeswitchON_OFF {
            self.inputNun.reset()
            self.viewNumber.reset()
        }
//        output.resetPublisher.sink { reset in
//            self.inputNun.reset()
//            self.viewNumber.reset()
//        }.store(in: &cancellable)

    }
    
    private func layoutSnapKit(){
        [stack].forEach(view.addSubview(_:))
        
        stack.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-200)
            make.top.equalTo(view.snp.topMargin).offset(-40)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        viewNumber.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        inputNun.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
    }
    
    private func keyboardGoing(){
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidenKayBoard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}




