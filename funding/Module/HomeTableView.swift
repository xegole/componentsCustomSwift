import UIKit

class HomeTableView: UIView {
    
    private lazy var topView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentTableView: DynamicHeightTableView = {
        let tableView = DynamicHeightTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.dynamicHeightDelegate = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        backgroundColor = .blue
        setUpTopViewConstraints()
        setUpBottomViewConstraints()
        setUpTableViewConstraints()    }
    
    private func setUpTopViewConstraints() {
        addSubview(topView)
        NSLayoutConstraint.activating([
            topView.relativeTo(self, positioned: .safeTop(margin: 50) + .constantHeight(50) + .constantWidth(50) + .centerX())
        ])
    }
    
    private func setUpTableViewConstraints() {
        addSubview(contentTableView)
        NSLayoutConstraint.activating([
            contentTableView.relativeToParent(.width(margin: 30)),
            contentTableView.relativeTo(topView, positioned: .below(spacing: 10))
        ])
    }
    
    private func setUpBottomViewConstraints() {
        addSubview(bottomView)
        NSLayoutConstraint.activating([
            bottomView.relativeTo(self, positioned: .safeBottom() + .constantHeight(50) + .constantWidth(50) + .centerX())
        ])
    }
    
    func setDataSource(dataSource: UITableViewDataSource) {
        contentTableView.dataSource = dataSource
    }
}

extension HomeTableView: DynamicHeightTableViewDelegate {
    
    func didSizeChange(size: CGFloat, tableView: UITableView) {
        let bottomMaxY = size + tableView.frame.minY
        let bottomViewMinY = bottomView.frame.minY
        if bottomMaxY > bottomViewMinY, bottomViewMinY != 0.0 {
            contentTableView.relativeTo(bottomView, positioned: .above(spacing: 10)).first?.isActive = true
        }
    }
}
