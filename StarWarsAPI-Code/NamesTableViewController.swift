import UIKit

class NamesTableViewController: UITableViewController {

    var names = ["Douglas", "Jay", "Gloria", "John"]
    var tableSegments = ["Names", "Spaceships"]
    let nameCell = "NameCell"


    override func viewDidLoad() {
//        title = "Star Wars Names"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: nameCell)
        Network.getNames { [weak self] (names) in
            self?.names = names
            self?.tableView.reloadData()
        }
        let segmentControl = UISegmentedControl(items: tableSegments)
        segmentControl.selectedSegmentIndex = 0
        navigationController?.navigationBar.backgroundColor = UIColor.blue
        segmentControl.addTarget(self, action: #selector(NamesTableViewController.segmentDidChange(sender:)), for: .valueChanged)
        navigationItem.titleView = segmentControl
    }
    
    func segmentDidChange(sender:UISegmentedControl) {
        print("segment \(sender.selectedSegmentIndex) selected")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: nameCell, for: indexPath)
        cell.textLabel?.text = names[(indexPath as NSIndexPath).row]
        return cell
    }
    
}
