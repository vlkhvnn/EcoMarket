//
//  OrderProductCollectionViewCell.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 10.11.2023.
//

import UIKit
import Kingfisher

final class OrderProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OrderProductCollectionViewCell"
    
    public var product : Product? {
        didSet {
            guard let product = product else {return}
            titleLabel.text = product.title
            setImage(url: product.image)
            if let price = Double(product.price) {
                priceLabel.text = "Цена \(Int(price)) тг за шт"
                totalLabel.text = "\(Int(price) * product.quantity) тг"
            }
        }
    }
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let titleLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(red: 210/255, green: 209/255, blue: 213/255, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let quantityLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(red: 210/255, green: 209/255, blue: 213/255, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let totalLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = Colors.shared.green
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.backgroundColor = Colors.shared.lightGray
        [imageView, titleLabel, priceLabel, quantityLabel, totalLabel].forEach { self.addSubview($0) }
    }
    
    private func setupConstraints() {
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.left.equalToSuperview().offset(12)
            $0.size.equalTo(43)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.left.equalTo(imageView.snp.right).offset(8)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalTo(imageView.snp.right).offset(8)
        }
        
        totalLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(17)
            $0.right.equalToSuperview().offset(-12)
        }
        
        quantityLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-12)
            $0.top.equalTo(totalLabel.snp.bottom).offset(9)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setImage(url : String) {
        guard let downloadURL = URL(string: url) else {return}
        let resourse = ImageResource(downloadURL: downloadURL)
        self.imageView.kf.setImage(with: resourse)
    }
}
