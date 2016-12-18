//
//  IdeaCellManagerDelegate.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/18.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal protocol IdeaCellManagerDelegate {
    func deleteIdea(sender: UITableViewCell)
}

extension IdeaCellManagerDelegate {
    func finishIdea(sender: UITableViewCell){
    }
    func restoreIdea(sender: UITableViewCell){
    }
}
