//
//  CartViewController.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 05.11.2023.
//

import UIKit

class CartViewController: UIViewController {
    
    private let cart = CartService.shared.getCartItems()
    
    let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    private let productTotalPriceLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let delivaryLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.text = "150 тг"
        return label
    }()
    
    private let totalPriceLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let summaLabel : UILabel = {
        let label = UILabel()
        label.text = "Сумма"
        label.textColor = UIColor(red: 172/255, green: 171/255, blue: 173/255, alpha: 1)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let dostavkaLabel : UILabel = {
        let label = UILabel()
        label.text = "Доставка"
        label.textColor = UIColor(red: 172/255, green: 171/255, blue: 173/255, alpha: 1)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let itogoLabel : UILabel = {
        let label = UILabel()
        label.text = "Итого"
        label.textColor = UIColor(red: 172/255, green: 171/255, blue: 173/255, alpha: 1)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let newCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return newCollectionView
    }()
    
    private var bottomButton : UIButton = {
       let button = UIButton()
        button.setTitle("Перейти в магазин", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNavButton), for: .touchUpInside)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let clearLabel : UILabel = {
        let label = UILabel()
        label.text = "Очистить"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(red: 237/255, green: 41/255, blue: 41/255, alpha: 1)
        return label
    }()
    
    private let emptyLabel : UILabel = {
        let label = UILabel()
        label.text = "У вас нет заказа"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(red: 172/255, green: 171/255, blue: 173/255, alpha: 1)
        return label
    }()
    
    private let emptyImageView : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "emptyCart")
        img.contentMode = .scaleToFill
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
        updateTotals()
        checkForEmpty()
    }
    
    private func updateTotals() {
        productTotalPriceLabel.text = "\(CartService.shared.calculateTotalSumma()) тг"
        totalPriceLabel.text = "\(CartService.shared.calculateTotalSumma() + 150) тг"
        checkForEmpty()
    }
    
    private func checkForEmpty() {
        if CartService.shared.getCartItems().isEmpty {
            bottomButton.setTitle("Перейти в магазин", for: .normal)
            [clearLabel, productTotalPriceLabel, delivaryLabel, totalPriceLabel, summaLabel, dostavkaLabel, itogoLabel].forEach { $0.isHidden = true}
            [emptyLabel, emptyImageView].forEach { $0.isHidden = false}
        }
        else {
            bottomButton.setTitle("Оформить заказ", for: .normal)
            [emptyLabel, emptyImageView].forEach { $0.isHidden = true}
            [clearLabel, productTotalPriceLabel, delivaryLabel, totalPriceLabel, summaLabel, dostavkaLabel, itogoLabel].forEach { $0.isHidden = false}
        }
    }
    
    @objc private func handleNavButton() {
        let vc = OrderConfirmationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        navigationItem.title = "Корзина"
        view.isUserInteractionEnabled = true
        [collectionView, bottomButton, clearLabel, productTotalPriceLabel, delivaryLabel, totalPriceLabel, summaLabel, dostavkaLabel, itogoLabel, emptyLabel, emptyImageView].forEach { view.addSubview($0)}
        checkForEmpty()
        navigationItem.backButtonTitle = ""
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: CartCollectionViewCell.identifier)
        updateTotals()
        applyConstraints()
    }
    
    private func applyConstraints() {
        bottomButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(54)
        }
        
        clearLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-32)
            make.left.equalToSuperview().offset(16)
        }
        totalPriceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(bottomButton.snp.top).offset(-20)
        }
        
        delivaryLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(totalPriceLabel.snp.top).offset(-4)
        }
        
        productTotalPriceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(delivaryLabel.snp.top).offset(-4)
        }
        
        itogoLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(bottomButton.snp.top).offset(-20)
        }
        
        dostavkaLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(itogoLabel.snp.top).offset(-4)
        }
        
        summaLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(dostavkaLabel.snp.top).offset(-4)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(summaLabel.snp.top).offset(-8)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(224)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyImageView.snp.bottom).offset(16)
        }
    }
}

extension CartViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CartService.shared.getCartItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionViewCell.identifier, for: indexPath) as? CartCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.product = CartService.shared.getCartItems()[indexPath.row]
        cell.layer.cornerRadius = 12
        cell.productDelegate = self
        cell.addRemoveDelegate = self
        return cell
    }
}


extension CartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left + sectionInsets.right + 11
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth
        return CGSize(width: widthPerItem, height: 94)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

extension CartViewController : DeleteProductDelegate {
    func deleteProductFromCart(_ product: Product) {
        CartService.shared.removeFromCart(item: product)
        updateTotals()
        collectionView.reloadData()
    }
}

extension CartViewController : AddRemoveQuantityDelegate {
    func addQuantity(_ product: Product) {
        updateTotals()
    }
    
    func deleteQuantity(_ product: Product) {
        updateTotals()
    }
}


