import UIKit

class JobDetailsTableViewCell: UITableViewCell {

    let frontView: UIView = {
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
        view.alpha = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    let actionMark: UILabel = {
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

    let topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
            titleLabel.centerYAnchor.constraint(equalTo: frontView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: frontView.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: frontView.rightAnchor, constant: -48)
        ])

        addSubview(actionMark)
        NSLayoutConstraint.activate([
            actionMark.centerYAnchor.constraint(equalTo: frontView.centerYAnchor),
            actionMark.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            actionMark.widthAnchor.constraint(equalToConstant: 36),
            actionMark.heightAnchor.constraint(equalToConstant: 36),
        ])

        insertSubview(topLineView, at: 0)
        NSLayoutConstraint.activate([
            topLineView.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            topLineView.topAnchor.constraint(equalTo: topAnchor),
            topLineView.bottomAnchor.constraint(equalTo: frontView.topAnchor),
            topLineView.widthAnchor.constraint(equalToConstant: 4),
        ])

        insertSubview(bottomLineView, at: 0)
        NSLayoutConstraint.activate([
            bottomLineView.centerXAnchor.constraint(equalTo: frontView.centerXAnchor),
            bottomLineView.topAnchor.constraint(equalTo: frontView.bottomAnchor),
            bottomLineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLineView.widthAnchor.constraint(equalToConstant: 4),
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
