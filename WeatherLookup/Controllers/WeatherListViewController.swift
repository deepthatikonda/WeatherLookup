//
//  WeatherListViewController.swift
//  WeatherLookup
//
//  Created by Deep on 08/03/21.
//

import UIKit

class WeatherListViewController: UIViewController {

    @IBOutlet weak var weatherListTableView: UITableView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private var weatherList: [WeatherListModel]? {
        didSet {
            self.weatherListTableView.reloadData()
        }
    }
        
    var cityName: String = ""
    
    let weatherService: WeatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = cityName
        self.navigationItem.backButtonTitle = "Back"
        hideActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showActivityIndicatior()
        self.weatherService.getWeatherFor(city: cityName, onCompletion: { weatherList in
            DispatchQueue.main.async { [weak self] in
                self?.hideActivityIndicator()
                self?.weatherList = weatherList
            }
           
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func showActivityIndicatior() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
}

extension WeatherListViewController: UITableViewDataSource, UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let weatherList = self.weatherList, weatherList.count > 0 {
            return weatherList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let weatherList = self.weatherList, weatherList.count > 0 {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "WeatherListTableViewCell")
            let weatherListModel = weatherList[indexPath.row]
            if let weatherData = weatherListModel.weather.first {
                cell.textLabel?.text = weatherData.main.rawValue
            }
            cell.detailTextLabel?.text = "Temp: \(weatherListModel.main.temp)"
            cell.selectionStyle = UITableViewCell.SelectionStyle.gray
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "EmptyDataCell")
            cell.textLabel?.text = "No Weather Info available"
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if let weatherList = self.weatherList, weatherList.count > 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let weatherDetailsVC = storyboard.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as? WeatherDetailsViewController else {
                return
            }
            weatherDetailsVC.cityName = self.cityName
            weatherDetailsVC.weatherListModel = weatherList[indexPath.row]
            self.navigationController?.pushViewController(weatherDetailsVC, animated: true)
        }
        
    }
}
