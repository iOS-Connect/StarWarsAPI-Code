import UIKit

protocol CellConfigurable {
    associatedtype ConfigurationType
    func configure(with: ConfigurationType)
}

class ArrayTableViewController<Cell: UITableViewCell> :
    UITableViewController where Cell: CellConfigurable  {

    let dataCell = "dataCellReuseIdentifier"

    var data: Array<Cell.ConfigurationType> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.self, forCellReuseIdentifier: dataCell)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dataCell, for: indexPath) as! Cell
        let content = data[(indexPath).row]
        cell.configure(with: content)
        return cell
    }
}
