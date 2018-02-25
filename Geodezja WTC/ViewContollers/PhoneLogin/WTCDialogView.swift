import UIKit

class WTCDialogView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = .text
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .text
        return label
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .text
        textField.textAlignment = .center
        textField.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textField.addTarget(self, action: #selector(onTextFieldValueChanged), for: .editingChanged)
        return textField
    }()

    let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .text
        return view
    }()

    let button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Accept".localized, for: .normal)
        button.backgroundColor = .main
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 20, bottom: 6, right: 20)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: UIFont.buttonFontSize)
        button.layer.cornerRadius = (12 + UIFont.buttonFontSize)/2
        return button
    }()

    init(title: String, description: String, placeholder: String, keyboardType: UIKeyboardType) {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        layer.cornerRadius = 16
        translatesAutoresizingMaskIntoConstraints = false
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.2

        titleLabel.text = title
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])

        descriptionLabel.text = description
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])

        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])

        textField.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            separator.leftAnchor.constraint(equalTo: textField.leftAnchor),
            separator.rightAnchor.constraint(equalTo: textField.rightAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.6)
        ])

        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 32),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func onTextFieldValueChanged() {
        setTextFieldAs(valid: true)
    }

    func setTextFieldAs(valid: Bool) {
        separator.backgroundColor = valid ? .text : .red
        textField.textColor = valid ? .text : .red
    }
}
