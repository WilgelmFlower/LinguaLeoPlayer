import UIKit

final class MainHeaderView: UIView {

    private let headerView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "tedLasso")

        return image
    }()

    private func coverGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerView)
        coverGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16
        layer.masksToBounds = true
        headerView.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
