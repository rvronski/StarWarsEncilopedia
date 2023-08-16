//
//  SearchListCollectionViewCell.swift
//  Star Wars Encyclopedia
//
//  Created by Roman Vronsky on 16/08/23.
//

import UIKit
import SnapKit

class SearchListCollectionViewCell: UICollectionViewCell {
    static let identifier = "searchCell"
    
    lazy var nameLabel = InfoLabels(inform: "Name", size: 13, weight: .bold, color: .white)
    
    lazy var genderLabel = InfoLabels(inform: "Gender", size: 13, weight: .bold, color: .white)
    
    lazy var starships = InfoLabels(inform: "Starships", size: 13, weight: .bold, color: .white)
    
    lazy var nameLabelText = InfoLabels(inform: "", size: 13, weight: .bold, color: .white)
    
    lazy var genderLabelText = InfoLabels(inform: "", size: 13, weight: .bold, color: .white)
    
    lazy var starshipsText = InfoLabels(inform: "", size: 13, weight: .bold, color: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupHero(_ hero: Hero) {
        nameLabelText.text = hero.name ?? ""
        genderLabelText.text = hero.gender ?? ""
        starshipsText.text = String(hero.starships?.count ?? 0)
    }
    
    private func setupView() {
        self.layer.cornerRadius = 8
        self.backgroundColor = .systemIndigo
        self.addSubview(nameLabel)
        self.addSubview(genderLabel)
        self.addSubview(starships)
        self.addSubview(nameLabelText)
        self.addSubview(genderLabelText)
        self.addSubview(starshipsText)
        
        nameLabel.snp.makeConstraints({
            $0.top.left.equalToSuperview().offset(20)
        })
        genderLabel.snp.makeConstraints({
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        })
        starships.snp.makeConstraints({
            $0.top.equalTo(self.genderLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        })
        
        nameLabelText.snp.makeConstraints({
            $0.top.right.equalToSuperview().inset(20)
        })
        genderLabelText.snp.makeConstraints({
            $0.top.equalTo(self.nameLabelText.snp.bottom).offset(20)
            $0.right.equalToSuperview().inset(20)
        })
        starshipsText.snp.makeConstraints({
            $0.top.equalTo(self.genderLabelText.snp.bottom).offset(20)
            $0.right.equalToSuperview().inset(20)
        })
    }
}
