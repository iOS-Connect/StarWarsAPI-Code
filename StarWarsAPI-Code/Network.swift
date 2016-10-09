import Foundation

class Network {

    static let baseURL = URL(string:"http://swapi.co")!
    static let peopleEndpoint = baseURL.appendingPathComponent("api/people", isDirectory: false)

    static func getNames(_ completion: @escaping ([String])-> Void) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: peopleEndpoint) { data, response, error in

            guard error == nil else {
                print("Some Error \(error!)")
                return
            }

            guard let newNames = Network().parseData(data) else {
                print("Sorry no names")
                return
            }

            completion(newNames)
        }
        task.resume()

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
