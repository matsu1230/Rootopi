//
//  Favorite.swift
//  Rootopi
//
//  Created by matsuuradaiki on 2015/10/26.
//  Copyright © 2015年 matsuuradaiki. All rights reserved.
//

import Foundation

public struct Favorite {
    public static var favorites = [String]()
    
    public static func load(){
        let ud = NSUserDefaults.standardUserDefaults()
        ud.registerDefaults(["favorites": [String]()])
        favorites = ud.objectForKey("favorites") as! [String]
    }
    
    public static func save(){
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(favorites, forKey: "favorites")
        ud.synchronize()
        print(favorites, terminator: "")
    }
    
    public static func add(gid: String?){
        if gid == nil || gid == "" { return }
        
        if favorites.contains((gid!)) {
            remove(gid!)
        }
        favorites.append(gid!)
        save()
    }
    
    public static func remove(gid: String?){
        if gid == nil || gid == "" { return }
        
        if let index = favorites.indexOf((gid!)) {
            favorites.removeAtIndex(index)
        }
        save()
    }
    
    public static func toggle(gid: String?){
        if gid == nil || gid == "" { return }
        
        if inFavorites(gid!) {
            remove(gid!)
        } else {
            add(gid!)
        }
    }
    
    public static func inFavorites(gid: String?) -> Bool {
        if gid == nil || gid == "" { return false }
        
        return favorites.contains((gid!))
    }
    
    public static func move(sourceIndex: Int, _ destinationIndex: Int){
        if sourceIndex >= favorites.count || destinationIndex >= favorites.count {
            return
        }
        
        let srcGid = favorites[sourceIndex]
        favorites.removeAtIndex(sourceIndex)
        favorites.insert(srcGid, atIndex: destinationIndex)
        
        save()
    }
}