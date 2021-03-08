//
//  WeatherLookupViewController.swift
//  WeatherLookup
//
//  Created by Deep on 08/03/21.
//

import UIKit

class WeatherLookupViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Lookup"
        // Do any additional setup after loading the view.
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

    @IBAction func cityLookUpBtnAction(_ sender: Any) {
        if let cityText = cityNameTextField.text, cityText != "" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let weatherListViewController = storyboard.instantiateViewController(withIdentifier: "WeatherListViewController") as? WeatherListViewController else {
                return
            }
            weatherListViewController.cityName = cityText
            self.navigationController?.pushViewController(weatherListViewController, animated: true)
        }
    }

}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
