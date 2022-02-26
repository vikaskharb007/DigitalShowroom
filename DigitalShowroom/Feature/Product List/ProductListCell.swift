//
//  ProductListCell.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import UIKit
import Combine

class ProductListCell: UITableViewCell, RegistrableCellProtocol {
    private var subscriptions = Set<AnyCancellable>()
    
    let containerView: UIView = {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let productImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let productDetailsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        stack.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let vinTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vehicle Vin"
        return label
    }()
    
    let vinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.00)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let licensePlateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cellViewModel: ProductListCellViewModel? {
        didSet {
            publishDetails()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = ProductListCell.defaultIdentifier) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    override func prepareForReuse() {
        vinLabel.text = ""
        licensePlateLabel.text = ""
        productImageview.image = nil
    }
    
    func setupView() {
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        // Product details Stack
        [vinTitle, vinLabel, licensePlateLabel].forEach { detail in
            productDetailsStack.addArrangedSubview(detail)
        }
        
        // Container View
        containerView.addSubview(productImageview)
        containerView.addSubview(productDetailsStack)
        
        contentView.addSubview(containerView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            productImageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            productImageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageview.trailingAnchor.constraint(equalTo: productDetailsStack.leadingAnchor, constant: -10),
            
            productDetailsStack.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            productDetailsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            productDetailsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            productImageview.widthAnchor.constraint(equalToConstant: 100),
            productImageview.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func publishDetails() {
        guard let viewModel = cellViewModel else {
            return
        }
        
        bindViewModel()
        
        vinLabel.text = viewModel.productDetails.vin
        licensePlateLabel.text = "Vehicle Plate - " + viewModel.productDetails.licensePlate
        viewModel.downloadImage(imageURL: viewModel.productDetails.imageURL)
    }
    
    private func bindViewModel() {
        cellViewModel?.$downloadedImage.sink(receiveValue: { image in
            DispatchQueue.main.async {
                self.productImageview.image = image
            }
        }).store(in: &subscriptions)
    }
}
