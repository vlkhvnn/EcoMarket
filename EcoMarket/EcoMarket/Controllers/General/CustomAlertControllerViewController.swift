//
//  CustomAlertControllerViewController.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 09.11.2023.
//

import UIKit

final class CustomAlertControllerViewController: UIViewController {
    
    lazy var dimmedBackgroundView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    private let blurEffect : UIBlurEffect = {
        let blur = UIBlurEffect(style: .dark)
        return blur
    }()
    
    private let blurEffectView : UIVisualEffectView = {
       let view = UIVisualEffectView()
        return view
    }()
    
    lazy var customAlert = CustomAlert { [weak self] in
        guard let self = self else {return}
        self.dismiss(animated: true)
        DataPersistanceManager.shared.downloadOrder(Order(order_number: 123, products: CartService.shared.getCartItems()
                                                          , phone_number: OrderConfirmationViewController.numberTextField.text!, address: OrderConfirmationViewController.addressTextField.text!, reference_point: OrderConfirmationViewController.orientirTextField.text!, comments: OrderConfirmationViewController.commentsTextField.text!, total_amount: CartService.shared.calculateTotalSumma(), created_at: Date())) {[] result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurEffectView)
        view.addSubview(customAlert)
        UIView.animate(withDuration: 1000) {
            self.blurEffectView.effect = self.blurEffect
        }
        setupConstraints()
    }
    
    private func setupConstraints() {

        blurEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        customAlert.snp.makeConstraints {
            $0.right.left.equalTo(view.readableContentGuide)
            $0.centerY.equalToSuperview().offset(10)
            $0.height.equalTo(452)
        }
    }
}
