import UIKit

class TransitionIntoOfferDetailsViewController: NSObject, UIViewControllerAnimatedTransitioning {

  let duration = 1.0
  var presenting = true
  var originFrame = CGRect.zero

  var dismissCompletion: (()->Void)?

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    containerView.backgroundColor = .white
    let toView = transitionContext.view(forKey: .to)!
    let fromView = transitionContext.view(forKey: .from)!
    containerView.addSubview(toView)

    guard let offerView = (presenting ? toView : fromView) as? OfferDetailsView else {
        transitionContext.completeTransition(true)
        return
    }
    containerView.bringSubview(toFront: offerView)

    if presenting {
        offerView.backgroundImageView.frame = originFrame
        offerView.descriptionLabel.alpha = 0
        offerView.backgroundImageView.layer.cornerRadius = 16
        offerView.toolbar.alpha = 0
        offerView.dissmisButton.alpha = 0
        offerView.backgroundColor = .clear
    }

    UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
        if self.presenting {
            offerView.backgroundImageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: offerView.frame.width, height: 204))
            offerView.backgroundImageView.layer.cornerRadius = 0
            offerView.descriptionLabel.alpha = 1
            offerView.toolbar.alpha = 1
            offerView.dissmisButton.alpha = 1
            offerView.backgroundColor = .white
        } else {
            offerView.backgroundImageView.frame = CGRect(origin: CGPoint(x: self.originFrame.origin.x, y: self.originFrame.origin.y + offerView.scrollView.contentOffset.y), size: self.originFrame.size)
            offerView.backgroundImageView.layer.cornerRadius = 16
            offerView.descriptionLabel.alpha = 0
            offerView.toolbar.alpha = 0
            offerView.dissmisButton.alpha = 0
            offerView.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        }
    }, completion: { _ in
      if !self.presenting {
        self.dismissCompletion?()
      }
      transitionContext.completeTransition(true)
    })
  }
}
