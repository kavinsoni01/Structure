//
//  Extension_NSDictionary.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 22/06/17.
//  Copyright © 2017 Agile. All rights reserved.
//


import Foundation
import CoreGraphics


extension NSDictionary {
	
	func object_forKeyWithValidationForClass_Int(aKey: String) -> Int {
		
		// CHECK FOR EMPTY
		if(self.allKeys.count == 0) {
			return Int()
		}
		
		// CHECK IF KEY EXIST
		if let val = self.object(forKey: aKey) {
			if((val as AnyObject).isEqual(NSNull())) {
				return Int()
			}
		} else {
			// KEY NOT FOUND
			return Int()
		}
		
		// CHECK FOR NIL VALUE
		let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
		if aValue.isEqual(NSNull()) {
			return Int()
		}
		else if(aValue.isKind(of: NSString.self)){
			return Int((aValue as! NSString).intValue)
		}
		else {
			
			if aValue is Int {
				return self.object(forKey: aKey) as! Int
			}
			else{
				return Int()
			}
		}
	}
	
	func object_forKeyWithValidationForClass_CGFloat(aKey: String) -> CGFloat {
		
		// CHECK FOR EMPTY
		if(self.allKeys.count == 0) {
			return CGFloat()
		}
		
		// CHECK IF KEY EXIST
		if let val = self.object(forKey: aKey) {
			if((val as AnyObject).isEqual(NSNull())) {
				return CGFloat()
			}
		} else {
			// KEY NOT FOUND
			return CGFloat()
		}
		
		// CHECK FOR NIL VALUE
		let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
		if aValue.isEqual(NSNull()) {
			return CGFloat()
		}
		else {
			
			if aValue is CGFloat {
				return self.object(forKey: aKey) as! CGFloat
			}
			else{
				return CGFloat()
			}
		}
	}
	
	func object_forKeyWithValidationForClass_String(aKey: String) -> String {
		
		// CHECK FOR EMPTY
		if(self.allKeys.count == 0) {
			return String()
		}
		
		// CHECK IF KEY EXIST
		if let val = self.object(forKey: aKey) {
			if((val as AnyObject).isEqual(NSNull())) {
				return String()
			}
		} else {
			// KEY NOT FOUND
			return String()
		}
		
		// CHECK FOR NIL VALUE
		let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
		if aValue.isEqual(NSNull()) {
			return String()
		}
		else if(aValue.isKind(of: NSNumber.self)){
			return String(format:"%f", (aValue as! NSNumber).doubleValue)
		}
		else {
			
			if aValue is String {
				return self.object(forKey: aKey) as! String
			}
			else{
				return String()
			}
		}
	}
	
	func object_forKeyWithValidationForClass_StringInt(aKey: String) -> String {
		
		// CHECK FOR EMPTY
		if(self.allKeys.count == 0) {
			return String()
		}
		
		// CHECK IF KEY EXIST
		if let val = self.object(forKey: aKey) {
			if((val as AnyObject).isEqual(NSNull())) {
				return String()
			}
		} else {
			// KEY NOT FOUND
			return String()
		}
		
		// CHECK FOR NIL VALUE
		let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
		if aValue.isEqual(NSNull()) {
			return String()
		}
		else if(aValue.isKind(of: NSNumber.self)){
			return String(format:"%d", (aValue as! NSNumber).int64Value)
//			return String(format:"%.0f", (aValue as! NSNumber).doubleValue)

		}
		else {
			
			if aValue is String {
				return self.object(forKey: aKey) as! String
			}
			else{
				return String()
			}
		}
	}
	
	func object_forKeyWithValidationForClass_Bool(aKey: String) -> Bool {
		// CHECK FOR EMPTY
		if(self.allKeys.count == 0) {
			return Bool()
		}
		
		// CHECK IF KEY EXIST
		if let val = self.object(forKey: aKey) {
			if((val as AnyObject).isEqual(NSNull())) {
				return Bool()
			}
		} else {
			// KEY NOT FOUND
			return Bool()
		}
		
		// CHECK FOR NIL VALUE
		let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
		if aValue.isEqual(NSNull()) {
			return Bool()
		}
		else {
			
			if aValue is Bool {
				return self.object(forKey: aKey) as! Bool
			}
			else{
				return Bool()
			}
		}
	}
	
	func object_forKeyWithValidationForClass_NSArray(aKey: String) -> NSArray {
		// CHECK FOR EMPTY
		if(self.allKeys.count == 0) {
			return NSArray()
		}
		
		// CHECK IF KEY EXIST
		if let val = self.object(forKey: aKey) {
			if((val as AnyObject).isEqual(NSNull())) {
				return NSArray()
			}
		} else {
			// KEY NOT FOUND
			return NSArray()
		}
		
		// CHECK FOR NIL VALUE
		let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
		if aValue.isEqual(NSNull()) {
			return NSArray()
		}
		else {
			if aValue is NSArray {
				return self.object(forKey: aKey) as! NSArray
			}
			else{
				return NSArray()
			}
		}
	}
	
	func object_forKeyWithValidationForClass_NSMutableArray(aKey: String) -> NSMutableArray {
		// CHECK FOR EMPTY
		if(self.allKeys.count == 0) {
			return NSMutableArray()
		}
		
		// CHECK IF KEY EXIST
		if let val = self.object(forKey: aKey) {
			if((val as AnyObject).isEqual(NSNull())) {
				return NSMutableArray()
			}
		} else {
			// KEY NOT FOUND
			return NSMutableArray()
		}
		
		// CHECK FOR NIL VALUE
		let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
		if aValue.isEqual(NSNull()) {
			return NSMutableArray()
		}
		else {
			
			if aValue is NSMutableArray {
				return self.object(forKey: aKey) as! NSMutableArray
			}
			else{
				return NSMutableArray()
			}
		}
	}
	
	func object_forKeyWithValidationForClass_NSDictionary(aKey: String) -> NSDictionary {
		// CHECK FOR EMPTY
		if(self.allKeys.count == 0) {
			return NSDictionary()
		}
		
		// CHECK IF KEY EXIST
		if let val = self.object(forKey: aKey) {
			if((val as AnyObject).isEqual(NSNull())) {
				return NSDictionary()
			}
		} else {
			// KEY NOT FOUND
			return NSDictionary()
		}
		
		// CHECK FOR NIL VALUE
		let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
		if aValue.isEqual(NSNull()) {
			return NSDictionary()
		}
		else {
			
			if aValue is NSDictionary {
				return self.object(forKey: aKey) as! NSDictionary
			}
			else{
				return NSDictionary()
			}
		}
	}
	
	func object_forKeyWithValidationForClass_NSMutableDictionary(aKey: String) -> NSMutableDictionary {
		// CHECK FOR EMPTY
		if(self.allKeys.count == 0) {
			return NSMutableDictionary()
		}
		
		// CHECK IF KEY EXIST
		if let val = self.object(forKey: aKey) {
			if((val as AnyObject).isEqual(NSNull())) {
				return NSMutableDictionary()
			}
		} else {
			// KEY NOT FOUND
			return NSMutableDictionary()
		}
		
		// CHECK FOR NIL VALUE
		let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
		if aValue.isEqual(NSNull()) {
			return NSMutableDictionary()
		}
		else {
			if aValue is NSMutableDictionary {
				return self.object(forKey: aKey) as! NSMutableDictionary
			}
			else{
				return NSMutableDictionary()
			}
		}
	}
}
