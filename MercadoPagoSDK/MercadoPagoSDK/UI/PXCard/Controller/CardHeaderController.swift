import UIKit

class CardHeaderController: UIViewController {
    private var shouldAnimate: Bool = true
    let cardFont = "RobotoMono-Regular"
    var frontView = FrontView()
    var backView = BackView()

    var cardUI: CardUI {
        willSet(value) {
            if shouldAnimate {
                frontView.setupAnimated(value)
            } else {
                frontView.setupUI(value)
            }
            backView.setupUI(value)
        }
    }

    init(_ cardUI: CardUI, _ model: CardData) {
        self.cardUI = cardUI
        UIFont.registerFont(fontName: cardFont, fontExtension: "ttf")
        super.init(nibName: nil, bundle: nil)
        backView.setup(cardUI, model, view.frame)
        frontView.setup(cardUI, model, view.frame)
    }

    func show() {
        transition(from: backView, to: frontView, .transitionFlipFromRight)
    }

    func showSecurityCode() {
        guard cardUI.securityCodeLocation == .back else {
            addSubview(frontView)
            frontView.showSecurityCode()
            return
        }
        transition(from: frontView, to: backView, .transitionFlipFromLeft)
    }

    func animated(_ animated: Bool) {
        shouldAnimate = animated
    }

    func transition(from origin: UIView, to destination: UIView, _ options: UIViewAnimationOptions) {
        addSubview(destination)
        Animator.flip(origin, destination, options)
    }

    func addSubview(_ subview: UIView) {
        subview.frame = CGRect(origin: CGPoint.zero, size: view.frame.size)
        view.addSubview(subview)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
