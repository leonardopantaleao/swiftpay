//
//  MoneyTransactionsTableViewCell.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 07/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import UIKit

class MoneyTransactionTableViewCell: UITableViewCell {
    
    let transactionIconImage : UIImageView = {
        let image = UIImage(named: Constants.Assets.rowIconMoneyTransfer)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let transactionTitle : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let transactionSubtitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let transactionAmount : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setupLayout()
    }
    
    private func addSubViews(){
        self.contentView.addSubview(transactionIconImage)
        self.contentView.addSubview(transactionTitle)
        self.contentView.addSubview(transactionSubtitle)
        self.contentView.addSubview(transactionAmount)
    }
    
    private func setupLayout(){
        transactionIconImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        transactionIconImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        transactionIconImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        transactionIconImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20).isActive = true
        transactionTitle.topAnchor.constraint(equalTo: transactionIconImage.topAnchor).isActive = true
        transactionTitle.leftAnchor.constraint(equalTo: transactionIconImage.rightAnchor, constant: 20).isActive = true
        transactionSubtitle.topAnchor.constraint(equalTo: transactionTitle.bottomAnchor, constant: 5).isActive = true
        transactionSubtitle.leftAnchor.constraint(equalTo: transactionIconImage.rightAnchor, constant: 20).isActive = true
        transactionAmount.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        transactionAmount.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
