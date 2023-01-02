//
//  DMParserMock.swift
//  DoorsManager
//
//  Created by Vitalik Nozhenko on 01.01.2023.
//

import Foundation

struct DMParserMock {
    static func fetchData(_ completion: @escaping(Result<[DMDoorModel], Error>) -> ()) {
        completion(.success(doorsData))
    }
}

let doorsData = [
    DMDoorModel(name: "Front door", place: "Home"),
    DMDoorModel(name: "First door", place: "Office"),
    DMDoorModel(name: "Main door", place: "Garage"),
    DMDoorModel(name: "Second door", place: "Basement")
]
