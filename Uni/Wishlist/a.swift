//
//  TableViewCell.swift
//  Uni
//
//  Created by David Sarkisyan on 14.12.2019.
//  Copyright © 2019 DavidS & that's all. All rights reserved.
//

import UIKit

class SortCell: UITableViewCell {

    let choosedView = UIImageView()
    
    var sortTypeLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(index: Int, choosedTypeIndex: Int?){
        setupSortType(index: index)
        setupChoosedView(choosedTypeIndex: choosedTypeIndex, index: index)
    }
    
    func setupSortType(index: Int){
        self.contentView.addSubview(sortTypeLabel)
        self.backgroundColor = UIColor.TableView.Cell.defaultBackground

        sortTypeLabel.textSetup(text: Sort.Occasions.allCases[index].rawValue, textAlignment: .center, textColor: .common)
        sortTypeLabel.fontSetup(name: .regular, thickness: .regular, size: .regular)
        
        sortTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        sortTypeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95).isActive = true
        sortTypeLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.95).isActive = true
        sortTypeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        sortTypeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    
    func setupChoosedView(choosedTypeIndex: Int?, index: Int){
        if  choosedTypeIndex != nil {
            if  index == choosedTypeIndex!{
                self.addSubview(choosedView)
                
                choosedView.translatesAutoresizingMaskIntoConstraints = false
                
                choosedView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
                choosedView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
                choosedView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
                choosedView.widthAnchor.constraint(equalTo: choosedView.heightAnchor).isActive = true
                
                choosedView.backgroundColor = UIColor.TableView.Cell.choosedBackground
                
                choosedView.image = UIImage(systemName: "checkmark")
                choosedView.tintColor = UIColor.TableView.Cell.choosedAttributes
            }else{
                choosedView.image = UIImage(named: "Transparent.jpg")
            }
        }
    }
    
}
