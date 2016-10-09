import UIKit

protocol CellConfigurable {
    associatedtype ConfigurationType
    func configure(with: ConfigurationType)
}

class ArrayTableViewController<U: UITableViewCell> :
    UITableViewController where U: CellConfigurable  {

    let dataCell = "dataCell"

    var data: Array<U.ConfigurationType> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(U.self, forCellReuseIdentifier: dataCell)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tvc = tableView.dequeueReusableCell(withIdentifier: dataCell, for: indexPath)
        let cell = tvc as! U
        let content = data[(indexPath).row]
        cell.configure(with: content)
        return cell
    }
}
