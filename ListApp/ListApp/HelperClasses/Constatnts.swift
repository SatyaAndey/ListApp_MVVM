//
//  Constatnts.swift
//  ListApp
//
//  Created by Satya on 12/11/20.
//  Copyright © 2020 Satya. All rights reserved.
//

import Foundation
import Foundation
import UIKit

let BASE_URL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
let MAX_WIDTH = UIScreen.main.bounds.width <= 375 ? UIScreen.main.bounds.width : 375
let FONT_SIZE_TITLE_LABEL = 15 / 320 * MAX_WIDTH
let FONT_SIZE_DESCRIPTION_LABEL = 13 / 320 * MAX_WIDTH
let NO_DATA_TEXT = "Something went wrong, drag down to refresh!"
let NO_NETWORK_MESSAGE = "You are showing offline, please check your network!"
