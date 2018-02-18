import UIKit

class OfferDetailsView: UIView {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 48, right: 0)
        return scrollView
    }()

    let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 0.4
        return view
    }()

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .background
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font =  UIFont.boldSystemFont(ofSize: 34)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let toolbar = UIToolbar()

    let orderButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("ORDER".localized, for: .normal)
        button.backgroundColor = .main
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 20, bottom: 6, right: 20)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: UIFont.buttonFontSize)
        button.layer.cornerRadius = (12 + UIFont.buttonFontSize)/2
        return button
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])

        scrollView.addSubview(shadowView)
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            shadowView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            shadowView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            shadowView.heightAnchor.constraint(equalToConstant: 204)
        ])

        shadowView.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: shadowView.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: shadowView.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        ])

        backgroundImageView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: backgroundImageView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor, multiplier: 0.7, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -8)
        ])

        scrollView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: 16),
            descriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16)
        ])

        toolbar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(toolbar)
        NSLayoutConstraint.activate([
            toolbar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 48)
        ])

        toolbar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: orderButton),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        ], animated: false)

        addSubview(dissmisButton)
        NSLayoutConstraint.activate([
            dissmisButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dissmisButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            dissmisButton.widthAnchor.constraint(equalToConstant: 36),
            dissmisButton.heightAnchor.constraint(equalToConstant: 36),
        ])
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
