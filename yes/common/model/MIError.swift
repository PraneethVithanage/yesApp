//
//  MIError.swift
//  yes
//
//  Created by Erandra Jayasundara on 2021-07-12.
//

import Foundation

public struct MIError: Error {
    var status: Int?
    var title: String?
    var message: String
}
