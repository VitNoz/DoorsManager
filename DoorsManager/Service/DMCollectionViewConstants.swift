//
//  DMCollectionViewConstants.swift
//  DoorsManager
//
//  Created by Vitalik Nozhenko on 31.12.2022.
//

import Foundation
import UIKit

struct DMCollectionViewConstants {
    static let topDistanceToView: CGFloat = 20
    static let leftDistanceToView: CGFloat = 20
    static let rightDistanceToView: CGFloat = 20
    static let bottomDistanceToView: CGFloat = 20
    static let doorCellMinimumInteritemSpacing: CGFloat = 20
    static let doorCellWidth = (UIScreen.main.bounds.width - DMCollectionViewConstants.leftDistanceToView - DMCollectionViewConstants.rightDistanceToView)
    static let doorCellHeight = DMCollectionViewConstants.doorCellWidth / 2.5
}
