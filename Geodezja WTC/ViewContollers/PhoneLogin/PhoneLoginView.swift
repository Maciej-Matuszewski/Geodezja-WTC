import UIKit

class PhoneLoginView: UIView {

    enum State {
        case phone
        case code
    }

    let phoneNumberView: WTCDialogView = {
        let dialogView = WTCDialogView(title: "Phone number".localized, description: "Please provide phone number for contact and identity verification.".localized, placeholder: "+48XXXXXXXXX", keyboardType: .phonePad)
        return dialogView
    }()

    let verificationCodeView: WTCDialogView = {
        let dialogView = WTCDialogView(title: "Verification code".localized, description: "Please insert verification code received in SMS".localized, placeholder: "••••••", keyboardType: .numberPad)
        dialogView.alpha = 0
        dialogView.isHidden = true
        dialogView.transform = CGAffineTransform(translationX: 0, y: 60)
        return dialogView
    }()

    let dissmisButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("✖︎", for: .normal)
        button.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: UIFont.buttonFontSize)
        button.layer.cornerRadius = 18
        return button
    }()

    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .white
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        addSubview(phoneNumberView)
        NSLayoutConstraint.activate([
            phoneNumberView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80),
            phoneNumberView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            phoneNumberView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])

        addSubview(verificationCodeView)
        NSLayoutConstraint.activate([
            verificationCodeView.topAnchor.constraint(equalTo: phoneNumberView.topAnchor),
            verificationCodeView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            verificationCodeView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])

        addSubview(dissmisButton)
        NSLayoutConstraint.activate([
            dissmisButton.topAnchor.constraint(equalTo: topAnchor, constant: 36),
            dissmisButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            dissmisButton.widthAnchor.constraint(equalToConstant: 36),
            dissmisButton.heightAnchor.constraint(equalToConstant: 36),
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func dismissKeyboard(){
        _ = endEditing(true)
    }

    func set(state: State) {
        switch state {
        case .phone:
            UIView.animate(withDuration: 0.3, animations: {
                self.phoneNumberView.transform = CGAffineTransform.identity
                self.phoneNumberView.alpha = 1.0
                self.verificationCodeView.alpha = 0.0
                self.verificationCodeView.transform = CGAffineTransform(translationX: 0, y: 60)
            }, completion: { _ in
                self.verificationCodeView.isHidden = true
                self.phoneNumberView.textField.becomeFirstResponder()
            })
            return
        case .code:
            verificationCodeView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.phoneNumberView.transform = CGAffineTransform(translationX: 0, y: -60)
                self.phoneNumberView.alpha = 0.4
                self.verificationCodeView.alpha = 1.0
                self.verificationCodeView.transform = CGAffineTransform.identity
            }, completion: { _ in
                self.verificationCodeView.textField.becomeFirstResponder()
            })
            return
        }
    }
}
