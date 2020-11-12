//
//  ListModel.swift
//  ListApp
//
//  Created by Satya on 12/11/20.
//  Copyright © 2020 Satya. All rights reserved.
//

import Foundation
enum List
{
    // MARK: Use cases
    
    enum APIList
    {
        struct Request: Encodable
        {
        }
        struct Response: Codable
        {
            var title: String?
            
            var rows: [ViewModel]?
        }
        struct ViewModel: Codable
        {
            var title: String?
            var description: String?
            var imageHref: String?
        }
    }
}
