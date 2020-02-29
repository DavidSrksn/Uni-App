//
//  Cell.swift
//  Uni
//
//  Created by David Sarkisyan on 20.02.2020.
//  Copyright © 2020 DavidS & that's all. All rights reserved.
//

import UIKit

extension UITableViewCell{
    public func setupSelectedState(labels: [UILabel]){
        let selectedCellview = UIView()
        selectedCellview.backgroundColor = UIColor.TableView.Cell.choosedBackground
        self.selectedBackgroundView = selectedCellview
        
        for label in labels{
            label.textColor = UIColor.TableView.Cell.choosedAttributes
            label.textColor = UIColor.TableView.Cell.choosedAttributes
        }
    }
}
