import UIKit

final class CustomCell: UITableViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        addSubview(label)
        NSLayoutConstraint.activating([
            label.relativeToParent(.top(margin: 10) + .bottom(margin: 10) + .width(margin: 10) + .centerX())
        ])
    }
    
    func setText(_ value: String) {
        label.text = value
    }
}
