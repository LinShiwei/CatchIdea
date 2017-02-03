//
//  GuideViewController.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/7.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    internal var snapshot = UIView()
    internal var containerView = UIView()
    
    private var maskView = UIView()
    private var okButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maskView.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        
        okButton.setTitle(LocalizationStrings.shared.okString, for: .normal)
        okButton.setTitleColor(UIColor.white, for: .normal)
        okButton.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        okButton.backgroundColor = UIColor.clear
        okButton.layer.cornerRadius = 5
        okButton.layer.borderColor = UIColor.white.cgColor
        okButton.layer.borderWidth = 2
        okButton.addTarget(self, action: #selector(tapToDismiss(sender:)), for: .touchUpInside)
        view.backgroundColor = UIColor.clear
        snapshot.alpha = 0
        view.insertSubview(snapshot, at: 0)
        view.addSubview(maskView)
        view.addSubview(containerView)
        view.addSubview(okButton)
    }

    override func viewDidLayoutSubviews() {
        maskView.frame = view.bounds
        containerView.frame = view.bounds
        snapshot.frame = view.bounds
        okButton.center = CGPoint(x: view.frame.width/2, y: view.frame.height-20-okButton.frame.height/2)
    }
    
    @objc private func tapToDismiss(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        snapshot.alpha = 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        snapshot.removeFromSuperview()

    }
}
