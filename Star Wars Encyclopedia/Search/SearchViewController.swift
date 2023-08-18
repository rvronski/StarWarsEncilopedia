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
        let searchText = searchController.searchBar.text
        guard let searchText else { return }
        if searchText.count > 1 {
            getHeroes(searchText: searchText)
            isLoding(true)
        }
        if searchText.count == 0 || searchText == "" {
            heroesArray.removeAll()
            self.collectionView.reloadData()
        }
    }
    
    private var collectionViewHeight = [CGFloat]() {
        didSet {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    private lazy var backgroundView = UIImageView()
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let viewModel: SearchViewModelProtocol
    
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    var heroesArray = [HeroModel]() {
        didSet {
            for i in 0..<heroesArray.count {
                collectionViewHeight.insert(800, at: i)
            }
            self.collectionView.reloadData()
        }
     
    }
    
    func isLoding(_ result: Bool) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = !result
            if result {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
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
    
    private func getHeroes(searchText: String) {
        self.viewModel.getHeroes(searchText: searchController.searchBar.text!) { [weak self] heroes in
            let name = heroes.name
            if self!.heroesArray.contains(where: {$0.name == name }) {
                self?.isLoding(false)
                return
            } else {
                let group = DispatchGroup()
                group.enter()
                DispatchQueue.main.async {
                    self?.heroesArray.append(heroes)
                    group.leave()
                }
                group.notify(queue: .main) {
                    self?.isLoding(false)
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
    }
    
    private func setupView() {
        backgroundView.image = UIImage(named: "stars")
        searchController.searchBar.searchTextField.backgroundColor = .white
        activityIndicator.color = .systemIndigo
        self.view.addSubview(backgroundView)
        self.view.addSubview(collectionView)
        self.view.addSubview(activityIndicator)
        
        backgroundView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        collectionView.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        })
        
        activityIndicator.snp.makeConstraints({
            $0.centerY.centerX.equalToSuperview()
        })
    }
    
}
extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchListCollectionViewCell.identifier, for: indexPath) as! SearchListCollectionViewCell
        cell.setupHero(heroesArray[indexPath.row], section: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = self.collectionViewHeight.isEmpty ? 800 : self.collectionViewHeight[indexPath.row]
        
        let width = collectionView.frame.width
        return CGSize(width: width, height: height)
    }
}
extension SearchViewController: SearchListCollectionViewCellDelegate {
    func getTableViewsHeights(height: CGFloat, section: Int) {
        self.collectionViewHeight[section] = height
    }
    
    func didTapFavButton(index: Int) {
        let hero = self.heroesArray[index]
        viewModel.getFavorite(hero: hero)
    }
}
