//
//  MainViewController.swift
//  NetworkApp
//
//  Created by g.semshchikov on 29.01.2023.
//

import UIKit

enum URLExamples: String {
    case imageURL = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    case exampleOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    case exampleTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    case exampleThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    case exampleFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
}

enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
    case exampleOne = "Example One"
    case exampleTwo = "Example Two"
    case exampleThree = "Example Three"
    case exampleFour = "Example Four"
    case ourCourses = "Our Courses"
}

class MainViewController: UICollectionViewController {
    
    let userActions = UserActions.allCases

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
        
        let userAction = userActions[indexPath.item]
        cell.userActionLabel.text = userAction.rawValue
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .downloadImage:
            performSegue(withIdentifier: "showImage", sender: nil)
        case .exampleOne:
            exampleOneButtonPressed()
        case .exampleTwo:
            exampleTwoButtonPressed()
        case .exampleThree:
            exampleThreeButtonPressed()
        case .exampleFour:
            exampleFourButtonPressed()
        case .ourCourses:
            performSegue(withIdentifier: "showCourses", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCourses" {
            let coursesVC = segue.destination as! CoursesViewController
            coursesVC.fetchCourses()
        }
    }

    // MARK: - Private Methods
    private func successAlert() {
        let alert = UIAlertController(title: "Success",
                                      message: "You can see the results in the Debug aria",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func failedAlert() {
        let alert = UIAlertController(title: "Failed",
                                      message: "You can see error in the Debug aria",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Networking
extension MainViewController {
    private func exampleOneButtonPressed() {
        guard let url = URL(string: URLExamples.exampleOne.rawValue) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }
    
    private func exampleTwoButtonPressed() {
        guard let url = URL(string: URLExamples.exampleTwo.rawValue) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let course = try JSONDecoder().decode([Course].self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }
    
    private func exampleThreeButtonPressed() {
        guard let url = URL(string: URLExamples.exampleThree.rawValue) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let course = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }
    
    private func exampleFourButtonPressed() {
        guard let url = URL(string: URLExamples.exampleFour.rawValue) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let course = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(course)
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
    
}
