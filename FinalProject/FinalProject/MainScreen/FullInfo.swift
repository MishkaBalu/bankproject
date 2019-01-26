//
//  FullInfo.swift
//  FinalProject
//
//  Created by Shkolnyk Leonid on 12/15/18.
//  Copyright © 2018 Shkolnyk Leonid. All rights reserved.
//

import Foundation
import ObjectMapper

struct FullInfo: ImmutableMappable {
    
    let sourceId: String?
    let date: String?
    let organizations: [BankModel]
    let orgTypes: [String: String]
    let currencies: [String: String]
    let regions: [String: String]
    let cities: [String: String]
    
    init(map: Map) throws {
        sourceId      = try map.value("sourceId")
        date          = try map.value("date")
        organizations = try map.value("organizations")
        orgTypes      = try map.value("orgTypes")
        currencies    = try map.value("currencies")
        regions       = try map.value("regions")
        cities        = try map.value("cities")
    }
    
    func getCityById(_ id: String) -> String {
        return cities[id] ?? "Unknown"
    }
    
    func getRegionById(_ id: String) -> String {
        return regions[id] ?? "Unknown"
    }
}
