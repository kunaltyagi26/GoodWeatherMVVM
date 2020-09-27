//
//  AddCityVC.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 20/09/20.
//

import UIKit

protocol AddCityVCDelegate: NSObject {
    func addCityToList(vm: WeatherViewModel)
}

class AddCityVC: UIViewController {

    @IBOutlet weak var cityNameTextField: BindingTextField! {
        didSet {
            cityNameTextField.bind { self.addCityVM.city = $0 }
        }
    }
    @IBOutlet weak var stateTextField: BindingTextField! {
        didSet {
            stateTextField.bind { self.addCityVM.state = $0 }
        }
    }
    @IBOutlet weak var zipCodeTextField: BindingTextField! {
        didSet {
            zipCodeTextField.bind { self.addCityVM.zipCode = $0 }
        }
    }
    
    private var addCityVM = AddCityViewModel()
    weak var delegate: AddCityVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        if let city = cityNameTextField.text {
            addCityVM.fetchWeather(by: city) { weatherVM, errorMessage in
                if errorMessage != "", let weatherVM = weatherVM {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        self.delegate?.addCityToList(vm: weatherVM)
                    }
                    
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
