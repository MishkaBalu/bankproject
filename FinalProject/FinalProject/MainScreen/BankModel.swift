//
//  BankModel.swift
//  FinalProject
//
//  Created by Shkolnyk Leonid on 12/15/18.
//  Copyright © 2018 Shkolnyk Leonid. All rights reserved.
//

import Foundation
import ObjectMapper

struct BankModel: ImmutableMappable {
    
    let id: String
    let orgType: Int
    let title: String
    let regionId: String
    let cityId: String
    let phone: String
    let address: String
    let link: String
    let currencies: [String: Any]
    
    init(map: Map) throws {
        id         = try map.value("id")
        orgType    = try map.value("orgType")
        title      = try map.value("title")
        regionId   = try map.value("regionId")
        cityId     = try map.value("cityId")
        phone      = try map.value("phone")
        address    = try map.value("address")
        link       = try map.value("link")
        currencies = try map.value("currencies")
    }

    
    var formattedUrl: URL? {
        var title = self.title
        let spaceChanger = title.replacingOccurrences(of: " ", with: "+", options: .literal)
        let encodedTexts = spaceChanger.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let url = URL(string: "https://dummyimage.com/100x100/DED8DD/372101&text=" + encodedTexts)
        return url
    }
}
