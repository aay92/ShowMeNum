//
//  ViewNumber.swift
//  ShowMeNum
//
//  Created by Aleksey Alyonin on 22.10.2023.
//

import UIKit

class ViewNumber: UIView {
    
    private let viewScreen: UIView = {
        let view = UIView()
        view.backgroundColor = ColorApp.ColorScreen.screenForNumbers
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = ColorApp.ColorBack.bgBorder.cgColor
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 10
        return view
    }()
    
    private let numberLabel: UILabel = {
        let view = UILabel()
        view.textColor = ColorApp.ColorScreenNumber.colorNumbers.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "0.0"
        view.font = FontApp.bold(ofSize: 110)
        view.layer.shadowColor = ColorApp
            .ColorScreenNumber
            .colorNumbers
            .withAlphaComponent(0.9)
            .cgColor
        view.layer.shadowOffset.height = 5
        view.layer.shadowOffset.width = 5
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        return view
    }()
    
    init(){
        super.init(frame: .zero)
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewScreen.clipsToBounds = true
        viewScreen.addShadow(
            to: [.top,
                .bottom,
                .left,
                .right],
            radius: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(number: ModelNumber){
        numberLabel.text = "\(number.number)"
        countNumber()
   }
    
    func reset(){
        numberLabel.text = "0.0"
//        numberTextFieldSubject.send(0)
    }
    
    private func countNumber(){
        if (numberLabel.text!.count >= 6) {
            self.numberLabel.font = FontApp.bold(ofSize: 55)
        } else {
            self.numberLabel.font = FontApp.bold(ofSize: 110)
        }
    }
    
    private func layout(){
        backgroundColor = .clear
        [viewScreen, numberLabel].forEach(addSubview(_:))
        viewScreen.snp.makeConstraints { make in
            make.leading.equalTo(snp.leadingMargin).offset(10)
            make.trailing.equalTo(snp.trailingMargin).offset(-10)
            make.bottom.equalTo(snp.bottomMargin).offset(-10)
            make.top.equalTo(snp.topMargin).offset(-10)
        }
        
        numberLabel.snp.makeConstraints { make in
            if (numberLabel.text == "0.0") {
                make.top.equalTo(snp.topMargin).offset(16)
                make.bottom.equalTo(snp.bottomMargin).offset(-5)
                make.leading.equalTo(snp.leadingMargin).offset(30)
                make.trailing.equalTo(snp.trailingMargin).offset(-16)
            }
                make.top.equalTo(snp.topMargin).offset(16)
                make.bottom.equalTo(snp.bottomMargin).offset(-5)
                make.leading.equalTo(snp.leadingMargin).offset(113)
                make.trailing.equalTo(snp.trailingMargin).offset(-16)
        }
        
        viewScreen.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
    }
}
