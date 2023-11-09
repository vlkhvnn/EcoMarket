//
//  TrashView.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 08.11.2023.
//

import UIKit

class TrashView : UIButton {
    
    private let trashImageView : UIImageView = {
       let img = UIImageView()
        img.image = UIImage(systemName: "trash")
        img.tintColor = .red
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        self.addSubview(trashImageView)
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
        applyConstraints()
    }
    
    private func applyConstraints() {
        trashImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
