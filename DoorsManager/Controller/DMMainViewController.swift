//
//  DMMainViewController.swift
//  DoorsManager
//
//  Created by Vitalik Nozhenko on 30.12.2022.
//

import UIKit
import SnapKit

class DMMainViewController: UIViewController {
    
    var doors = [DMDoorModel]()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "InterQR"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .systemBlue
        return label
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .gray
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let welcomeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WelcomeImage")
        return imageView
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "My doors (Loading...)"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    let doorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = DMCollectionViewConstants.doorCellMinimumInteritemSpacing
        layout.itemSize = CGSize(width: DMCollectionViewConstants.doorCellWidth,
                                 height: DMCollectionViewConstants.doorCellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: DMCollectionViewConstants.topDistanceToView,
                                                   left: DMCollectionViewConstants.leftDistanceToView,
                                                   bottom: DMCollectionViewConstants.bottomDistanceToView,
                                                   right: DMCollectionViewConstants.rightDistanceToView)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        setupCollectionView()
        fetchData()
        view.backgroundColor = .white
    }

    private func setupCollectionView() {
        doorsCollectionView.delegate = self
        doorsCollectionView.dataSource = self
        doorsCollectionView.register(DMDoorCollectionViewCell.self,
                                     forCellWithReuseIdentifier: DMDoorCollectionViewCell.reuseID)
    }

    private func fetchData(){
        DMParserMock.fetchData { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self.doors = data
                    self.subtitleLabel.text = "My doors"
                    self.doorsCollectionView.reloadData()
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func makeConstraints() {
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().offset(30)
        }
        
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-30)
            make.width.equalTo(titleLabel.snp.width).multipliedBy(0.5)
            make.height.equalTo(settingsButton.snp.width)
        }
        
        view.addSubview(welcomeImage)
        welcomeImage.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(welcomeImage.snp.width).multipliedBy(0.5)
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeImage.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
        }
        
        view.addSubview(doorsCollectionView)
        doorsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension DMMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = doorsCollectionView.dequeueReusableCell(withReuseIdentifier: DMDoorCollectionViewCell.reuseID, for: indexPath) as! DMDoorCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 20
        cell.door = doors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.doors[indexPath.row].state = .unlocking
        self.doorsCollectionView.reloadData()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                self.doors[indexPath.row].state = .unlocked
                self.doorsCollectionView.reloadData()
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    self.doors[indexPath.row].state = .locked
                    self.doorsCollectionView.reloadData()
            }
        }
    }
}
