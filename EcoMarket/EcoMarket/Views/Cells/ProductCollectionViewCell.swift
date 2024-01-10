//
//  ProductCollectionViewCell.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 06.11.2023.
//

import UIKit
import Kingfisher

final class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProductCollectionViewCell"
    
    public var product : Product? {
        didSet {
            guard let product = product else {return}
            titleLabel.text = product.title
            setImage(url: product.image)
            if let price = Double(product.price) {
                priceLabel.text = "\(Int(price)) тг"
            }
            if CartService.shared.isProductInCart(product: product) {
                addButton.isHidden = true
                plusButton.isHidden = false
                minusButton.isHidden = false
                quantityLabel.isHidden = false
            } else {
                addButton.isHidden = false
                plusButton.isHidden = true
                minusButton.isHidden = true
                quantityLabel.isHidden = true
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
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = Colors.shared.green
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let addButton : UIButton = {
       let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.shared.green
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    
    private let plusButton : UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = Colors.shared.green
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(plusQuantity), for: .touchUpInside)
        return button
    }()
    
    private let minusButton : UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.backgroundColor = Colors.shared.green
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(minusQuantity), for: .touchUpInside)
        return button
    }()
    
    private let quantityLabel : UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        self.backgroundColor = Colors.shared.lightGray
        [imageView, titleLabel, priceLabel, addButton, plusButton, minusButton, quantityLabel].forEach { self.addSubview($0) }
        plusButton.isHidden = true
        minusButton.isHidden = true
        quantityLabel.isHidden = true
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        imageView.snp.makeConstraints {
            $0.top.right.left.equalToSuperview().inset(4)
            $0.height.equalTo(96)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(4)
            $0.top.equalTo(imageView.snp.bottom).offset(4)
        }
        
        addButton.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview().inset(4)
            $0.height.equalTo(32)
        }
        
        priceLabel.snp.makeConstraints {
            $0.bottom.equalTo(addButton.snp.top).offset(-16)
            $0.left.right.equalToSuperview().inset(4)
        }
        
        plusButton.snp.makeConstraints {
            $0.right.bottom.equalToSuperview().inset(4)
            $0.size.equalTo(32)
        }
        
        minusButton.snp.makeConstraints {
            $0.left.bottom.equalToSuperview().inset(4)
            $0.size.equalTo(32)
        }
        
        quantityLabel.snp.makeConstraints {
            $0.left.equalTo(minusButton.snp.right)
            $0.right.equalTo(plusButton.snp.left)
            $0.centerY.equalTo(plusButton)
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

//MARK: Button functionalities
extension ProductCollectionViewCell {
    
    @objc
    private func minusQuantity() {
        if product!.quantity <= 1 {
            CartService.shared.removeFromCart(item: product!)
            addButton.isHidden = false
            plusButton.isHidden = true
            minusButton.isHidden = true
            quantityLabel.isHidden = true
            return
        }
        if CartService.shared.isProductInCart(product: product!) {
            CartService.shared.minusQuantity(product!)
        }
        product?.quantity -= 1
        quantityLabel.text = String(product!.quantity)
    }
    
    @objc
    private func handleButton() {
        addButton.isHidden = true
        plusButton.isHidden = false
        minusButton.isHidden = false
        quantityLabel.isHidden = false
        CartService.shared.addToCart(item: product!)
    }
    
    @objc
    private func plusQuantity() {
        if product!.quantity >= 50 {
            return
        }
        if CartService.shared.isProductInCart(product: product!) {
            CartService.shared.addQuantity(product!)
        }
        product?.quantity += 1
        quantityLabel.text = String(product!.quantity)
    }
}
