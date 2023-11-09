//
//  CartView.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 08.11.2023.
//

import UIKit

class CartView: UIButton {
    
    private let bagImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bag-03")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .white
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let bagLabel : UILabel = {
       let label = UILabel()
        label.text = "Корзина"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUI() {
        self.backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
        self.layer.cornerRadius = 24
        [bagImageView, bagLabel].forEach { self.addSubview($0) }
        applyConstraints()
    }
    
    private func applyConstraints() {
        bagImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        bagLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(bagImageView.snp.right).offset(6)
        }
    }

}
