//
//  IdeaCellManagerDelegate.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/18.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

@objc internal protocol IdeaCellManagerDelegate {
    func deleteIdea(sender: UITableViewCell)
    @objc optional func finishIdea(sender: UITableViewCell)
    @objc optional func restoreIdea(sender: UITableViewCell)
}
