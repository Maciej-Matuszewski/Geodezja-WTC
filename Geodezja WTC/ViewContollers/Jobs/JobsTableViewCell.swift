import UIKit

class JobsTableViewCell: UITableViewCell {

    private let frontView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 0.2
        return view
    }()

    private let progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.alpha = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font =  UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    let actionMark: UIView = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "!"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        return label
    }()

    private var progressViewWidthConstraint: NSLayoutConstraint?

    var progress: CGFloat = 0 {
        didSet{
            layoutIfNeeded()
            progressViewWidthConstraint?.isActive = false
            progressViewWidthConstraint = progressView.widthAnchor.constraint(equalTo: frontView.widthAnchor, multiplier: progress)
            UIView.animate(withDuration: 0.7) {
                self.progressViewWidthConstraint?.isActive = true
                self.layoutIfNeeded()
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        addSubview(frontView)
        NSLayoutConstraint.activate([
            frontView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            frontView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            frontView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            frontView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])

        let progressBackgroundView = UIView()
        progressBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        progressBackgroundView.layer.cornerRadius = 16
        progressBackgroundView.layer.masksToBounds = true

        frontView.addSubview(progressBackgroundView)
        NSLayoutConstraint.activate([
            progressBackgroundView.topAnchor.constraint(equalTo: frontView.topAnchor),
            progressBackgroundView.leftAnchor.constraint(equalTo: frontView.leftAnchor),
            progressBackgroundView.bottomAnchor.constraint(equalTo: frontView.bottomAnchor),
            progressBackgroundView.widthAnchor.constraint(equalTo: frontView.widthAnchor, multiplier: 1.0),
        ])

        progressBackgroundView.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: frontView.topAnchor),
            progressView.leftAnchor.constraint(equalTo: frontView.leftAnchor),
            progressView.bottomAnchor.constraint(equalTo: frontView.bottomAnchor),
        ])

        frontView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: frontView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: frontView.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: frontView.rightAnchor, constant: -48)
        ])

        frontView.addSubview(addressLabel)
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 2),
            addressLabel.leftAnchor.constraint(equalTo: frontView.leftAnchor, constant: 8),
            addressLabel.rightAnchor.constraint(equalTo: frontView.rightAnchor, constant: -48)
        ])

        frontView.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.bottomAnchor.constraint(equalTo: frontView.bottomAnchor, constant: -8),
            statusLabel.leftAnchor.constraint(equalTo: frontView.leftAnchor, constant: 8),
            statusLabel.rightAnchor.constraint(equalTo: frontView.rightAnchor, constant: -48)
        ])

        addSubview(actionMark)
        NSLayoutConstraint.activate([
            actionMark.centerYAnchor.constraint(equalTo: frontView.centerYAnchor),
            actionMark.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            actionMark.widthAnchor.constraint(equalToConstant: 36),
            actionMark.heightAnchor.constraint(equalToConstant: 36),
        ])
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        progressViewWidthConstraint?.isActive = false
        progressViewWidthConstraint = progressView.widthAnchor.constraint(equalTo: frontView.widthAnchor, multiplier: 0.0)
        progressViewWidthConstraint?.isActive = true
        layoutIfNeeded()
    }
}
