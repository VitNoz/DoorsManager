//
//  DMDoorModel.swift
//  DoorsManager
//
//  Created by Vitalik Nozhenko on 31.12.2022.
//

import Foundation

struct DMDoorModel {
    let name: String
    let place: String
    var state: DMDoorState = .locked
}

enum DMDoorState {
    case locked
    case unlocked
    case unlocking
}

