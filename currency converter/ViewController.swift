

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    var mycurrency:[String] = []
    var myvalues:[Double] = []
    
    var activecurrency:Double = 0;
    
    @IBOutlet weak var text: UITextField!
    
    @IBOutlet weak var pickerview: UIPickerView!
    
    
    @IBOutlet weak var output: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mycurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mycurrency[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    activecurrency = myvalues[row] 
    
    }
    
    @IBAction func action(_ sender: Any) {
        
        if (text.text != "")
        
        {
    
    output.text = String(Double(text.text!)! * activecurrency )
    
        
    }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
    let url = URL (string: "http://data.fixer.io/api/latest?access_key=da9f3fcaca91ccf39dd5582d7743b26f")
    
    let task = URLSession.shared.dataTask(with: url! ) { (data, response, error) in
        
        if error != nil
            
        {
            print("Errrors")
            
        }
            
        else
            
        {
           
            if let content = data
            
            {
                do
                
                {
                    
                    let myjson = try JSONSerialization.jsonObject(with: content , options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                 
                    if let rates = myjson["rates"]  as? NSDictionary
                    {
                 
                for (key,value) in rates
                {
                    
                    
                    self.mycurrency.append((key as? String)!)
                    self.myvalues.append((value as? Double)!)
                    
                
                        }
                    }
                }
            catch
                
            {
                }
            
            }
        }
    
        self.pickerview.reloadAllComponents()
    }
   
        task.resume()
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

