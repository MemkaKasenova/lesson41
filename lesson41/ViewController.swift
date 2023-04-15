//
//  ViewController.swift
//  lesson41
//
//  Created by merim kasenova on 8/4/23.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    var productAmount = 0
    
    private var products: [Product] =
                          [Product(name: "Pepperoni", price: "400", image: "1"),
                           Product(name: "Burger", price: "250", image: "2"),
                           Product(name: "Hotdog", price: "200", image: "3")]

    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.minimumInteritemSpacing = 20
//        layout.itemSize = CGSize(width: 250, height: 100)
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemBlue
        view.showsVerticalScrollIndicator = false
        view.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseId)
        view.dataSource = self
        view.delegate = self
        return view
    }()

    lazy var basketButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "basket.fill"), for: .normal)
        view.backgroundColor = .systemRed
        view.setTitleColor(.white, for: .normal)
        view.tintColor = .white
        view.setTitle("\(productAmount)", for: .normal)
        view.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupSubviews()
    }
    
    @objc func basketButtonTap() {
    goToNextPage()
    }
    
    func addProduct() {
        productAmount += 1
        basketButton.setTitle("\(productAmount)", for: .normal)
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {make in
            make.top.left.right.bottom.equalToSuperview()
            
        }
        view.addSubview(basketButton)
        basketButton.snp.makeConstraints {make in
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(70)
            make.centerX.equalToSuperview()
        }
    }
    }


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
        }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
        collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseId, for: indexPath) as! CustomCell
        cell.fill(product: products[indexPath.row])
        cell.indexPath = indexPath
        cell.delegate = self
        print(indexPath)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width - 30, height: 200)
//        }else {
//            return CGSize(width: 300, height: 200)
//        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(), animated: false)
    }
}

extension ViewController: CellActions {
    func didProductChose(index: Int) {
        productAmount += 1
        basketButton.setTitle("\(productAmount)", for: .normal)
    }
    
    
    @objc func goToNextPage(){
        let vc = SecondViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
}


