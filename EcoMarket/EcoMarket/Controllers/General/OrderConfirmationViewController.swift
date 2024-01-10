//
//  OrderConfirmationViewController.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 09.11.2023.
//

import UIKit

final class OrderConfirmationViewController: UIViewController {
    
    static var numberTextField = CustomUnderlineTextField()
    
    static var addressTextField = CustomUnderlineTextField()
    
    static var orientirTextField = CustomUnderlineTextField()
    
    static var commentsTextField = CustomUnderlineTextField()
    
    private let totalLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Сумма заказа \(CartService.shared.calculateTotalSumma() + 150) тг"
        label.textColor = .black
        return label
    }()
    
    private var confirmButton : UIButton = {
        let button = UIButton()
        button.setTitle("Заказать доставку", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor.lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.isEnabled = false
        button.addTarget(self, action: #selector(showAlertWithImage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        navigationItem.title = "Оформление заказа"
        [OrderConfirmationViewController.numberTextField, OrderConfirmationViewController.addressTextField, OrderConfirmationViewController.orientirTextField, OrderConfirmationViewController.commentsTextField, totalLabel, confirmButton].forEach { view.addSubview($0) }
        view.backgroundColor = .white
        setupTextFields()
    }
    
    private func setupTextFields() {
        OrderConfirmationViewController.numberTextField.placeh = "Номер телефона"
        OrderConfirmationViewController.numberTextField.keyboardType = .numberPad
        OrderConfirmationViewController.addressTextField.placeh = "Адрес"
        OrderConfirmationViewController.orientirTextField.placeh = "Ориентир"
        OrderConfirmationViewController.commentsTextField.placeh = "Комментарии"
        OrderConfirmationViewController.numberTextField.delegate = self
        OrderConfirmationViewController.addressTextField.delegate = self
        OrderConfirmationViewController.orientirTextField.delegate = self
        OrderConfirmationViewController.commentsTextField.delegate = self
    }
    
    private func setupConstraints() {
        OrderConfirmationViewController.numberTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.right.left.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        OrderConfirmationViewController.addressTextField.snp.makeConstraints {
            $0.top.equalTo(OrderConfirmationViewController.numberTextField.snp.bottom).offset(20)
            $0.right.left.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        OrderConfirmationViewController.orientirTextField.snp.makeConstraints {
            $0.top.equalTo(OrderConfirmationViewController.addressTextField.snp.bottom).offset(20)
            $0.right.left.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        OrderConfirmationViewController.commentsTextField.snp.makeConstraints {
            $0.top.equalTo(OrderConfirmationViewController.orientirTextField.snp.bottom).offset(20)
            $0.right.left.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            $0.right.left.equalToSuperview().inset(16)
            $0.height.equalTo(54)
        }
        
        totalLabel.snp.makeConstraints {
            $0.bottom.equalTo(confirmButton.snp.top).offset(-16)
            $0.centerX.equalTo(confirmButton)
        }
    }
}

extension OrderConfirmationViewController {
    private func updateButtonAppearance() {
        guard let numberText = OrderConfirmationViewController.numberTextField.text, !numberText.isEmpty,
              let addressText = OrderConfirmationViewController.addressTextField.text, !addressText.isEmpty,
              let orientirText = OrderConfirmationViewController.orientirTextField.text, !orientirText.isEmpty,
              let commentsText = OrderConfirmationViewController.commentsTextField.text, !commentsText.isEmpty else {
            confirmButton.backgroundColor = UIColor.lightGray // If any field is empty, set the button to a disabled state
            confirmButton.isEnabled = false
            return
        }
        
        confirmButton.backgroundColor = Colors.shared.green// All fields are filled, enable the button and change its color
        confirmButton.isEnabled = true
    }
    
    @objc private func showAlertWithImage() {
        let controller = CustomAlertControllerViewController()
        present(controller, animated: true , completion: nil)
        clearTextFields()
    }
    
    private func clearTextFields() {
        [OrderConfirmationViewController.numberTextField, OrderConfirmationViewController.addressTextField, OrderConfirmationViewController.orientirTextField, OrderConfirmationViewController.commentsTextField].forEach { $0.text = "" }
    }
}

extension OrderConfirmationViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateButtonAppearance() // Update button appearance on text changes
        return true
    }
}
