//
//  ProductListViewController.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import Foundation
import Combine

import UIKit

class ProductListViewController: UIViewController {
    
    let viewModel: ProductListViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var productListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isOpaque = true
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        viewModel.fetchProducts()
    }
    
    init(viewModel: ProductListViewModel = ProductListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        addViews()
        setConstraints()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        title = "All Vehicles"
        view.addSubview(productListTableView)
        showActivity()
        productListTableView.dataSource = self
        productListTableView.delegate = self
        productListTableView.register(ProductListCell.self)
    }
    
    private func setConstraints() {
        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            productListTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            productListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$finishedLoading.sink { [weak self] _ in
            self?.hideActivity()
            self?.productListTableView.reloadData()
        }.store(in: &subscriptions)

        
        viewModel.$fetchProductsError.sink { [weak self] fetchError in
            guard let error = fetchError else {
                return
            }
            self?.showAlert(for: error)
        }.store(in: &subscriptions)

    }
    
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productDetailsCell = productListTableView.dequeueReusableCell(withIdentifier: ProductListCell.defaultIdentifier, for: indexPath) as? ProductListCell,
            indexPath.row < viewModel.products.count
        else {
            return UITableViewCell()
        }
        productDetailsCell.selectionStyle = .none

        let cellViewModel = ProductListCellViewModel(productData: viewModel.products[indexPath.row])
        productDetailsCell.cellViewModel = cellViewModel
        
        return productDetailsCell
    }
}

extension ProductListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = ProductDetailsViewModel(productData: viewModel.products[indexPath.row])
        let productDetails = ProductDetailsViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(productDetails, animated: true)
        
    }
}
