//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ömer Faruk KÖSE on 14.06.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let models = [Weather]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        tableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell .identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupLocation()

    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        
        let longitude = currentLocation.coordinate.longitude
        let latitude = currentLocation.coordinate.latitude
         
        let apiKey = ""
        
        let url = "http://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(longitude),\(latitude)"
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
          
            guard let data = data , error == nil else {
                print("Request error : ", error)
                return
            }
            
        })
        
        print("\(longitude) , \(latitude)")
    }
 

}

struct Weather: Codable {
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        
//        let vc = storyboard?.instantiateViewController(identifier: "taskDetail") as! TaskDetailViewController
//
//        vc.title = "Task"
//        vc.taskIndex = indexPath.row
//
//        print("clicked task index: ", indexPath.row)
//
//        vc.update = {
//            DispatchQueue.main.async {
//                self.updateTasks()
//            }
//        }
//
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier:  "cell", for: indexPath)
//
//        var content = cell.defaultContentConfiguration()
//
////        content.text = models[indexPath.row]
//
//        cell.contentConfiguration = content
//
//        return cell
        
        return UITableViewCell()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
}
