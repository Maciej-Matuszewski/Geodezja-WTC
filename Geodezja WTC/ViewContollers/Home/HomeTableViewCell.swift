import UIKit

class HomeTableViewCell: UITableViewCell {

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .background
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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        let frontView = UIView()
        frontView.backgroundColor = UIColor.clear
        frontView.layer.cornerRadius = 16
        frontView.translatesAutoresizingMaskIntoConstraints = false
        frontView.layer.shadowOffset = CGSize(width: 0, height: 1)
        frontView.layer.shadowOpacity = 0.4
        addSubview(frontView)
        NSLayoutConstraint.activate([
            frontView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            frontView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            frontView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            frontView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28)
        ])

        frontView.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: frontView.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: frontView.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: frontView.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: frontView.bottomAnchor)
        ])

        backgroundImageView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: backgroundImageView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor, multiplier: 0.7),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: backgroundImageView.bottomAnchor, constant: -8)
        ])
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        backgroundImageView.image = nil
        titleLabel.text = nil
    }
}
