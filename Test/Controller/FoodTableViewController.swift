//
//  FoodTableViewController.swift
//  Test
//
//  Created by D7703_27 on 2018. 6. 22..
//  Copyright © 2018년 kwackjihoon. All rights reserved.
//
import MapKit
import UIKit

class FoodTableViewController: UITableViewController,MKMapViewDelegate,UISearchBarDelegate {
    @IBOutlet var detailTableView: UITableView!
    @IBOutlet weak var searcgbar: UISearchBar!
    
    var FoodStoreName = ["늘해랑", "번개반점", "아딸", "왕짜장", "토마토 도시락", "홍콩반점"]
    var FooDStoreimages = ["01", "02", "03", "04", "05", "06"]
    var FoodStoreAddress = ["부산광역시 부산진구 양정1동 350-1",
                            "부산광역시 부산진구 양정동 418-282",
                            "부산광역시 부산진구 양정동 393-18",
                            "부산광역시 부산진구 양정1동 356-22",
                            "부산광역시 부산진구 양정1동 산19-8",
                            "부산광역시 부산진구 양정동 353-38"]
    var FoodStoreTel = ["051-863-6997",
                        "051-852-9969",
                        "051-852-9969",
                        "051-852-9969",
                        "051-852-9969",
                        "051-853-0410"]
    var FoodMenus = ["수육백반, 돼지국밥, 순대국밥, 내장국밥",
                     "짜장면, 짬뽕, 짬짜면, 탕수육, 탕짜면, 군만두, 양장피",
                     "떡볶이, 오뎅, 떡강정, 핫도그, 튀김",
                     "짜장면, 짬뽕, 짬짜면, 탕수육, 볶짜면, 군만두, 양장피",
                     "치킨마요, 참치마요, 돈불와퍼, 돈치와퍼, 돈까스카레",
                     "짬뽕, 짜장면, 짬뽕밥, 볶음밥, 탕수육, 군만두"
    ]
    
    var FoodStoreType = ["돼지국밥집", "중화요리", "분식점", "중화요리", "도시락", "중화요리"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "배달통통"
        
        //self.searchBarSetup()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FoodStoreAddress.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)as! FoodTableViewCell

        // Configure the cell...
        cell.address.text = FoodStoreAddress[indexPath.row]
        cell.collage.text = FoodStoreName[indexPath.row]
        cell.tel.text = FoodStoreTel[indexPath.row]
        cell.icon.image = UIImage(named: FooDStoreimages[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "전화걸기", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        let callAction = UIAlertAction(title: FoodStoreTel[indexPath.row], style: .default) {
            (action: UIAlertAction) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call service is not available yet", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        if let phoneCallURL = URL(string: "tel://"+FoodStoreTel[indexPath.row]) {
            
            let application:UIApplication = UIApplication.shared
            
            if (application.canOpenURL(phoneCallURL)) {
                
                application.open(phoneCallURL, options: [:], completionHandler: nil)
                
            }
            
        }
        
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(callAction)
        
        present(optionMenu, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } /*else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        } */
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailMapView" {
            if let indexPath =  detailTableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! MapViewController
                destinationController.location = FoodStoreAddress[indexPath.row]
                destinationController.name = FoodStoreName[indexPath.row]
            }
        }else if segue.identifier == "totalmap" {
            let destinationController = segue.destination as! TotalViewController
            destinationController.name = FoodStoreName
            destinationController.address = FoodStoreAddress
        }
        
    }
}
