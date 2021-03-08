//
//  WeatherService.swift
//  WeatherLookup
//
//  Created by Deep on 08/03/21.
//

import Foundation

protocol Service {
    func getWeatherFor(city: String, onCompletion: @escaping ([WeatherListModel]) -> ())
}

class WeatherService: Service {
    
    let weatherAPI = "https://api.openweathermap.org/data/2.5/forecast"
    let apiKey = "65d00499677e59496ca2f318eb68c049"
    
    func getWeatherFor(city: String, onCompletion: @escaping ([WeatherListModel]) -> ()) {
        let url = URL(string: weatherAPI + "?q=" + "\(city)" + "&appid=\(apiKey)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching weather details: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(String(describing: response))")
            return
          }

          if let data = data,
            let weatherModel = try? JSONDecoder().decode(WeatherDetail.self, from: data) {
                onCompletion( weatherModel.list)
          }
        })
        task.resume()
    }
}
