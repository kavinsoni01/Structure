//
//  AILocationManager.swift
//  ToDoTaskApp
//
//  Created by KavinSoni on 22/06/17.
//  Copyright © 2017 Agile. All rights reserved.
//


import UIKit
import CoreLocation

class AILocationManager: NSObject, CLLocationManagerDelegate {
	
	// MARK: - PROPERTIES -
	var locationManager: CLLocationManager?
	var blockCurrentLocationHandler: ((_ isSuccess:Bool, _ isDenied:Bool, _ currentLocation:CLLocation) -> Void)?
	var dateOfLastLocationFound:NSDate = NSDate().addingTimeInterval(-24 * 60 * 60) // SETTING YESTERDAYS DATE BECAUSE ON FIRST COMPARISON TIME INTERVAL WILL BE SHORTER
	
	
	// MARK: - SHARED MANAGER -
	static let shared = AILocationManager()
	
	
	//MARK:- SETUP LOCATION MANAGER
	func doSetupLocationManager() {
		
		if(self.locationManager == nil){
			self.locationManager = CLLocationManager()
			self.locationManager?.delegate = self
			self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
		}
	}
	
	
	//MARK:- GET CURRENT LOCATION
	func getCurrentLocationWith(completion:@escaping (_ isSuccess:Bool, _ isDenied:Bool, _ currentLocation:CLLocation) -> Void) {
		
		self.blockCurrentLocationHandler = completion

		switch CLLocationManager.authorizationStatus() {
		case .denied:
			
//			print("DENIED : show root : \(appDelegate.window?.rootViewController)")
			showAlertWithTitleFromVC(vc: (Constant.appDelegate.window?.rootViewController)!, title: Constant.App.APP_NAME, andMessage: "Turn on location services from the settings to allow \"\(Constant.App.APP_NAME)\" to determine your location", buttons: ["Settings","Cancel"], completion: { (index) in
				if(index == 0){
					
					if let url = URL(string: UIApplicationOpenSettingsURLString) {
						
						if #available(iOS 10.0, *) {
							UIApplication.shared.open(url, options: [:], completionHandler: nil)
						} else {
							UIApplication.shared.openURL(url)
						}
					}
					
					
				}
			})
			
			completion(false, true, CLLocation())
			return
			
		case .authorizedAlways:
			break
		case .authorizedWhenInUse:
			break
		case .notDetermined:
			break
		case .restricted:
			break
		}
		
		self.doSetupLocationManager()
		
		self.locationManager?.requestWhenInUseAuthorization()
		self.locationManager?.startUpdatingLocation()
	}
	
	//MARK:- REVERSE GEO CODE LOCATION DETAIL
	func getGeocodeDetailFrom(location:CLLocation, with completion:@escaping (_ isSuccess:Bool, _ placemark:CLPlacemark?) -> Void){
		
		CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
			if(error == nil){
				let firstPlaceMark = (placemarks?.first)! as CLPlacemark
				completion(true, firstPlaceMark)
			}else{
				completion(false, nil)
			}
		}
	}
	
	
	//MARK:- CLLOCATION MANAGER DELEGATE
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		self.locationManager?.stopUpdatingLocation()
		
		if let lastLocation = locations.last{
//			print("LOCATION DID UPDATE TO --> LAT : \(lastLocation.coordinate.latitude), LONG : \(lastLocation.coordinate.longitude)")
			
			if(NSDate().timeIntervalSince(self.dateOfLastLocationFound as Date) > 1){
				self.dateOfLastLocationFound = NSDate()
				if(self.blockCurrentLocationHandler != nil){
					
//					SharedUser.latitude = CGFloat(lastLocation.coordinate.latitude)
//					SharedUser.longitude = CGFloat(lastLocation.coordinate.longitude)

//					print("LOCATION MANAGER LAST : \(lastLocation)")
					self.blockCurrentLocationHandler!(true, false, lastLocation)
					self.blockCurrentLocationHandler = nil
				}
			}
		}else{
//			print("LOCATION DID UPDATE : BUT NO DATA FOUND")
			if(self.blockCurrentLocationHandler != nil){
				self.blockCurrentLocationHandler!(false, false, CLLocation())
				self.blockCurrentLocationHandler = nil
			}
		}
	}
	
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		
		self.locationManager?.stopUpdatingLocation()
//		print("LOCATION FAILED : \(error) ")
		if(self.blockCurrentLocationHandler != nil){
			self.blockCurrentLocationHandler!(false, false, CLLocation())
			self.blockCurrentLocationHandler = nil
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		
//		var locationStatus = ""
//		switch status {
//		case .notDetermined: locationStatus = "NOT DETERMINED"
//		case .restricted: locationStatus = "RESTRICTED"
//		case .denied: locationStatus = "DENIED"
//		case .authorizedAlways: locationStatus = "AUTHORIZED ALWAYS"
//		case .authorizedWhenInUse: locationStatus = "AUTHORIZED WHEN IN USE"
//		}
//		print("LOCATION DID CHANGE AUTHORIZATION TO : \(locationStatus) ")
	}
}
