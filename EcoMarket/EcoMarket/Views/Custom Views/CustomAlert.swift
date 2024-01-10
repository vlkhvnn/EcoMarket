//
//  CustomAlert.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 09.11.2023.
//

import UIKit

final class CustomAlert: UIView {
    
    private let imageView : UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "bagHappy")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let orderNumber : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Заказ №343565657 оформлен"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let dateAndTimeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Colors.shared.gray
        label.text = "Дата и время \(Date().formatted())"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var goToShoppingButton : UIButton = {
        let button = UIButton()
        button.setTitle("Перейти в магазин", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = Colors.shared.green
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        return button
    }()
    
    var exitController: (() -> ())
    
    init(exitButton: @escaping (() -> ())) {
        self.exitController = exitButton
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 16
        [imageView, orderNumber, dateAndTimeLabel, goToShoppingButton].forEach { self.addSubview($0)}
        goToShoppingButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        goToShoppingButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-24)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(54)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200)
            $0.width.equalTo(163)
        }
        
        orderNumber.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        dateAndTimeLabel.snp.makeConstraints {
            $0.top.equalTo(orderNumber.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16)
        }
    }
}

//MARK: Button functionality
extension CustomAlert {
    @objc private func didTapBack() {
        exitController()
        CartService.shared.clearCart()
        if let window = UIApplication.shared.keyWindow {
            if let rootViewController = window.rootViewController {
                // Check if the root view controller is a tab bar controller
                if let tabBarController = rootViewController as? MainTabBarController {
                    // Switch to the MainTabBarController
                    tabBarController.selectedIndex = 0 // Change the index as needed to navigate to the desired tab
                }
            }
        }
    }
}
