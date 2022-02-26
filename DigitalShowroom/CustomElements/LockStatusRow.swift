//
//  LockStatusRow.swift
//  DigitalShowroom
//
//  Created by Swati Sood on 30/01/2022.
//

import UIKit

class LockStatusRow: UIView {
    
    let title: String
    
    let rowTitleLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .medium)
        textLabel.textColor = UIColor(red: 0.73, green: 0.23, blue: 0.42, alpha: 1.00)
        return textLabel
    }()
    
    let lockView: LockStatusView = {
        let lockStatusView = LockStatusView()
        lockStatusView.translatesAutoresizingMaskIntoConstraints = false
        return lockStatusView
    }()
    
    let separatorView: UIView = {
        let separatorview = UIView(frame: .zero)
        separatorview.translatesAutoresizingMaskIntoConstraints = false
        separatorview.backgroundColor = .lightGray
        return separatorview
    }()
    
    init(rowTitle: String) {
        self.title = rowTitle

        super.init(frame: .zero)
        
        addViews()
        activateConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        rowTitleLabel.text = title
        addSubview(rowTitleLabel)
        addSubview(lockView)
        addSubview(separatorView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
              heightAnchor.constraint(equalToConstant: 75),
              rowTitleLabel.topAnchor.constraint(equalTo: topAnchor),
              rowTitleLabel.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
              rowTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
              rowTitleLabel.trailingAnchor.constraint(equalTo: lockView.leadingAnchor),
              
              lockView.topAnchor.constraint(equalTo: topAnchor),
              lockView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
              lockView.widthAnchor.constraint(equalToConstant: 40),
              lockView.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
              
              separatorView.heightAnchor.constraint(equalToConstant: 1),
              separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
              separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
              separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
              
          ])
    }
}

class CustomViewElements {
    class func lockStatusRow(rowTitle: String) -> UIView {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .medium)
        textLabel.textColor = UIColor(red: 0.73, green: 0.23, blue: 0.42, alpha: 1.00)
        textLabel.text = rowTitle
        
        let lockStatusView = LockStatusView()
        lockStatusView.translatesAutoresizingMaskIntoConstraints = false
                
        let separatorview = UIView(frame: .zero)
        separatorview.translatesAutoresizingMaskIntoConstraints = false
        separatorview.backgroundColor = .lightGray
    
        containerView.addSubview(textLabel)
        containerView.addSubview(lockStatusView)
        containerView.addSubview(separatorview)
        
        NSLayoutConstraint.activate([
              containerView.heightAnchor.constraint(equalToConstant: 75),
              textLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
              textLabel.bottomAnchor.constraint(equalTo: separatorview.topAnchor),
              textLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
              textLabel.trailingAnchor.constraint(equalTo: lockStatusView.leadingAnchor),
              
              lockStatusView.topAnchor.constraint(equalTo: containerView.topAnchor),
              lockStatusView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
              lockStatusView.widthAnchor.constraint(equalToConstant: 30),
              lockStatusView.bottomAnchor.constraint(equalTo: separatorview.topAnchor),
              
              separatorview.heightAnchor.constraint(equalToConstant: 1),
              separatorview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
              separatorview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 10),
              separatorview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
              
          ])
        
        return containerView
    }
    
    class func seperator() -> UIView {
        let separatorview = UIView(frame: .zero)
        separatorview.translatesAutoresizingMaskIntoConstraints = false
        separatorview.backgroundColor = .lightGray
        
        separatorview.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separatorview
    }
}
