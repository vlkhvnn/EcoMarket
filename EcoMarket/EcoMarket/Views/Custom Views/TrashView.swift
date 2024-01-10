//
//  TrashView.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 08.11.2023.
//

import UIKit

final class TrashView : UIButton {
    
    private let trashImageView : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "trash")
        img.tintColor = .red
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.addSubview(trashImageView)
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
    }
    
    private func setupConstraints() {
        trashImageView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview().inset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
