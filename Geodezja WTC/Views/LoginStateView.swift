import UIKit

class LoginStateView: UIView {

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in".localized, for: .normal)
        button.setTitleColor(.main, for: .normal)
        button.addTarget(self, action: #selector(onLoginButtonAction), for: .touchUpInside)
        return button
    }()

    var onButtonClick: (() -> ())?

    init(with infoText: String, size: CGSize, onButtonClick: (() -> ())? ) {
        super.init(frame: CGRect(origin: CGPoint.zero, size: size))
        self.onButtonClick = onButtonClick
        infoLabel.text = infoText
        addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            infoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30)
        ])
        addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 8),
            loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onLoginButtonAction() {
        onButtonClick?()
    }

}
