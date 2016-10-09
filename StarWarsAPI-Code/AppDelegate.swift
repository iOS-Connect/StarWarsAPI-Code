import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let vc = NamesTableViewController(nibName: nil, bundle: nil)
        window?.rootViewController = UINavigationController(rootViewController: vc)

        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        return true
    }
}

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

class Network {
    static func getNames(_ completion: @escaping ([String])-> Void) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let peopleEndpoint = "http://swapi.co/api/people"
        session.dataTask( with: URL(string: peopleEndpoint)!, completionHandler: { (data, response, error) in

            guard error == nil else {
                print("Some Error \(error!)")
                return
            }

            guard let newNames = Network().parseData(data) else {
                print("Sorry no names")
                return
            }

            completion(newNames)
        } ) .resume()

    }

    func parseData(_ data: Data?) -> [String]? {
        guard let data = data else { return nil }

        let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])
        let results = (json as? NSDictionary)?["results"]
        guard let peopleArray = results as? NSArray else {
            return nil
        }

        var names = [String]()
        for person in peopleArray {
            let dict = person as? NSDictionary
            if let name = dict?["name"] as? String {
                names.append(name)
            }
        }
        return names
    }
    
}
