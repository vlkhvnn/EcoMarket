//
//  ProductListViewController.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 05.11.2023.
//

import UIKit

final class ProductListViewController: UIViewController {
    
    private var products = [Product]()
    
    public var category : ProductCategory?
    
    let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    private var productCategories = [ProductCategory]()
    
    private var segmentedControlViews = [CategoryScroll]()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let newCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return newCollectionView
    }()
    
    private let emptyImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bag")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let emptyLabel : UILabel = {
       let label = UILabel()
        label.text = "Ничего не нашли"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = Colors.shared.gray
        return label
    }()
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Быстрый поиск"
        searchBar.layer.cornerRadius = 16
        searchBar.clipsToBounds = true
        searchBar.layer.borderColor = UIColor.clear.cgColor
        searchBar.layer.borderWidth = 1
        return searchBar
    }()
    
    private let scrollView : UIScrollView = {
       let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    private let categoriesView : UIView = {
        let view = UIView()
        return view
    }()
    
    private let scrollStackViewContainer : UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Продукты"
        self.tabBarController?.tabBar.isHidden = true
        view.isUserInteractionEnabled = true
        [searchBar, scrollView, collectionView, emptyImageView, emptyLabel].forEach { view.addSubview($0) }
        emptyImageView.isHidden = true
        emptyLabel.isHidden = true
        searchBar.delegate = self
        setupCollectionView()
        setupScrollView()
        scrollView.addSubview(scrollStackViewContainer)
        getProduct()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            $0.right.left.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview()
            $0.height.equalTo(28)
        }
        
        scrollStackViewContainer.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(760)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(24)
            $0.left.bottom.right.equalToSuperview()
        }
        
        emptyImageView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(74)
            $0.centerX.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupScrollView() {
        APIService.shared.fetchProductCategory { [weak self] apiData in
            self?.productCategories = apiData
            self?.productCategories.sort { $0.id < $1.id }
            let view = CategoryScroll()
            view.productCategory = ProductCategory(id: 0, name: "Все", image: "")
            self?.segmentedControlViews.append(view)
            view.widthAnchor.constraint(equalToConstant: (self?.calculateWidth("Все"))!).isActive = true
            self?.scrollStackViewContainer.addArrangedSubview(view)
            for productCategory in self!.productCategories {
                let view = CategoryScroll()
                view.productCategory = productCategory
                view.widthAnchor.constraint(equalToConstant: (self?.calculateWidth(productCategory.name))!).isActive = true
                self?.segmentedControlViews.append(view)
                self?.scrollStackViewContainer.addArrangedSubview(view)
            }
            self?.configureCustomSegmentedControl()
        }
    }
    
    private func calculateWidth(_ text : String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.sizeToFit() // Adjust label size based on its content
        let labelWidth = label.frame.size.width
        return labelWidth + 24
    }
    
    private func getProduct() {
        APIService.shared.fetchAllProducts() {[weak self] apiData in
            self?.products = apiData
            self?.collectionView.reloadData()
            guard let isEmpty = self?.products.isEmpty else {return}
            if isEmpty {
                self?.emptyImageView.isHidden = false
                self?.emptyLabel.isHidden = false
            } else {
                self?.emptyImageView.isHidden = true
                self?.emptyLabel.isHidden = true
            }
        }
    }
    
    private func getSearchResult(_ text : String) {
        APIService.shared.fetchSearchingProducts(categoryName: category?.name, searchString: text) {[weak self] apiData in
            self?.products = apiData
            self?.collectionView.reloadData()
            guard let isEmpty = self?.products.isEmpty else {return}
            if isEmpty {
                self?.emptyImageView.isHidden = false
                self?.emptyLabel.isHidden = false
            } else {
                self?.emptyImageView.isHidden = true
                self?.emptyLabel.isHidden = true
            }
        }
    }
}

extension ProductListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.product = self.products[indexPath.row]
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bottomsSheetVC = ProductBottomSheetViewController()
        bottomsSheetVC.product = products[indexPath.row]
        bottomsSheetVC.modalPresentationStyle = .currentContext
        if let sheetPresentationController = bottomsSheetVC.presentationController as? UISheetPresentationController {
            sheetPresentationController.detents = [.medium()]
        }
        let navigationController = UINavigationController(rootViewController: bottomsSheetVC)
        
        present(navigationController, animated: true, completion: nil)
    }
}

//MARK: CollectionView Layout

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left + sectionInsets.right + 11
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: widthPerItem + 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
}

extension ProductListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getSearchResult(searchText)
    }
}

//MARK: Custom SegmentController

extension ProductListViewController {
    @objc func handleSegmentedControlButtons(sender: CategoryScroll) {
        for view in segmentedControlViews {
            if view == sender {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) { [weak self] in
                    view.backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
                    view.label.textColor = .white
                    view.layer.borderWidth = 0
                    self?.category = view.productCategory
                    if view.productCategory?.name == "Все" {
                        self?.category = ProductCategory(id: 0, name: "", image: "")
                    }
                    self?.getSearchResult(self?.searchBar.text ?? "")
                }
            } else {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) { [weak self] in
                    view.label.textColor = UIColor(red: 210/255, green: 209/255, blue: 213/255, alpha: 1)
                    view.backgroundColor = .white
                    view.layer.borderWidth = 1
                }
            }
        }
    }
    
    private func configureCustomSegmentedControl() {
        segmentedControlViews.forEach { view in
            view.addTarget(self, action: #selector(handleSegmentedControlButtons(sender:)), for: .touchUpInside)
        }
        segmentedControlViews[0].backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
        segmentedControlViews[0].label.textColor = .white
        segmentedControlViews[0].layer.borderWidth = 0
    }
}
