//
//  DMDoorCollectionViewCell.swift
//  DoorsManager
//
//  Created by Vitalik Nozhenko on 31.12.2022.
//

import UIKit
import SnapKit

class DMDoorCollectionViewCell: UICollectionViewCell {
    static let reuseID = "DMDoorCollectionViewCell"
    
    let doorTitleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let doorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    let doorPlaceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = .lightGray
        return label
    }()
    
    let doorStateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let doorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    var door: DMDoorModel? {
        didSet {
            doorNameLabel.text = door?.name
            doorPlaceLabel.text = door?.place
            switch door?.state {
            case .locked:
                doorStateLabel.text = "Locked"
                doorStateLabel.textColor = .blue
                doorTitleImageView.image = UIImage(named: "LockedDoor")
                doorImageView.image = UIImage(named: "LockedImage")
            case .unlocking:
                doorStateLabel.text = "Unlocking..."
                doorStateLabel.textColor = .lightGray
                doorTitleImageView.image = UIImage(named: "UnlockingDoor")
                doorImageView.image = UIImage(named: "UnlockingImage")
            case .unlocked:
                doorStateLabel.text = "Unlocked"
                doorStateLabel.textColor = .systemBlue
                doorTitleImageView.image = UIImage(named: "UnlockedDoor")
                doorImageView.image = UIImage(named: "UnlockedImage")
            case .none:
                return
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(labelTapRecognizer))
        doorStateLabel.addGestureRecognizer(tapGestureRecognizer)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {

        addSubview(doorTitleImageView)
        doorTitleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(30)
            make.height.equalToSuperview().multipliedBy(0.35)
            make.width.equalTo(doorTitleImageView.snp.height)
        }
        
        addSubview(doorNameLabel)
        doorNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalTo(doorTitleImageView.snp.trailing).offset(15)
        }
        
        addSubview(doorPlaceLabel)
        doorPlaceLabel.snp.makeConstraints { make in
            make.top.equalTo(doorNameLabel.snp.bottom)
            make.leading.equalTo(doorTitleImageView.snp.trailing).offset(15)
        }
        
        addSubview(doorImageView)
        doorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(doorTitleImageView.snp.height).multipliedBy(1.1)
            make.width.equalTo(doorTitleImageView.snp.width).multipliedBy(1.1)
        }
        
        addSubview(doorStateLabel)
        doorStateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func labelTapRecognizer() {
        door?.state = .unlocking
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.door?.state = .unlocked
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                self.door?.state = .locked
            }
        }
    }
}
