//
//  CustomCell.swift
//  lesson41
//
//  Created by merim kasenova on 8/4/23.
//

import Foundation
import UIKit
import SnapKit


protocol CellActions: AnyObject {
    func didProductChose(index: Int)
}

class CustomCell: UICollectionViewCell {
   
    weak var delegate: CellActions?
    
    var indexPath: IndexPath?
    
    static let reuseId = "custom_cell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart")
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Title"
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.text = "discription"
        return view
    }()
    
       private lazy var button:UIButton = {
            let view = UIButton(type: .system)
            view.setTitle("+", for: .normal)
            view.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            view.setTitleColor(.white, for: .normal)
            view.backgroundColor = .blue
           view.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
            return view
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder:NSCoder) {
        fatalError()
    }
    
    @objc func addButtonTap() {
        delegate?.didProductChose(index: indexPath!.row)
        
    }
    
    func fill(product: Product) {
        imageView.image = UIImage(named: product.image)
        titleLabel.text = product.name
        descriptionLabel.text = product.price
    }
    
    private func setupSubviews() {
        addSubview(imageView)
        imageView.snp.makeConstraints {make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.left.equalTo(imageView.snp.right).offset(20)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(20)
        }
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {make in
            make.left.equalTo(imageView.snp.right).offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-50)
        }
        addSubview(button)
        button.snp.makeConstraints {make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.height.width.equalTo(44)
        }
    }
}
