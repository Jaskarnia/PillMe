//
//  CurrentDrugViewController.swift
//  PillMe
//
//  Created by Andy Yang on 11/12/17.
//  Copyright © 2017 Andy Yang. All rights reserved.
//

import UIKit
var list = [["Tylenol","9:20 PM","1"],["Advil", "1:20 PM","1"], ["Viagra", "5:20 PM","1"]]

class CurrentDrugViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var drugTableView: UITableView!
    
    @IBAction func curToArButton(_ sender: Any) {
        performSegue(withIdentifier: "curToARSeg", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row][0] + " " + list[indexPath.row][1] + " - " + list[indexPath.row][2] + " pills" 
        let lightSwitch = UISwitch()
        lightSwitch.setOn(true, animated: false)
        cell.accessoryView = lightSwitch
        
                
        return(cell)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            list.remove(at: indexPath.row)
            drugTableView.reloadData()
        }
    }
    override func viewDidAppear(_ animated: Bool)
    {
        drugTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
