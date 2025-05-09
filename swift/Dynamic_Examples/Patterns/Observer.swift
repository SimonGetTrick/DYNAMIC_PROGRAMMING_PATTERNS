//
//  Observer.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 09.05.2025.
//

import Foundation

protocol PropertyObserver {
    
    func didGet(newTask task: String)
}

protocol Subject {
    
    func add(observer: PropertyObserver)
    func remove(observer: PropertyObserver)
    func notify(withString string: String)
}

class Pupil: NSObject, PropertyObserver {
    
    var homeTask = ""
    
    func didGet(newTask task: String) {
        homeTask = task
        print("new homework to be done")
    }
}

class Teacher: Subject {
    
    var observerCollection = NSMutableSet()
    var homeTask = "" {
        didSet {
            notify(withString: homeTask)
        }
    }
    
    func add(observer: PropertyObserver) {
        observerCollection.add(observer)
    }
    
    func remove(observer: PropertyObserver) {
        observerCollection.remove(observer)
    }
    
    func notify(withString string: String) {
        for observer in observerCollection {
            (observer as! PropertyObserver).didGet(newTask: string)
        }
    }
}

func demo_observer() {
    print("\n=== Observer ===\n")
    
    let teacher = Teacher()
    let pupil = Pupil()
    
    teacher.add(observer: pupil)
    teacher.homeTask = "task #3 on page 21"
    
    _ = pupil.homeTask
}











