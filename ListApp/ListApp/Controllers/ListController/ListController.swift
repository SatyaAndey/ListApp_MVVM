//
//  ListController.swift
//  ListApp
//
//  Created by Satya on 12/11/20.
//  Copyright © 2020 Satya. All rights reserved.
//

import UIKit

class ListController: UIViewController {
    
    var listView: UITableView!
    var lblNodataRepresentation : UILabel!
    var refreshControl = UIRefreshControl()
    var arrListItems = [List.APIList.ViewModel]()
    var dataSource = ListControllerTableViewDataSource()
    var listViewModel = ListControllerViewModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureUITableviewUI()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Utility.sharedInstance.indicatorStartAnimating()
        fetchListItems()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)

    }
    
    func fetchListItems() {
        listViewModel.fetchApiItmsList(List.APIList.Request()) { [weak self]( response) in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                if response?.success == 0 {
                    self?.lblNodataRepresentation.isHidden = false
                    self?.lblNodataRepresentation.text = response?.errorMessage ?? NO_DATA_TEXT
                    self?.dataSource.listItems = [List.APIList.ViewModel]()
                } else {
                    self?.lblNodataRepresentation.isHidden = self?.listViewModel.viewModel.count != 0
                    self?.lblNodataRepresentation.text = response?.errorMessage ?? NO_DATA_TEXT

                    self?.dataSource.listItems = self?.listViewModel.viewModel ?? [List.APIList.ViewModel]()
                }
                self?.navigationItem.title = response?.title ?? NO_DATA_UNKNOWN
                self?.listView.reloadData()
            }
        }
    }

}


// MARK: Screen UI Configuration

/* here devloping screen using code without xib and story boards*/

extension ListController {
    func configureUITableviewUI() {
        listView = UITableView(frame: self.view.bounds)
        listView.dataSource = dataSource
        self.view.addSubview(listView)
        listView.estimatedRowHeight = 3000
        listView.separatorStyle = .singleLine
        listView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        listView.tableFooterView = UIView()
        
        //configure autolayouts
        listView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: listView!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: listView!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: listView!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: listView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        
        listView.reloadData()
        
        //addRefreshControl to listview
        addRefreshControlToListView()
        
        //adding no data label
        configureNodatalabeUI()

        
        //registering tablecell
        listView.register(ListTableViewCell.classForCoder(), forCellReuseIdentifier: "ListTableViewCell")
        
    }
    
    //configure NodatalabeUI
    func configureNodatalabeUI() {
        lblNodataRepresentation = UILabel(frame: CGRect.zero)
        lblNodataRepresentation.numberOfLines = 0
        lblNodataRepresentation.textAlignment = .center
        lblNodataRepresentation.font = UIFont.systemFont(ofSize: FONT_SIZE_TITLE_LABEL)
        lblNodataRepresentation.textColor = .black
        self.view.addSubview(lblNodataRepresentation)
        lblNodataRepresentation.isHidden = true
        lblNodataRepresentation.text = NO_DATA_TEXT
        
        //configure autolayouts
        lblNodataRepresentation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: lblNodataRepresentation!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: lblNodataRepresentation!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: self.view!, attribute: .centerX, relatedBy: .equal, toItem: self.lblNodataRepresentation, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self.view!, attribute: .centerY, relatedBy: .equal, toItem: self.lblNodataRepresentation, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        
        
    }
    
    // adding refresh control to list view
    func addRefreshControlToListView() {
        listView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshListView), for: .valueChanged)
    }
    
    // fetching api items on listview refresh
    @objc func refreshListView() {
        self.fetchListItems()
    }
}

// MARK: Orientation observer
extension ListController {
    @objc func orientationChanged() {
        self.listView.reloadData()
    }
}
