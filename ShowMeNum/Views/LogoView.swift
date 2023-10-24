//
//  LogoView.swift
//  ShowMeNum
//
//  Created by Aleksey Alyonin on 22.10.2023.
//

import UIKit

class LogoView: UIView {
    
    private let logo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "unnamed")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLogo: UILabel = {
        let title = UILabel()
        title.font = FontApp.bold(ofSize: 20)
        title.text = "Покажи любое число"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logo, titleLogo])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        return stack
    }()
    
    init(){
        super.init(frame: .zero)
        layout()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.widthAnchor.constraint(equalToConstant: 100),

            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }

}
