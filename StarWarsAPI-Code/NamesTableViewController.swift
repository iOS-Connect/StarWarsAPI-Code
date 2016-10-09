import UIKit

extension UITableViewCell: CellConfigurable {
    func configure(with text: String) {
        self.textLabel?.text = text
    }
}

class NamesTableViewController: ArrayTableViewController<UITableViewCell> {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Star Wars Names"
        Network.getNames { [weak self] (names) in
            self?.data = names
            self?.tableView.reloadData()
        }
    }
    
}











