import UIKit

class HomeTableViewController: UIViewController {

    lazy var customView = HomeTableView()
//    let dataMock =  ["subMenu->1","subMenu->2","subMenu->3","subMenu->4","subMenu->5", "subMenu->1","subMenu->2","subMenu->3","subMenu->4","subMenu->5", "subMenu->1", "subMenu->2", "subMenu->3","subMenu->4","subMenu->5", "subMenu->1","subMenu->2","subMenu->3","subMenu->4","subMenu->5", "subMenu->1","subMenu->2","subMenu->3","subMenu->4","subMenu->5"]
    
    let dataMock =  ["subMenu->1","subMenu->2","subMenu->3"]

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.setDataSource(dataSource: self)
    }
}
extension HomeTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.setText("Cell Data \(dataMock[indexPath.row])")
        return cell
    }
}
