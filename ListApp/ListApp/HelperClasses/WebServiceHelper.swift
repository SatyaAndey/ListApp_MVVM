//
//  WebServiceHelper.swift
//  ListApp
//
//  Created by Satya on 12/11/20.
//  Copyright © 2020 Satya. All rights reserved.
//

import UIKit

class WebServiceHelper: NSObject {
  static var sharedInstance = WebServiceHelper()

    func fetchListViewItems(_ request: List.APIList.Request, completionhandler: @escaping(_ response: List.APIList.Response?) -> Void) {
        if !Utility.sharedInstance.isNetworkReachable {
            completionhandler(List.APIList.Response(errorMessage: NO_NETWORK_LABEL_MESSAGE, success: 0, title: ERROR_TITLE_NO_NETWORK, rows: [List.APIList.ViewModel]()))
            Utility.sharedInstance.indicatorStopAnimating()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                Utility.sharedInstance.showNetWorknotAvailableMessage()
                
            }
            return
        }
        if let url = URL(string: BASE_URL) {
            if let request = try? URLRequest(url: url, method: .get) {
                let task = URLSession(configuration: .default).dataTask(with: request) { ( data, response , error) in
                    do {
                        if let dataUnWrapped = data {
                            if let stringResponse =  String(data: dataUnWrapped, encoding: .ascii)  {
                                if let dataLocal = stringResponse.data(using: .utf8) {
                                    var dataModel =  try JSONDecoder().decode( List.APIList.Response.self, from: dataLocal)
                                    if dataModel.rows == nil || dataModel.rows?.count == 0 {
                                        dataModel.errorMessage = NO_RECORDS_FOUND
                                    }
                                    dataModel.success = 1
                                    completionhandler(dataModel)
                                } else {
                                    completionhandler(List.APIList.Response(errorMessage: NO_DATA_UNKNOWN, success: 0, title: NO_DATA_UNKNOWN, rows: [List.APIList.ViewModel]()))
                                }
                                
                            } else {
                                completionhandler(List.APIList.Response(errorMessage: NO_DATA_UNKNOWN, success: 0, title: NO_DATA_UNKNOWN, rows: [List.APIList.ViewModel]()))
                            }
                        } else {
                            if let errorMessage = error?.localizedDescription {
                                completionhandler(List.APIList.Response(errorMessage: errorMessage, success: 0, title: NO_DATA_UNKNOWN, rows: [List.APIList.ViewModel]()))
                            } else {
                                completionhandler(List.APIList.Response(errorMessage: NO_DATA_UNKNOWN, success: 0, title: NO_DATA_UNKNOWN, rows: [List.APIList.ViewModel]()))
                            }
                        }
                        Utility.sharedInstance.indicatorStopAnimating()
                    } catch _ {
                        completionhandler(List.APIList.Response(errorMessage: NO_DATA_UNKNOWN, success: 0, title: NO_DATA_UNKNOWN, rows: [List.APIList.ViewModel]()))
                        Utility.sharedInstance.indicatorStopAnimating()
                    }
                }
                
                task.resume()
            } else {
                completionhandler(nil)
                Utility.sharedInstance.indicatorStopAnimating()
            }
        } else {
            completionhandler(nil)
            Utility.sharedInstance.indicatorStopAnimating()
        }
    }
}
