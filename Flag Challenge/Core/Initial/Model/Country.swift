//
//  Country.swift
//  Flag Challenge
//
//  Created by Anatoliy Ostapenko on 30.01.2025.
//

import Foundation

struct Country: Identifiable {
    let id = UUID().uuidString
    let step: Int
    let flag: String
    let button: [CountryButton]
    var rightAnswer: String
}

struct CountryButton: Identifiable {
    var id = UUID().uuidString
    let buttonName: String
}

extension Country {
    static let mockCountries: [Country] = [
        .init(
            step: 1,
            flag: "🇺🇦",
            button: [
                .init(buttonName: "Germany"),
                .init(buttonName: "Ukraine")
            ],
            rightAnswer: "Ukraine"
        ),
        .init(
            step: 2,
            flag: "🇺🇸",
            button: [
                .init(buttonName: "Japan"),
                .init(buttonName: "USA")
            ],
            rightAnswer: "USA"
        ),
        .init(
            step: 3,
            flag: "🇯🇵",
            button: [
                .init(buttonName: "Japan"),
                .init(buttonName: "Brazil")
            ],
            rightAnswer: "Japan"
        ),
        .init(
            step: 4,
            flag: "🇩🇪",
            button: [
                .init(buttonName: "USA"),
                .init(buttonName: "Germany")
            ],
            rightAnswer: "Germany"
        ),
        .init(
            step: 5,
            flag: "🇧🇷",
            button: [
                .init(buttonName: "Germany"),
                .init(buttonName: "Brazil")
            ],
            rightAnswer: "Brazil"
        ),
    ]
}
