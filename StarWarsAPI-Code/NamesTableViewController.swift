import UIKit

extension UITableViewCell: CellConfigurable {
    func configure(with text: String) {
        self.textLabel?.text = text
    }
}

class NamesTableViewController: ArrayTableViewController<UITableViewCell> {
    var tableSegments = ["Names", "Spaceships"]
    override func viewDidLoad() {       
        super.viewDidLoad()
        title = "Star Wars Names"
        Network.getNames { [weak self] (names) in
        self?.data = names
        self?.tableView.reloadData()
        }
        let segmentControl = UISegmentedControl(items: tableSegments)
        segmentControl.addTarget(self, action: #selector(NamesTableViewController.segmentDidChange(sender:)), for: .valueChanged)
        navigationItem.titleView = segmentControl
    }    
    func segmentDidChange(sender:UISegmentedControl) {
        print("segment \(sender.selectedSegmentIndex) selected")
    }
    
}
