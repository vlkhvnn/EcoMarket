//
//  CustomInfo.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 10.11.2023.
//

import UIKit

final class CustomInfo: UIView {
    
    var text : String {
        didSet {
            textLabel.text = text
        }
    }
    
    var imageName : String {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    private let imageView : UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleToFill
        return img
    }()
    
    private var stackView : UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var textLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        imageName = ""
        text = ""
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.addSubview(imageView)
        self.addSubview(textLabel)
        self.backgroundColor = Colors.shared.lightGray
        self.layer.cornerRadius = 16
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        
        textLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(textLabel.snp.left).offset(-8)
            $0.width.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
