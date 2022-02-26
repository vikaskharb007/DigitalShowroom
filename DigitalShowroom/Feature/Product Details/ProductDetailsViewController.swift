//
//  ProductDetailsViewController.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import Combine
import UIKit

class ProductDetailsViewController: UIViewController {
    var viewModel: ProductDetailsViewModel
    private var subscriptions = Set<AnyCancellable>()
    let containerView: UIView = {
        let container = UIView(frame: .zero)
        // container.backgroundColor = .red
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let elementsLockStatusStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        stack.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let licensePlate: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.00)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "pp-645-z"
        return label
    }()
    
    let carStatusRow: LockStatusRow = {
        let row = LockStatusRow(rowTitle: "Car Lock Status")
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()
    
    let frontRightDoorRow: LockStatusRow = {
        let row = LockStatusRow(rowTitle: "Front Right Door")
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()
    
    let frontLeftDoorRow: LockStatusRow = {
        let row = LockStatusRow(rowTitle: "Front Left Door")
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()
    
    let passengerRightDoorRow: LockStatusRow = {
        let row = LockStatusRow(rowTitle: "Passenger Right Door")
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()
    
    let passengerLeftDoorRow: LockStatusRow = {
        let row = LockStatusRow(rowTitle: "Passenger Left Door")
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        addViews()
        addConstraints()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getVehicleDetails()
    }
    
    private func addViews() {
        view.backgroundColor = .white
        [ licensePlate, carStatusRow, frontRightDoorRow, frontLeftDoorRow, passengerRightDoorRow, passengerLeftDoorRow].forEach { element in
            elementsLockStatusStack.addArrangedSubview(element)
        }

        containerView.addSubview(elementsLockStatusStack)
        view.addSubview(containerView)
    }
    
    private func addConstraints() {
        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: guide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            elementsLockStatusStack.topAnchor.constraint(equalTo: containerView.topAnchor),
            elementsLockStatusStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            elementsLockStatusStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func bindViewModel() {
        
        viewModel.$vehicleCompleteDetails.sink(receiveValue: { [weak self] vehichleDetails in
            guard let details = vehichleDetails else {
                return
            }
            
            self?.licensePlate.text = details.licencePlateNumber
            self?.carStatusRow.lockView.isClosed = details.isCarLocked
            self?.frontLeftDoorRow.lockView.isClosed = details.isFrontLeftDoorLocked
            self?.frontRightDoorRow.lockView.isClosed = details.isFrontRightDoorLocked
            self?.passengerLeftDoorRow.lockView.isClosed = details.isPassengerLeftDoorLocked
            self?.passengerRightDoorRow.lockView.isClosed = details.isPassengerRightDoorLocked
            
        }).store(in: &subscriptions)
        
    }
    
    func getVehicleDetails() {
        viewModel.getVehicleDetails()
    }
}
