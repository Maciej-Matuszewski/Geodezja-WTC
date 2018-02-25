import UIKit
import FirebaseAuth

class PhoneLoginViewController: UIViewController {
    var callback: ((User) -> ())?

    private var loginView: PhoneLoginView {
        return view as! PhoneLoginView
    }

    override func loadView() {
        self.view = PhoneLoginView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.phoneNumberView.textField.addTarget(self, action: #selector(phoneNumberTextFieldEditingDidBegin(textField:)), for: UIControlEvents.editingDidBegin)
        loginView.phoneNumberView.button.addTarget(self, action: #selector(phoneNumberButtonAction), for: .touchUpInside)
        loginView.phoneNumberView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backToPhoneNumber)))
        loginView.verificationCodeView.button.addTarget(self, action: #selector(verificationCodeButtonAction), for: .touchUpInside)
        loginView.dissmisButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    }

    @objc private func phoneNumberTextFieldEditingDidBegin(textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            textField.text = "+48"
        }
    }

    @objc private func phoneNumberButtonAction() {
        guard let phoneNumber = loginView.phoneNumberView.textField.text,
            phoneNumber.isValid(withPattern: "^[+][0-9]{11,15}$")
        else {
            loginView.phoneNumberView.setTextFieldAs(valid: false)
            return
        }
        send(phoneNumber: phoneNumber)
    }

    @objc private func backToPhoneNumber() {
        loginView.set(state: .phone)
    }

    private func send(phoneNumber: String) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] (verificationID, error) in
            guard let verificationID = verificationID else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            self?.loginView.set(state: .code)
        }
    }

    @objc private func verificationCodeButtonAction() {
        guard let code = loginView.verificationCodeView.textField.text,
            code.isValid(withPattern: "^[0-9]{6}$")
            else {
                loginView.verificationCodeView.setTextFieldAs(valid: false)
                return
        }
        send(verificationCode: code)
    }

    private func send(verificationCode: String) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            loginView.set(state: .phone)
            return
        }

        view.endEditing(true)
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { [weak self] (user, error) in
            if let error = error {
                print(error)
            }
            guard let user = user else {
                self?.loginView.verificationCodeView.setTextFieldAs(valid: false)
                return
            }
            print("User logged: \(user.phoneNumber ?? " - ")")
            self?.dismiss(animated: true, completion: {
                self?.callback?(user)
            })
        }
    }

    @objc private func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
