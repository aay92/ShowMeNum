//
//  InputNumber.swift
//  ShowMeNum
//
//  Created by Aleksey Alyonin on 22.10.2023.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

enum Constants {
    static let valueChange = "ValueChangeKey"
}


class InputNumber: UIView {
    
    let notificationCenter = NotificationCenter.default

    ///image under view
    private let viewUnberTextField: UIView = {
        let view = UIView()
        view.backgroundColor = ColorApp.ColorPanel.bg
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = ColorApp.ColorBack.bgBorder.cgColor
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 2
        return view
    }()
    
    ///image
    private let switchON_OFF: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "on")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //notificate
    var isChangeswitchON_OFF: Bool = false {
        didSet {
            notificationCenter.post(name: NSNotification.Name(Constants.valueChange),
                                    object: nil,
                                    userInfo: ["isChangeswitchON_OFF" : isChangeswitchON_OFF])
        }
    }
    
    ///textFeild
    private lazy var textFieldNumber: UITextField = {
        let tf = UITextField()
        tf.placeholder = " Введите цифру"
        tf.backgroundColor = .white
        tf.contentMode = .scaleAspectFit
        tf.keyboardType = .decimalPad
        tf.font = FontApp.demiBold(ofSize: 15)
        tf.setContentHuggingPriority(.defaultLow, for: .horizontal)
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 2
        tf.layer.borderColor = ColorApp.ColorBack.bgBorder.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        //Add toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 36))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneBotton = UIBarButtonItem(
            title: "Done",
            style: .plain ,
            target: self,
            action: #selector(doneBattonTap))
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            doneBotton
        ]
        toolbar.isUserInteractionEnabled = true
        tf.inputAccessoryView = toolbar
        return tf
    }()
    ///stack
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [switchON_OFF, textFieldNumber])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        return stack
    }()
    
    ///Combine property
    private let numberTextFieldSubject: PassthroughSubject<Double, Never> = .init()
    var valuePublisher: AnyPublisher<Double, Never> {
        return numberTextFieldSubject.eraseToAnyPublisher()
    }
    
    private let boolSubject: PassthroughSubject<Bool, Never> = .init()
    var boolPublisher: AnyPublisher<Bool, Never> {
        return boolSubject.eraseToAnyPublisher()
    }
    private var cancellable = Set<AnyCancellable>()

    
    init(){
        super.init(frame: .zero)
        layout()
        observe()
        recognizerImage()
        backgroundColor = .clear

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(isChangeswitchON_OFF)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset(){
        textFieldNumber.text = nil
        numberTextFieldSubject.send(0)
    }
    
    private func observe(){
        textFieldNumber.textPublisher.sink {[unowned self] text in
            numberTextFieldSubject.send(text?.doubleValue ?? 0)
            print("text \(String(describing: text))")
        }.store(in: &cancellable)
    }
    
    private func layout(){
        [viewUnberTextField,stack].forEach(addSubview(_:))
        viewUnberTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stack.snp.makeConstraints { make in
            make.leading.equalTo(snp.leadingMargin).offset(10)
            make.trailing.equalTo(snp.trailingMargin).offset(-10)
            make.bottom.equalTo(snp.bottomMargin).offset(-5)
            make.top.equalTo(snp.topMargin).offset(5)
        }
        
        switchON_OFF.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        textFieldNumber.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(250)
        }
    }
    
    //MARK: - Recognizer and tap on image
    private func recognizerImage(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        switchON_OFF.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func didTapImageView(){
        isChangeswitchON_OFF
        ? (switchON_OFF.image = UIImage(named: "on"))
        : (switchON_OFF.image = UIImage(named: "off"))
        
        isChangeswitchON_OFF.toggle()
    }
    
    @objc func doneBattonTap(){
        textFieldNumber.endEditing(true)
    }
}
