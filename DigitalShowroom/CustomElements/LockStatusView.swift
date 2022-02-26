//
//  LockStatusView.swift
//  DigitalShowroom
//
//  Created by Swati Sood on 30/01/2022.
//

import UIKit

class LockStatusView: UIView {
    
    enum LockStatusViewConstants {
       static let defaultOpenImage = UIImage(named: "unlock")
       static let defaultClosedImage = UIImage(named: "lock")
       static let defaultOpenText = "Lock"
       static let defaultClosedText = "Unlock"
    }
    
    let openImage: UIImage?
    let closedImage: UIImage?
    let openText: String
    let closedText: String
    var isClosed: Bool = false {
        didSet {
            updateLockStatusElements()
        }
    }
    
    var onclick: (() -> Void)?
    
    let elementsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        stack.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let lockUnlockButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        
        button.setImage(LockStatusViewConstants.defaultClosedImage, for: .normal)
        return button
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 10, weight: .semibold)
        label.text = LockStatusViewConstants.defaultOpenText
        return label
    }()
    
    init(openImage: UIImage? = LockStatusViewConstants.defaultOpenImage,
         closedImage: UIImage? = LockStatusViewConstants.defaultClosedImage,
         openText: String = LockStatusViewConstants.defaultOpenText,
         closeText: String = LockStatusViewConstants.defaultClosedText,
         onClick: (() -> Void)? = nil) {
        self.openImage = openImage
        self.closedImage = closedImage
        self.openText = openText
        self.closedText = closeText
        self.onclick = onClick
        super.init(frame: .zero)
        
        addViews()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        [lockUnlockButton, statusLabel].forEach { element in
            elementsStack.addArrangedSubview(element)
        }
        
        self.addSubview(elementsStack)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            elementsStack.topAnchor.constraint(equalTo: topAnchor),
            elementsStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            elementsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            elementsStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc func buttonClicked() {
        isClosed.toggle()
        onclick?()
    }
    
    func updateLockStatusElements() {
        let lockStatusImage = isClosed ? closedImage : openImage
        lockUnlockButton.setImage(lockStatusImage, for: .normal)
        
        statusLabel.text = isClosed ? closedText : openText
    }
    
}
