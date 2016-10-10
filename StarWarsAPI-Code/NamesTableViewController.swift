import UIKit

extension UITableViewCell: CellConfigurable {
    func configure(with text: String) {
        self.textLabel?.text = text
    }
}

class NamesTableViewController: ArrayTableViewController<UITableViewCell> {
    lazy var segmentControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["Names", "Spaceships"])
        segControl.selectedSegmentIndex = 0
        segControl.addTarget(self, action: #selector(NamesTableViewController.segmentDidChange(sender:)), for: .valueChanged)
        return segControl
    }()
    override func viewDidLoad() {       
        super.viewDidLoad()
        title = "Star Wars Names"
        Network.getNames { [weak self] (names) in
        self?.data = names
        self?.tableView.reloadData()
        }
        navigationItem.titleView = segmentControl
    }
    func segmentDidChange(sender:UISegmentedControl) {
        print("segment \(sender.selectedSegmentIndex) selected")
    }
    
}
