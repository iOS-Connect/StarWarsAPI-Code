import UIKit

class NamesTableViewController: UITableViewController {

    var names = ["Douglas", "Jay", "Gloria", "John"]
    let nameCell = "NameCell"

    override func viewDidLoad() {
        title = "Star Wars Names"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: nameCell)
        Network.getNames { [weak self] (names) in
            self?.names = names
            self?.tableView.reloadData()
        }
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
