import UIKit

protocol DynamicHeightTableViewDelegate: AnyObject {
    func didSizeChange(size: CGFloat, tableView: UITableView)
}

final class DynamicHeightTableView: UITableView {
    
    public var dynamicHeightDelegate: DynamicHeightTableViewDelegate?
    
    public override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        validateSize()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    func validateSize() {
        dynamicHeightDelegate?.didSizeChange(size: contentSize.height, tableView: self)
    }
}
