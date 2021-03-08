//
//  WeatherDetailsViewController.swift
//  WeatherLookup
//
//  Created by Deep on 08/03/21.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var weatherDescLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var feelsLikeValue: UILabel!
    
    var cityName: String = ""
    
    var weatherListModel: WeatherListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = cityName
        self.navigationItem.backButtonTitle = "Back"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupUI() {
        
        guard let weatherListModel = self.weatherListModel else {
            return
        }
        if weatherListModel.weather.count > 0 {
            if let weatherData = weatherListModel.weather.first {
                weatherDescLabel.text = weatherData.weatherDescription.rawValue
                weatherLabel.text = weatherData.main.rawValue
            }
        }
        feelsLikeValue.textAlignment = .right
        temperatureLabel.text = "\(weatherListModel.main.temp)"
        feelsLikeValue.text = "Feels Like: \(weatherListModel.main.feelsLike)"
    }

}
