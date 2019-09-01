//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Muhammad Ashary on 31/08/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func getWeather(_ sender: Any) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.weather-forecast.com/locations/Jakarta/forecasts/latest")!
        let request = NSMutableURLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var message = ""
            
            if let error = error {
                print(error)
            } else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeparator = "Weather Today</h2> (1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        if contentArray.count > 0 {
                            stringSeparator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            if newContentArray.count > 0 {
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                
                                print(message)
                            }
                        }
                    }
                }
            }
            
            if message == "" {
                message = "The weather there couldn't be found. Please try again"
            }
            
            DispatchQueue.main.sync {
                self.resultLabel.text = message
            }
            
        }
        
        task.resume()
    }


}

