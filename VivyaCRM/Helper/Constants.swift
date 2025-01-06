//
//  Constants.swift
//  VivyaCRM
//
//  Created by Aswath Ravichandran on 03/01/25.
//



import Foundation

enum Constants {
    static let apiBaseUrl:String = try! Configuration.value(for: "URL")
}


