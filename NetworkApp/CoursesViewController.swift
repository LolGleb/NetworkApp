//
//  CoursesViewController.swift
//  NetworkApp
//
//  Created by g.semshchikov on 29.01.2023.
//

import UIKit

class CoursesViewController: UITableViewController {
        
    var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseCell
        let course = courses[indexPath.row]
        cell.configure(with: course)
        
        return cell
    }

}

// MARK: - Networking
extension CoursesViewController {
    func fetchCourses() {
        guard let url = URL(string: URLExamples.exampleTwo.rawValue) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                self.courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
