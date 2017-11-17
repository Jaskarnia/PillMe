//
//  LoginViewController.swift
//  PillMe
//
//  Created by Andy Yang on 11/11/17.
//  Copyright © 2017 Andy Yang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func loginPressed(_ sender: UIButton)
    {
        if (userTextField.text != "" && passTextField.text != "")
        {
            performSegue(withIdentifier: "loginToARSegue", sender: self)
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userTextField.delegate = self;
        self.passTextField.delegate = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
