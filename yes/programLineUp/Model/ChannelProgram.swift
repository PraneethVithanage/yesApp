//
//  ChannelProgram.swift
//  yes
//
//  Created by MacBook on 2021-12-13.
//



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let program = try? newJSONDecoder().decode(Program.self, from: jsonData)

import Foundation

// MARK: - ChannelProgram
struct ChannelProgram: Codable {
    let programlist: [Programlist]
    let day: String
}

// MARK: - Programlist
struct Programlist: Codable {
    let channelProgramAutoID, channelProgramID, channelProgramDay: Int
    var channelProgramName, channelProgramStartHour, channelProgramEndHour: String
    let channelProgramType, djID: Int
    let djName, djShowName: String
    let djAddress, djOtherName, djHobbies: JSONNull?
    let averageRating: Int
    let coverImage: String
    let channelProgramDiscription: String
    let djImageURL: String
    let ratingStatus: Bool
    let followingStatus, noOfFollowers: Int
    let noOfFollowersDescription: String
    var isBellClick: Bool = false

    enum CodingKeys: String, CodingKey {
        case channelProgramAutoID, channelProgramID, channelProgramDay, channelProgramName, channelProgramStartHour, channelProgramEndHour, channelProgramType
        case djID = "DjID"
        case djName = "DjName"
        case djShowName = "DjShowName"
        case djAddress = "DjAddress"
        case djOtherName = "DjOtherName"
        case djHobbies = "DjHobbies"
        case averageRating = "AverageRating"
        case coverImage = "CoverImage"
        case channelProgramDiscription = "ChannelProgramDiscription"
        case djImageURL = "DJImageURL"
        case ratingStatus = "RatingStatus"
        case followingStatus = "FollowingStatus"
        case noOfFollowers = "NoOfFollowers"
        case noOfFollowersDescription = "NoOfFollowersDescription"
    }
}

typealias ChannelPrograms = [ChannelProgram]
