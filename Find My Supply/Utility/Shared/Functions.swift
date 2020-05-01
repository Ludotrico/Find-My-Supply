//
//  Functions.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/5/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit


class Functions {
    static let shared = Functions()
    
    
    func OpenOrClose(td:Int, opent:Int, closet:Int) -> (open:Bool, almost:Bool)
    {
        var open:Bool
        var almost:Bool

        if (opent < closet) {                   // e.g. 8am to 8pm

            if(td>=opent) && (td<closet)        // e.g. 10am
            {
                open = true
                almost = ((td+30) >= closet)    // e.g. 7:30pm
            }
            else                                // e.g. 9 pm or 5am
            {
                open = false
                almost = false
                if (td < opent) {
                    almost = ((td+30) >= opent)     // e.g. 7:35am
                }
            }
        }
        else                                    // e.g. 8pm to 8am
        {
            if(td<opent) && (td>=closet)
            {
                open = false
                almost = ((td+30) >= opent)
            }
            else
            {
                open = true
                almost = false
                if(td<closet){
                     almost = ((td+30) >= closet)
                }
            }
        }

        return (open, almost)
    }
    
    
    func calculateOpenStatus(store: nearbyStore) -> (String, UIColor) {
        let date = Date()
        let currDay =  Calendar.current.component(.weekday, from: date) - 1
        let hour = Calendar.current.component(.hour, from: date)
        let minutes = Calendar.current.component(.minute, from: date)
        let td = hour*60+minutes
        
        
        print("\n\n===========Day: \(currDay) Hour: \(hour) Minutes: \(minutes) ")
        
        let hoursCodex = store.store__openingHours
        if hoursCodex.count == 1 {
            return ("Open 24/7", .systemGreen)

        }
        
        if hoursCodex[currDay] == "#" {
            return ("Closed today", UIColor.rgb(red: 255, green: 0, blue: 0))

        }
        print("\n\n===========Day: \(currDay) Hour: \(hour) Minutes: \(minutes) ")
        
        let openFrom = Float(hoursCodex[currDay].prefix(4))!/100.0
        let openUntil = Float(hoursCodex[currDay].suffix(4))!/100.0
        
        print("\n\n===========Day: \(currDay) Hour: \(hour) Minutes: \(minutes) ")
        
        //potentially open
        let openHour = Int(openFrom)
        let closeHour = Int(openUntil)
        
        let openMinutes = Int(openFrom - Float(openHour))
        let closedMinutes = Int(openUntil - Float(openUntil))
        
        let opent = openHour*60+openMinutes
        let closet = closeHour*60+closedMinutes
      
        var open:Bool
        var almost:Bool
        
        (open, almost) = OpenOrClose(td: td, opent: opent, closet: closet)
        
        if ( open ) {
            if ( almost ) {
                return ("Closing soon", UIColor.rgb(red: 255, green: 153, blue: 0))
            }
            return ("Open now", .systemGreen)
        }
        if (almost) {
            return ("Opening soon", UIColor.rgb(red: 255, green: 153, blue: 0))
        }
        return ("Closed now", UIColor.rgb(red: 255, green: 0, blue: 0))
    }
    
    func calculateOpenStatus(store: store) -> (String, UIColor) {
        let date = Date()
        let currDay =  Calendar.current.component(.weekday, from: date) - 1
        let hour = Calendar.current.component(.hour, from: date)
        let minutes = Calendar.current.component(.minute, from: date)
        let td = hour*60+minutes
        
        
        print("\n\n===========Day: \(currDay) Hour: \(hour) Minutes: \(minutes) ")
        
        let hoursCodex = store.store__openingHours
        if hoursCodex.count == 1 {
            return ("Open 24/7", .systemGreen)

        }
        
        if hoursCodex[currDay] == "#" {
            return ("Closed today", UIColor.rgb(red: 255, green: 0, blue: 0))

        }
        print("\n\n===========Day: \(currDay) Hour: \(hour) Minutes: \(minutes) ")
        
        let openFrom = Float(hoursCodex[currDay].prefix(4))!/100.0
        let openUntil = Float(hoursCodex[currDay].suffix(4))!/100.0
        
        print("\n\n===========Day: \(currDay) Hour: \(hour) Minutes: \(minutes) ")
        
        //potentially open
        let openHour = Int(openFrom)
        let closeHour = Int(openUntil)
        
        let openMinutes = Int(openFrom - Float(openHour))
        let closedMinutes = Int(openUntil - Float(openUntil))
        
        let opent = openHour*60+openMinutes
        let closet = closeHour*60+closedMinutes
      
        var open:Bool
        var almost:Bool
        
        (open, almost) = OpenOrClose(td: td, opent: opent, closet: closet)
        
        if ( open ) {
            if ( almost ) {
                return ("Closing soon", UIColor.rgb(red: 255, green: 153, blue: 0))
            }
            return ("Open now", .systemGreen)
        }
        if (almost) {
            return ("Opening soon", UIColor.rgb(red: 255, green: 153, blue: 0))
        }
        return ("Closed now", UIColor.rgb(red: 255, green: 0, blue: 0))
    }
    
    
    
    
    

    
    
    
    
    
    
    
}
