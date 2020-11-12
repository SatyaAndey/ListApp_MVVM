//
//  ListTableViewCell.swift
//  ListApp
//
//  Created by Satya on 12/11/20.
//  Copyright © 2020 Satya. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    var imgView: UIImageView!
       var lblTitile: UILabel!
       var lblDescription: UILabel!
       var vwLabelsContainer: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
                super.init(coder: coder)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

     func configureUI() {
            self.selectionStyle  = .none
            configureImageUI()
            configureLabelContainerUI()
            configureTitleLabelUI()
            configureDescriptionLabelUI()
        }
        
        // imageview UI configuration
        func configureImageUI() {
            imgView = UIImageView()
            imgView.backgroundColor = UIColor.clear
            self.contentView.addSubview(imgView)
            imgView.contentMode = .scaleAspectFill
            imgView.clipsToBounds = true
            
            //configure autolayouts for imageview
            imgView.translatesAutoresizingMaskIntoConstraints = false
            let constraintCenterX = imgView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            contentView.addConstraint(constraintCenterX)
            NSLayoutConstraint(item: imgView, attribute: .width, relatedBy: .equal, toItem: imgView, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: imgView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 130).isActive = true
            
            let constraintMaxWidth = NSLayoutConstraint(item: imgView, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 100 / 320, constant: 0)
            constraintMaxWidth.priority = UILayoutPriority(rawValue: 900)
            constraintMaxWidth.isActive = true
            let constraintBottom = NSLayoutConstraint(item: self.contentView, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: self.imgView, attribute: .bottom, multiplier: 1.0, constant: 15)
            constraintBottom.priority = UILayoutPriority(850)
            constraintBottom.isActive = true
            let constraintTop = NSLayoutConstraint(item: imgView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 15)
            constraintTop.priority = UILayoutPriority(rawValue: 850)
            constraintTop.isActive = true
            NSLayoutConstraint(item: imgView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 15).isActive = true
            
            
        }
        
        // labels container view UI configuration
        
        func configureLabelContainerUI() {
            lblTitile = UILabel()
            lblDescription = UILabel()
            vwLabelsContainer = UIView()
            
            self.contentView.addSubview(vwLabelsContainer)
            
            vwLabelsContainer.addSubview(lblTitile)
            vwLabelsContainer.addSubview(lblDescription)
            
            
            //configure autolayouts for labelscontainerview
            vwLabelsContainer.translatesAutoresizingMaskIntoConstraints = false
            let constraintTop = NSLayoutConstraint(item: vwLabelsContainer, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 10)
            constraintTop.priority = UILayoutPriority(850)
            constraintTop.isActive = true
            let constraintBottom = NSLayoutConstraint(item: self.contentView, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: vwLabelsContainer, attribute: .bottom, multiplier: 1.0, constant: 10)
            constraintBottom.priority = UILayoutPriority(850)
            constraintBottom.isActive = true
            
            NSLayoutConstraint(item: vwLabelsContainer!, attribute: .leading, relatedBy: .equal, toItem: self.imgView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: vwLabelsContainer, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: vwLabelsContainer, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        }
        
        // Title Label UI configuration
        
        func configureTitleLabelUI() {
            lblTitile.numberOfLines = 0
            lblTitile.textAlignment = .left
            self.contentView.addSubview(lblTitile)
            lblTitile.textColor = UIColor.black
            lblTitile.font = UIFont.systemFont(ofSize: FONT_SIZE_TITLE_LABEL)
            
            //  configure autolayouts for TitleLabel
            lblTitile.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: lblTitile, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: self.vwLabelsContainer, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: lblTitile!, attribute: .leading, relatedBy: .equal, toItem: vwLabelsContainer, attribute: .leading, multiplier: 1.0, constant: 15).isActive = true
            NSLayoutConstraint(item: vwLabelsContainer, attribute: .trailing, relatedBy: .equal, toItem: lblTitile, attribute: .trailing, multiplier: 1.0, constant: 15).isActive = true
            
        }
        
        // Description label cUI configuration
        
        func configureDescriptionLabelUI() {
            lblDescription.textColor = UIColor.black
            lblDescription.font = UIFont.systemFont(ofSize:FONT_SIZE_DESCRIPTION_LABEL)
            lblDescription.numberOfLines = 0
            lblDescription.textAlignment = .left
            self.contentView.addSubview(lblDescription)
            
            
            //configure autolayouts for DescriptionLabel
            lblDescription.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: lblDescription, attribute: .top, relatedBy: .equal, toItem: self.lblTitile, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
            NSLayoutConstraint(item: lblDescription!, attribute: .leading, relatedBy: .equal, toItem: vwLabelsContainer, attribute: .leading, multiplier: 1.0, constant: 15).isActive = true
            NSLayoutConstraint(item: lblDescription, attribute: .trailing, relatedBy: .equal, toItem: vwLabelsContainer, attribute: .trailing, multiplier: 1.0, constant: -15).isActive = true
            NSLayoutConstraint(item: vwLabelsContainer, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: self.lblDescription, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: lblDescription, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute:.notAnAttribute, multiplier: 1.0, constant: 0).isActive = true
            
            
        }
                
    }

