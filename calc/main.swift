//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

func check(args:[String]) -> Bool {
    for (index,value) in args.enumerated() {
        if index % 2 == 1 {
            if(value != "x" && value != "/" && value != "%" && value != "+" && value != "-"){
                return false
            }
        }
    }
    return true
}

var result = 0
func calc(args:[String]) -> Int {
    while args.count > 1 {
        if args.contains("x") || args.contains("/") || args.contains("%") {
            for (index,value) in args.enumerated() {
                if value == "x" || value == "/" || value == "%" {
                    if value == "x"{
                        result = Int(args[index - 1])! * Int(args[index + 1])!
                    } else if value == "/" {
                        result = Int(args[index - 1])! / Int(args[index + 1])!
                    } else if value == "%" {
                        result = Int(args[index - 1])! % Int(args[index + 1])!
                    }
                    var tmpArr = args
                    tmpArr.remove(at: index)
                    tmpArr.insert(String(result), at: index)
                    tmpArr.remove(at: index + 1)
                    tmpArr.remove(at: index - 1)
                    return calc(args: tmpArr)
                }
            }
        }
        else {
            for (index,value) in args.enumerated() {
                if value == "+" || value == "-"{
                    if value == "+"{
                        result = Int(args[index - 1])! + Int(args[index + 1])!
                    } else if value == "-"{
                        result = Int(args[index - 1])! - Int(args[index + 1])!
                    }
                    var tmpArr = args
                    tmpArr.remove(at: index)
                    tmpArr.insert(String(result), at: index)
                    tmpArr.remove(at: index + 1)
                    tmpArr.remove(at: index - 1)
                    return calc(args: tmpArr)
                }
            }
        }
    }
    return result
}

if (args.count == 1) {
    print(Int(args.first!)!)
} else {
    if(!check(args: args)) {
        exit(1)
    } else {
        print(calc(args: args))
    }
}
