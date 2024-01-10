//
//  OrderViewController.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 10.11.2023.
//

import UIKit

final class OrderViewController: UIViewController {
    
    var order : OrderModel? {
        didSet {
            guard let order = order else {return}
            navigationItem.title = "Заказ №\(order.order_number)"
            priceLabel.text = "\(order.total_amount) тг"
            timeLabel.text = "Оформлен \(order.created_at!.formatted())"
        }
    }
    
    private let greenBackground : UIView = {
        let view = UIView()
        view.backgroundColor = Colors.shared.green
        return view
    }()
    
    private let imageView : UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleToFill
        img.tintColor = .white
        img.image = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
        return img
    }()
    
    private let timeLabel : UILabel = {
        let label = UILabel()
         label.font = .systemFont(ofSize: 16, weight: .bold)
         label.textColor = .white
         return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
         label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
         return label
    }()
    
    private let deliveryLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.text = "Доставка 150 тг"
        return label
    }()
    
    let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let newCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return newCollectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        [imageView, timeLabel, priceLabel, deliveryLabel].forEach { greenBackground.addSubview($0) }
        [greenBackground, collectionView].forEach { view.addSubview($0)}
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OrderProductCollectionViewCell.self, forCellWithReuseIdentifier: OrderProductCollectionViewCell.identifier)
    }
    
    private func setupConstraints() {
        
        greenBackground.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(226)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(24)
            $0.size.equalTo(74)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(12)
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
        }
        deliveryLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-24)
            $0.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(greenBackground.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }
    }
}

extension OrderViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.order?.productsArray.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderProductCollectionViewCell.identifier, for: indexPath) as? OrderProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.product = order?.productsArray[indexPath.row]
        cell.backgroundColor = Colors.shared.lightGray
        cell.layer.cornerRadius = 12
        return cell
    }
}

extension OrderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left + sectionInsets.right
        let availableWidth = collectionView.bounds.width - paddingSpace
        return CGSize(width: availableWidth, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
