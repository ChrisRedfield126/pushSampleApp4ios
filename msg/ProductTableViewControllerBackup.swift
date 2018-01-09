//
//  ProductTableViewController.swift
//  wesbites
//
//  Created by Wessel Heringa on 13/12/15.
//  Copyright © 2015 Wessel Heringa. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController {
    var products = [ProductModel]()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    
        self.tableView.registerClass(UIProductTableViewCell.self, forCellReuseIdentifier: UIProductTableViewCell.reuseIdentifier)

        loadProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: \(products.count)")
        return products.count
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UIProductTableViewCell {

        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(UIProductTableViewCell.reuseIdentifier, forIndexPath: indexPath) as! UIProductTableViewCell
        
        //print(cell)
       
        let product = products[indexPath.row]
        print(product.title)
        
        //cell.titleLabel = .text = "testerdetest" // product.title
        print(cell)
        return cell
    }
*/
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UIProductTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(UIProductTableViewCell.reuseIdentifier, forIndexPath: indexPath) as! UIProductTableViewCell
        
        print("tableview, row # is: \(indexPath.row)")
        cell.titleLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        
        return cell
    }
    
    func loadProducts(){
        let psDict = ProductModel.getProducts()
        if(psDict==nil){
            //assert(false,"No products found, network error?")
        }
        else{
            let ps = Array(psDict!.values)

            products = ps
        }
    }
    
    @IBAction func getProducts(sender: UIButton) {
        loadProducts()
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
