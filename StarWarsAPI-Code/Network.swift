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

            guard let newNames:[String] = Network().parseData(data, key: "names") else {
                print("Sorry no names")
                return
            }

            completion(newNames)
        }
        task.resume()

    }

    func parseData<T>(_ data: Data?, key: String) -> [T]? {
        guard let data = data else { return nil }

        let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])
        let results = (json as? [String:Any?])?["results"]
        guard let peopleArray = results as? [Any?] else {
            return nil
        }

        var names = [T]()
        for person in peopleArray {
            let dict = person as? [String:Any?]
            if let name = dict?[key] as? T {
                names.append(name)
            }
        }
        return names
    }
    
}
