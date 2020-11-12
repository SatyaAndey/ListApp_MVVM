//
//  ListControllerViewModel.swift
//  ListApp
//
//  Created by Satya on 12/11/20.
//  Copyright © 2020 Satya. All rights reserved.
//

import UIKit

class ListControllerViewModel: NSObject {
    var viewModel = [List.APIList.ViewModel]()
    var apiResponseCompletionhandler : ((_ respinse: List.APIList.Response?) -> ()) = {_ in }
    
    //Binding API response and UITableview
    func fetchApiItmsList(_ request: List.APIList.Request, response: @escaping ((_ respinse: List.APIList.Response?) -> ())) {
        self.apiResponseCompletionhandler = response
        WebServiceHelper.sharedInstance.fetchListViewItems(request) { [weak self](response) in
            if let vwModel = response?.rows {
                self?.viewModel = vwModel
            } else {
                self?.viewModel = [List.APIList.ViewModel]()
            }
            self?.apiResponseCompletionhandler(response)
        }
    }
    
}
