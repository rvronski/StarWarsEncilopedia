//
//  FavoritesViewController.swift
//  Star Wars Encyclopedia
//
//  Created by ROMAN VRONSKY on 14.08.2023.
//

import UIKit


class FavoritesViewController: UIViewController {

    private let viewModel: FavoriteViewModelProtocol
    
    private var heroes = [Person]() {
        didSet {
            for i in 0..<heroes.count {
                collectionViewHeight.insert(800, at: i)
            }
            self.collectionView.reloadData()
        }
    }
    
    private var collectionViewHeight = [CGFloat]() {
        didSet {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchListCollectionViewCell.self, forCellWithReuseIdentifier: SearchListCollectionViewCell.identifier)
        return collectionView
    }()
    
    init(viewModel: FavoriteViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.heroes = viewModel.getPerson()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)

        collectionView.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        })
    }
    
}
extension FavoritesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchListCollectionViewCell.identifier, for: indexPath) as! SearchListCollectionViewCell
        cell.setupPerson(heroes[indexPath.row], section: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = self.collectionViewHeight.isEmpty ? 800 : self.collectionViewHeight[indexPath.row]
        
        let width = collectionView.frame.width - 40
        return CGSize(width: width, height: height)
    }
    
}
extension FavoritesViewController: SearchListCollectionViewCellDelegate {
    
    func getTableViewsHeights(height: CGFloat, section: Int) {
        self.collectionViewHeight[section] = height
    }
    
    func deleteFav(index: Int) {
        self.alertOkCancel(title:  "Delete hero?", message: nil) {
            let person = self.heroes[index]
            self.viewModel.deletePerson(person: person)
            self.heroes.remove(at: index)
            self.collectionView.reloadData()
        }
    }
}
