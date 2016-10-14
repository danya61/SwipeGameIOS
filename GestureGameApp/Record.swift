//
//  Record.swift
//  GestureGameApp
//
//  Created by Danya on 04.10.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import Foundation


class Record{
    
   private  var recordPointsTime : [Int] = [0]
   private  var recordPointsMistake : [Int] = [0]
    
    
    init(){
        let defaults = UserDefaults.standard
        let timerec = defaults.object(forKey: "TimeRecord") as? [Int]
        let timemis = defaults.object(forKey: "MistakeRecord") as? [Int]
        recordPointsTime = timerec != nil ? timerec! : Array(repeating: 0, count: 5)
        recordPointsMistake = timemis != nil ? timemis! : Array(repeating: 0, count: 5)
    }
    
    
    class func TimeRecord() -> [Int]
    {
        let defaults = UserDefaults.standard
        var record = defaults.object(forKey: "TimeRecord") as? [Int]
        if (record == nil){
            record = Array(repeating: 0, count: 5)
        }
        return record!
    }
    
    class func MistakeRecord() -> [Int]
    {
        let defaults = UserDefaults.standard
        var record = defaults.object(forKey: "MistakeRecord") as? [Int]
        if (record == nil){
            record = Array(repeating: 0, count: 5)
        }
        return record!
    }
    
    func isTimeRecord(_ point : Int) -> Bool {
        return (point >= recordPointsTime[4])
    }
    
    func isMistakeRecord(_ point : Int) -> Bool {
        return (point >= recordPointsMistake[4])
    }
    
    func updateTimeRecords(_ point : Int) {
        if (isTimeRecord(point)){
            for (index, element) in recordPointsTime.enumerated() {
                if (point >= element) {
                    recordPointsTime.insert(point, at: index)
                    break
            }
          }
        saveTimeRecords()
      }
   }
    
    func updateMistakeRecords(_ point : Int) {
        if (isMistakeRecord(point)){
            for (index, element) in recordPointsMistake.enumerated() {
                if (point >= element) {
                    recordPointsMistake.insert(point, at: index)
                    break
                }
             }
          saveMistakeRecords()
        }
    }
    
    func saveTimeRecords(){
        let defaults = UserDefaults.standard
        defaults.set(recordPointsTime, forKey: "TimeRecord")
    }
    
    func saveMistakeRecords(){
        let defaults = UserDefaults.standard
        defaults.set(recordPointsMistake, forKey: "MistakeRecord")
    }
}
