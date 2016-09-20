//
//  TableViewController.swift
//  aviationApp
//
//  Created by Anki on 14/09/16.
//  Copyright © 2016 Anki. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    var names:[String] = []
    var times:[String] = []
    var totalTime : Double = 0.0
    var filepath : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        printData()
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(self, selector: "writeData:", name: "datasend", object: nil)

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func printData(){
        
         filepath = NSBundle.mainBundle().pathForResource("task", ofType: "csv")!
        
        if let input = NSFileHandle(forReadingAtPath: filepath)
        {
            print(filepath)
            let scanner = StreamScanner(source: input, delimiters: NSCharacterSet(charactersInString: "\n"))
            while let line: String = scanner.read()
            {
                let sortedArray = line.characters.split{$0 == ","}.map(String.init)
                print("line is",sortedArray[7],sortedArray[8],sortedArray[9])
                names.append(sortedArray[8] + sortedArray[9])
                times.append(sortedArray[7])
            }
            for i in 0...times.count-1{
                let time = times[i].stringByReplacingOccurrencesOfString(":", withString: ".")
                totalTime = totalTime + Double(time)!
            }
        }
    }
    func writeData(notification: NSNotification) {
        
        let value = notification.userInfo!["data"] as! String
        
        if writeDataToFile(filepath,datagot: value) {
            print("data written in path \(filepath) Please check there for Updated CSV")
            tableview.reloadData()
        } else {
            print("data not written")
        }
    }
        func writeDataToFile(file:String,datagot:String)-> Bool{
            let data = datagot.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
            
            if NSFileManager.defaultManager().fileExistsAtPath(filepath) {
                if let fileHandle = NSFileHandle(forWritingAtPath: filepath) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.writeData(data)
                    fileHandle.closeFile()
                    print("write success")
                }
                else {
                    print("Can't open fileHandle")
                }
            }
            else {
                    print("Can't write")
            }
            return true
    }
        // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : DataTableViewCell = tableView.dequeueReusableCellWithIdentifier("DataTableViewCell", forIndexPath: indexPath) as! DataTableViewCell
        if(indexPath.row == times.count){
            cell.timeLabel.text = String(totalTime)
            cell.nameHeadLabel.text = "Name"
            cell.nameLabel.text = "All"
        }
        else{
        cell.timeLabel.text = times[indexPath.row]
        cell.nameHeadLabel.text = "Name"
        cell.nameLabel.text = names[indexPath.row]
//         Configure the cell...
        }
        return cell
    }


  
}
