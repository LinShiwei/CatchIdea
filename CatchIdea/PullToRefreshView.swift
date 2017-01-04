//
//  PullToRefreshConst.swift
//  PullToRefreshSwift
//
//  Created by Yuji Hato on 12/11/14.
//  Qiulang rewrites it to support pull down & push up
//
import UIKit

open class PullToRefreshView: UIView {
    enum PullToRefreshState {
        case pulling
        case triggered
        case refreshing
        case stop
        case finish
    }
    
    // MARK: Variables
    let contentOffsetKeyPath = "contentOffset"
    var kvoContext = "PullToRefreshKVOContext"
    
    fileprivate var options: PullToRefreshOption
    fileprivate var backgroundView: UIView
    fileprivate var refreshContrainerView: RefreshContainerView
    
//    private var addingIcon: AddingIconView

    fileprivate var scrollViewInsets: UIEdgeInsets = UIEdgeInsets.zero
    fileprivate var refreshCompletion: ((Void) -> Void)?
    
    fileprivate var positionY:CGFloat = 0 {
        didSet {
            if self.positionY == oldValue {
                return
            }
            var frame = self.frame
            frame.origin.y = positionY
            self.frame = frame
        }
    }
    
    var state: PullToRefreshState = PullToRefreshState.pulling {
        didSet {
            if self.state == oldValue {
                return
            }
            switch self.state {
            case .stop:
                stopAnimating()
            case .finish:
                var duration = PullToRefreshConst.animationDuration
                var time = DispatchTime.now() + Double(Int64(duration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    self.stopAnimating()
                }
                duration = duration * 2
                time = DispatchTime.now() + Double(Int64(duration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    self.removeFromSuperview()
                }
            case .refreshing:
                startAnimating()
            case .pulling: //starting point
                arrowRotationBack()
            case .triggered:
                arrowRotation()
            }
        }
    }
    
    // MARK: UIView
    public override convenience init(frame: CGRect) {
        self.init(options: PullToRefreshOption(),frame:frame, refreshCompletion:nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(options: PullToRefreshOption, frame: CGRect, refreshCompletion :((Void) -> Void)?, down:Bool=true) {
        self.options = options
        self.refreshCompletion = refreshCompletion

        self.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.backgroundView.backgroundColor = self.options.backgroundColor
        self.backgroundView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        
        self.refreshContrainerView = RefreshContainerView(frame: CGRect(origin: CGPoint.zero, size: frame.size))
//        self.addingIcon = AddingIconView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))

        
        super.init(frame: frame)
        self.addSubview(backgroundView)
//        self.addSubview(addingIcon)
        self.addSubview(refreshContrainerView)
        self.autoresizingMask = .flexibleWidth
    }
   
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.refreshContrainerView.frame = bounds
//        self.addingIcon.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
    }
    
    open override func willMove(toSuperview superView: UIView!) {
        //superview NOT superView, DO NEED to call the following method
        //superview dealloc will call into this when my own dealloc run later!!
        self.removeRegister()
        guard let scrollView = superView as? UIScrollView else {
            return
        }
        scrollView.addObserver(self, forKeyPath: contentOffsetKeyPath, options: .prior, context: &kvoContext)
    }
    
    fileprivate func removeRegister() {
        if let scrollView = superview as? UIScrollView {
            scrollView.removeObserver(self, forKeyPath: contentOffsetKeyPath, context: &kvoContext)
        }
    }
    
    deinit {
        self.removeRegister()
    }
    
    // MARK: KVO
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let scrollView = object as? UIScrollView else {
            return
        }
        
        guard let _ = change?[NSKeyValueChangeKey.notificationIsPriorKey] else {
            return
        }

        
        if !(context == &kvoContext && keyPath == contentOffsetKeyPath) {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        // Pulling State Check
        let offsetY = scrollView.contentOffset.y
        
        // Alpha set
        if PullToRefreshConst.alpha {
            var alpha = fabs(offsetY) / (self.frame.size.height + 40)
            if alpha > 0.8 {
                alpha = 0.8
            }
//            self.addingIcon.alpha = alpha
            self.refreshContrainerView.alpha = alpha
        }
        
        if offsetY <= 0 {


            if offsetY < -self.frame.size.height {
                // pulling or refreshing
                if scrollView.isDragging == false && self.state != .refreshing && self.state != .stop { //release the finger
                    self.state = .refreshing //startAnimating
                } else if self.state != .refreshing && self.state != .stop { //reach the threshold
                    self.state = .triggered
                }
            } else if self.state == .triggered {
                //starting point, start from pulling
                self.state = .pulling
            }
            return //return for pull down
        }
    }
    
    // MARK: private
    
    fileprivate func startAnimating() {
        guard let _ = superview as? UIScrollView else {
            return
        }

//        UIView.animate(withDuration: PullToRefreshConst.animationDuration,delay: 0,options:[],animations: {
//            },completion: { finished in
//                if finished {
                    self.state = .stop
                    self.refreshCompletion?()
//                }else{
//                    
//                }
//        })
    }
    
    fileprivate func stopAnimating() {
        guard let _ = superview as? UIScrollView else {
            return
        }
        let duration = PullToRefreshConst.animationDuration
        UIView.animate(withDuration: duration,animations: {
//            self.addingIcon.active = false
            self.refreshContrainerView.active = false
        }, completion: { _ in
            self.state = .pulling
        })
    }
    
    fileprivate func arrowRotation() {
        UIView.animate(withDuration: 0.2, delay: 0, options:[], animations: {
            self.refreshContrainerView.active = true
//            self.addingIcon.active = true
        }, completion:nil)
    }
    
    fileprivate func arrowRotationBack() {
        UIView.animate(withDuration: 0.2, animations: {
            self.refreshContrainerView.active = false
//            self.addingIcon.active = false

        })
    }
}
