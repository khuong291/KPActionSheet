//
//  KPActionSheet.swift
//  KPActionSheet
//
//  Created by Khuong Pham on 2/25/17.
//  Copyright © 2017 fantageek. All rights reserved.
//

import UIKit

public class KPActionSheet: UIViewController {
    
    public var menuView: UIView!
    public lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bdView
    }()
    public let menuHeight: CGFloat = 50
    public var items: [KPItem]!
    var isPresenting: Bool = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(items: [KPItem]?) {
        super.init(nibName: nil, bundle: nil)
        
        self.items = items ?? []
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let menuViewHeight = CGFloat(items.count) * menuHeight
        menuView = UIView(frame: CGRect(x: 0, y: view.bounds.height - menuViewHeight, width: view.bounds.width, height: menuViewHeight))
        
        let kpItemView: [KPItemView] = self.items.enumerated().map { t in
            let y = CGFloat(t.offset) * menuHeight
            
            return KPItemView(frame: CGRect(x: 0.0, y: y, width: view.bounds.width, height: menuHeight), item: t.element, onTap: {
                self.dismiss(animated: true, completion: nil)
                t.element.tapHandler?()
            })
        }
        
        kpItemView.forEach() {
            menuView.addSubview($0)
        }
        
        view.addSubview(backdropView)
        view.addSubview(menuView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(KPActionSheet.handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.view === backdropView {
            dismiss(animated: true, completion: nil)
        }
    }
}
// MARK: TransitionDelegate
extension KPActionSheet: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
        
        if isPresenting == true {
            containerView.addSubview(toVC.view)
            
            menuView.frame.origin.y += menuView.frame.height
            backdropView.alpha = 0
            
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y -= self.menuView.frame.height
                self.backdropView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y += self.menuView.frame.height
                self.backdropView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
        
    }
}
