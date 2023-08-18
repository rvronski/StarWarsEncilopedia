//
//  SearchListCollectionViewCell.swift
//  Star Wars Encyclopedia
//
//  Created by Roman Vronsky on 16/08/23.
//

import UIKit
import SnapKit

@objc protocol SearchListCollectionViewCellDelegate {
    @objc optional func getTableViewsHeights(height: CGFloat, section: Int)
    @objc optional func didTapFavButton(index: Int)
    @objc optional func deleteFav(index: Int)
}

class SearchListCollectionViewCell: UICollectionViewCell {
    static let identifier = "searchCell"
    
    lazy var nameLabel = InfoLabels(inform: "Name", size: 13, weight: .bold, color: .white)
    
    lazy var genderLabel = InfoLabels(inform: "Gender", size: 13, weight: .bold, color: .white)
    
    lazy var starshipsLabel = InfoLabels(inform: "Starships", size: 13, weight: .bold, color: .white)
    
    lazy var nameLabelText = InfoLabels(inform: "", size: 13, weight: .bold, color: .white)
    
    lazy var genderLabelText = InfoLabels(inform: "", size: 13, weight: .bold, color: .white)
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.addTarget(self, action: #selector(didTapFavButton), for: .touchUpInside)
        button.tintColor = .systemYellow
        return button
    }()
    
    var starShipsArray = [Starships]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var starTransportArray = [StarTransport]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var delegate: SearchListCollectionViewCellDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 30
        tableView.layer.cornerRadius = 8
        tableView.isScrollEnabled = false
        tableView.register(StarshipsTableViewCell.self, forCellReuseIdentifier: StarshipsTableViewCell.identifier)
        tableView.backgroundColor = .systemIndigo.withAlphaComponent(0.1)
        return tableView
    }()
    
    var isFavorite = false
    
    var height = CGFloat(0)
    var section = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupHero(_ hero: HeroModel, section: Int) {
        
        isFavorite = false
        self.section = section
        nameLabelText.text = hero.name ?? ""
        genderLabelText.text = hero.gender ?? ""
        self.starShipsArray = hero.starships ?? []
    }
    
    func setupPerson(_ hero: Person, section: Int) {
        favoriteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        favoriteButton.tintColor = .systemRed
        isFavorite = true
        self.section = section
        nameLabelText.text = hero.name ?? ""
        genderLabelText.text = hero.gender ?? ""
        self.starTransportArray = hero.starship?.allObjects as! [StarTransport]
    }
    
    private func setupView() {
        self.layer.cornerRadius = 8
        self.backgroundColor = .systemIndigo.withAlphaComponent(0.3)
        self.addSubview(nameLabel)
        self.addSubview(genderLabel)
        self.addSubview(starshipsLabel)
        self.addSubview(nameLabelText)
        self.addSubview(genderLabelText)
        self.addSubview(favoriteButton)
        self.addSubview(tableView)
        
        nameLabel.snp.makeConstraints({
            $0.top.left.equalToSuperview().offset(20)
        })
        genderLabel.snp.makeConstraints({
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        })
        
        nameLabelText.snp.makeConstraints({
            $0.top.right.equalToSuperview().inset(20)
        })
        genderLabelText.snp.makeConstraints({
            $0.top.equalTo(self.nameLabelText.snp.bottom).offset(20)
            $0.right.equalToSuperview().inset(20)
        })
        favoriteButton.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(60)
        })
        starshipsLabel.snp.makeConstraints({
            $0.top.equalTo(self.genderLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        })
        tableView.snp.makeConstraints({
            $0.top.equalTo(self.starshipsLabel.snp.bottom).offset(20)
            $0.left.right.bottom.equalToSuperview().inset(20)
        })
    }
    
    @objc private func didTapFavButton() {
        if isFavorite {
            delegate?.deleteFav?(index: self.section)
        } else {
            delegate?.didTapFavButton?(index: self.section)
        }
    }
}
extension SearchListCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isFavorite ? starTransportArray.count : starShipsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let height = cell.contentView.frame.height
        self.height += height
        if indexPath.section == (starShipsArray.count - 1) || indexPath.section == (starTransportArray.count - 1) {
            let h = self.height + nameLabel.intrinsicContentSize.height + genderLabel.intrinsicContentSize.height + starshipsLabel.intrinsicContentSize.height + 100
            self.delegate?.getTableViewsHeights?(height: h, section: section)
            self.height = 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StarshipsTableViewCell.identifier, for: indexPath) as! StarshipsTableViewCell
        if isFavorite {
            cell.setup(starTransport: starTransportArray[indexPath.section])
        } else {
            cell.setup(starship: starShipsArray[indexPath.section])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
