//
//  StarshipsTableViewCell.swift
//  Star Wars Encyclopedia
//
//  Created by Roman Vronsky on 17/08/23.
//

import UIKit
import SnapKit

class StarshipsTableViewCell: UITableViewCell {

    static let identifier = "starshipsCell"
    
    lazy var nameLabel = InfoLabels(inform: "Name", size: 13, weight: .bold, color: .black)
    
    lazy var modelLabel = InfoLabels(inform: "Model", size: 13, weight: .bold, color: .black)
    
    lazy var manufacturerLabel = InfoLabels(inform: "Manufacturer", size: 13, weight: .bold, color: .black)
    
    lazy var passengersLabel = InfoLabels(inform: "Passengers", size: 13, weight: .bold, color: .black)
    
    lazy var nameLabelText = InfoLabels(inform: "", size: 13, weight: .bold, color: .black)
    
    lazy var modelLabelText = InfoLabels(inform: "", size: 13, weight: .bold, color: .black)
    
    lazy var manufacturerLabelText = InfoLabels(inform: "", size: 13, weight: .bold, color: .black)
    
    lazy var passengersLabelText = InfoLabels(inform: "", size: 13, weight: .bold, color: .black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setup(starship: Starships) {
        nameLabelText.text = starship.name ?? ""
        modelLabelText.text = starship.model ?? ""
        manufacturerLabelText.text = starship.manufacturer ?? ""
        passengersLabelText.text = starship.passengers ?? ""
    }
    
    private func setupView() {
        
        self.contentView.backgroundColor = .systemIndigo.withAlphaComponent(0.1)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(modelLabel)
        self.contentView.addSubview(manufacturerLabel)
        self.contentView.addSubview(passengersLabel)
        self.contentView.addSubview(nameLabelText)
        self.contentView.addSubview(modelLabelText)
        self.contentView.addSubview(manufacturerLabelText)
        self.contentView.addSubview(passengersLabelText)
        
        nameLabel.snp.makeConstraints({
            $0.top.left.equalToSuperview().offset(20)
        })
        modelLabel.snp.makeConstraints({
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        })
        
        manufacturerLabel.snp.makeConstraints({
            $0.top.equalTo(self.modelLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        })
        passengersLabel.snp.makeConstraints({
            $0.top.equalTo(self.manufacturerLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        })
        
        nameLabelText.snp.makeConstraints({
            $0.top.right.equalToSuperview().inset(20)
        })
        
        modelLabelText.snp.makeConstraints({
            $0.top.equalTo(self.nameLabelText.snp.bottom).offset(20)
            $0.right.equalToSuperview().inset(20)
        })
        manufacturerLabelText.snp.makeConstraints({
            $0.top.equalTo(self.modelLabelText.snp.bottom).offset(20)
            $0.right.equalToSuperview().inset(20)
        })
        
        passengersLabelText.snp.makeConstraints({
            $0.top.equalTo(self.manufacturerLabelText.snp.bottom).offset(20)
            $0.right.bottom.equalToSuperview().inset(20)
        })
    }
}
