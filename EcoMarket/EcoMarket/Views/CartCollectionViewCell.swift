//
//  CartCollectionViewCell.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 08.11.2023.
//

import UIKit
import Kingfisher

protocol DeleteProductDelegate {
    func deleteProductFromCart(_ product : Product)
}

protocol AddRemoveQuantityDelegate {
    func addQuantity(_ product : Product)
    func deleteQuantity(_ product : Product)
}

class CartCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CartCollectionViewCell"
    
    public var productDelegate: DeleteProductDelegate?
    
    public var addRemoveDelegate : AddRemoveQuantityDelegate?
    
    public var product : Product? {
        didSet {
            updateData()
        }
    }
    
    private let imageView : UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 12
        return img
    }()
    
    private let nameLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(red: 172/255, green: 171/255, blue: 173/255, alpha: 1)
        return label
    }()
    
    private let totalPriceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
        return label
    }()
    
    private let trashView = TrashView()
    
    private let plusButton : UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(handlePlusButton), for: .touchUpInside)
        return button
    }()
    
    private let minusButton : UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(handleMinusButton), for: .touchUpInside)
        return button
    }()
    
    private let quantityLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        [imageView, nameLabel, priceLabel, totalPriceLabel, trashView, plusButton, quantityLabel, minusButton].forEach { self.addSubview($0) }
        trashView.addTarget(self, action: #selector(handleTrashButton), for: .touchUpInside)
        self.isUserInteractionEnabled = true
        applyConstraints()
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
    }
    
    private func applyConstraints() {
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(4)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.width.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(imageView.snp.right).offset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(imageView.snp.right).offset(8)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalTo(imageView.snp.right).offset(8)
        }
        
        trashView.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.left).offset(2)
            make.bottom.equalTo(imageView.snp.bottom).offset(-2)
        }
        
        plusButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.right.equalTo(plusButton.snp.left).offset(-24)
            make.centerY.equalTo(plusButton.snp.centerY)
        }
        
        minusButton.snp.makeConstraints { make in
            make.right.equalTo(quantityLabel.snp.left).offset(-24)
            make.bottom.equalToSuperview().offset(-4)
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setImage(url : String) {
        guard let downloadURL = URL(string: url) else {return}
        let resourse = ImageResource(downloadURL: downloadURL)
        self.imageView.kf.setImage(with: resourse)
    }
    
    private func updateData() {
        guard let product = product else {return}
        nameLabel.text = product.title
        setImage(url: product.image)
        if let price = Double(product.price) {
            totalPriceLabel.text = "\(product.quantity * Int(price)) тг"
            priceLabel.text = "\(Int(price)) тг за шт"
        }
        quantityLabel.text = "\(product.quantity)"
    }
    
    @objc private func handleTrashButton() {
        productDelegate?.deleteProductFromCart(product!)
    }
}

extension CartCollectionViewCell {
    @objc private func handlePlusButton() {
        guard var currentProduct = product else { return }
        if currentProduct.quantity < 50 {
            currentProduct.quantity += 1
            CartService.shared.addQuantity(currentProduct)
            product = currentProduct
            addRemoveDelegate?.addQuantity(currentProduct)
        }
        
    }

    @objc private func handleMinusButton() {
        guard var currentProduct = product else { return }
        if currentProduct.quantity > 1 {
            currentProduct.quantity -= 1
            CartService.shared.minusQuantity(currentProduct)
            product = currentProduct
            addRemoveDelegate?.deleteQuantity(currentProduct)
        }
    }
}
