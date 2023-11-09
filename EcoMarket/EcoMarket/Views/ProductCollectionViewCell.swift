//
//  ProductCollectionViewCell.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 06.11.2023.
//

import UIKit
import Kingfisher



class ProductCollectionViewCell: UICollectionViewCell {
    
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
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let addButton : UIButton = {
       let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    
    private let plusButton : UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(plusQuantity), for: .touchUpInside)
        return button
    }()
    
    private let minusButton : UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
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
        self.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        [imageView, titleLabel, priceLabel, addButton, plusButton, minusButton, quantityLabel].forEach { self.addSubview($0) }
        plusButton.isHidden = true
        minusButton.isHidden = true
        quantityLabel.isHidden = true
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.height.equalTo(96)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-4)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.height.equalTo(32)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(addButton.snp.top).offset(-16)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
        }
        
        plusButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-4)
            make.width.equalTo(32)
            make.height.equalTo(32)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        minusButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(4)
            make.width.equalTo(32)
            make.height.equalTo(32)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.left.equalTo(minusButton.snp.right)
            make.right.equalTo(plusButton.snp.left)
            make.centerY.equalTo(plusButton.snp.centerY)
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
}
