//
//  ViewController.swift
//  Star Wars Encyclopedia
//
//  Created by ROMAN VRONSKY on 14.08.2023.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.searchBar.text != nil else {return}
        if searchController.searchBar.text!.count > 2 {
            self.viewModel.getHeroes(searchText: searchController.searchBar.text!) { [weak self] heroes in
                DispatchQueue.main.async {
                    self?.heroesArray.append(contentsOf: heroes)
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    private lazy var backgroundView = UIImageView()
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    private let viewModel: ViewModelProtocol
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    var heroesArray = [Hero]()
    
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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
    }
  
    private func setupView() {
        backgroundView.image = UIImage(named: "stars")
        searchController.searchBar.searchTextField.backgroundColor = .white
        self.view.addSubview(backgroundView)
        self.view.addSubview(collectionView)
        backgroundView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        collectionView.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        })
    }
    
}
extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchListCollectionViewCell.identifier, for: indexPath) as! SearchListCollectionViewCell
        cell.setupHero(heroesArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let width = collectionView.frame.width
        
        return CGSize(width: width, height: 120)
    }
}
