import UIKit

class TestView: UIView {
    
    private var tableViewHeightConstraint: NSLayoutConstraint?
    
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
    
    private lazy var simulatorTableView: DynamicHeightTableView = {
        let tableView = DynamicHeightTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none
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
        addSubview(simulatorTableView)
        NSLayoutConstraint.activating([
            simulatorTableView.relativeToParent(.width(margin: 30)),
            simulatorTableView.relativeTo(topView, positioned: .below(spacing: 10))
        ])
        
        tableViewHeightConstraint = simulatorTableView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    private func setUpBottomViewConstraints() {
        addSubview(bottomView)
        NSLayoutConstraint.activating([
            bottomView.relativeTo(self, positioned: .safeBottom() + .constantHeight(50) + .constantWidth(50) + .centerX())
        ])
    }
    
    func setDataSource(dataSource: UITableViewDataSource) {
        simulatorTableView.dataSource = dataSource
    }
    
    func validateHeightTableView() {
        if simulatorTableView.frame.maxY > bottomView.frame.minY {
            simulatorTableView.relativeTo(bottomView, positioned: .above(spacing: 10)).first?.isActive = true
            print("BIGGER")
        }
    }
}
