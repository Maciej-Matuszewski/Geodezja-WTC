import UIKit

class OfficesTableViewCell: UITableViewCell {

    var onMapAction: (()->())?
    var onPhoneAction: (()->())?
    var onMailAction: (()->())?

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font =  UIFont.boldSystemFont(ofSize: 34)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    private let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 0.4
        return view
    }()

    private let frontView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.tintColor = .main
        return toolbar
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        addSubview(shadowView)
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            shadowView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            shadowView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28)
        ])

        shadowView.addSubview(frontView)
        NSLayoutConstraint.activate([
            frontView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            frontView.leftAnchor.constraint(equalTo: shadowView.leftAnchor),
            frontView.rightAnchor.constraint(equalTo: shadowView.rightAnchor),
            frontView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        ])

        frontView.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: frontView.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: frontView.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: frontView.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: frontView.bottomAnchor, constant: -48)
        ])

        backgroundImageView.addSubview(addressLabel)
        NSLayoutConstraint.activate([
            addressLabel.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor, constant: 8),
            addressLabel.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor, multiplier: 0.7),
            addressLabel.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -8)
        ])

        backgroundImageView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: backgroundImageView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor, multiplier: 0.7),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: addressLabel.topAnchor, constant: -2)
        ])

        frontView.addSubview(toolbar)
        NSLayoutConstraint.activate([
            toolbar.bottomAnchor.constraint(equalTo: frontView.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: frontView.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: frontView.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 48)
        ])

        toolbar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(image: #imageLiteral(resourceName: "distance"), style: .plain, target: self, action: #selector(onMapClick)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(image: #imageLiteral(resourceName: "contact"), style: .plain, target: self, action: #selector(onPhoneClick)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(image: #imageLiteral(resourceName: "email"), style: .plain, target: self, action: #selector(onMailClick)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        ], animated: false)
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        backgroundImageView.image = nil
        titleLabel.text = nil
    }

    @objc private func onMapClick() {
        onMapAction?()
    }

    @objc private func onPhoneClick() {
        onPhoneAction?()
    }

    @objc private func onMailClick() {
        onMailAction?()
    }
}
