//
//  StopsTableViewController.swift
//  UT Buses
//
//  Created by Sammy Yousif on 3/26/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

import Foundation

let kEnabledNotifications = "wcEnabledNotifications"

class StopsTableViewController: UITableViewController {
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    var stops = [StopNotification]()
    
    var enabled : [String: String] = [:]

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stops.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StopCell", forIndexPath: indexPath) as! StopListRow
        let stop = stops[indexPath.row]
        
        cell.stopNameLabel.text = stop.name
        
        if stop.enabled {
            cell.stopEnabledMarker.backgroundColor = UTBussesStyles.purple
        } else {
            cell.stopEnabledMarker.backgroundColor = UTBussesStyles.gray
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dict = prefs.dictionaryForKey(kEnabledNotifications) as? [String: String] {
            enabled = dict
        }
        
        stops = wcStops.map { (stop: busStop) -> StopNotification in
            let id = "wc\(stop.id)"
            var state = false
            if (enabled[id] == "1") {
                state = true
            }
            let notification = StopNotification(name: stop.name, id: id, enabled: state)
            return notification
        }
        
        self.refreshControl?.addTarget(self, action: #selector(StopsTableViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    var timer: NSTimer?
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        if let settings = UIApplication.sharedApplication().currentUserNotificationSettings() {
            if settings.types.isEmpty {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            } else {
                self.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(StopsTableViewController.refreshTimeout), userInfo: nil, repeats: false)
                OneSignal.defaultClient().getTags({ (tags) in
                    if let _ = self.timer {
                        self.timer?.invalidate()
                        self.timer = nil
                    }
                    for (tagName, tagValue) in tags {
                        self.enabled[tagName as! String] = "\(tagValue)"
                    }
                    self.prefs.setValue(self.enabled, forKey: kEnabledNotifications)
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
            }
        } else {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    func refreshTimeout() {
        if let _ = timer {
            self.timer?.invalidate()
            self.timer = nil
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    func enableNotifications() {
        if prefs.boolForKey("promptedForNotifications") {
            let alert = UIAlertController(title: "Notifications Disabled", message: "It appears that you've disabled notifications for UT Buses. Tap on Settings to renable them if you want notifications.", preferredStyle: .Alert)
            let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            let settings = UIAlertAction(title: "Settings", style: .Default) { _ in
                UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!)
            }
            alert.addAction(cancel)
            alert.addAction(settings)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            OneSignal.defaultClient().registerForPushNotifications()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if let settings = UIApplication.sharedApplication().currentUserNotificationSettings() {
            if settings.types.isEmpty {
                enableNotifications()
            } else {
                var stop = stops[indexPath.row]
                stop.enabled = !stop.enabled
                stops[indexPath.row] = stop
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                if (stop.enabled) {
                    OneSignal.defaultClient().sendTag(stop.id, value: "1")
                    enabled[stop.id] = "1"
                    prefs.setValue(enabled, forKey: kEnabledNotifications)
                } else {
                    OneSignal.defaultClient().sendTag(stop.id, value: "2")
                    enabled[stop.id] = "2"
                    prefs.setValue(enabled, forKey: kEnabledNotifications)
                }
            }
        }
    }
    
}
