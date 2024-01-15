//
//  CarViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 03/01/24.
//

import SwiftUI

class CarViewModel: ObservableObject {
    
    static var shared = CarViewModel()
    
    @Published  var txtBrandName = ""
    @Published  var txtModelName = ""
    @Published  var txtManufacturer = ""
    @Published  var txtNumberPlat = ""
    @Published  var txtSeat = ""
    
    
    @Published var selectBrand: NSDictionary?
    @Published var selectModel: NSDictionary?
    @Published var selectSeries: NSDictionary?
    
    @Published var selectOtherFlag = 0
    
    @Published var carList: NSArray = []
    
    @Published var brandList: NSArray = []
    @Published var modelList: NSArray = []
    @Published var seriesList: NSArray  = []
    
    @Published var selectImage: UIImage?
    
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    //MARK: Action
    func addNewVehicleAction(){
            
        if selectBrand == nil {
            errorMessage = "Please select you car brand"
            showError = true
            return
        }
        
        if  selectOtherFlag == 1 && txtBrandName.isEmpty {
            errorMessage = "Please enter your car brand name"
            showError = true
            return
        }
        
        if  selectOtherFlag > 1 && selectModel == nil {
            errorMessage = "Please select your car model"
            showError = true
            return
        }
        
        if  selectOtherFlag > 0 && selectOtherFlag <= 2 && txtModelName.isEmpty {
            errorMessage = "Please enter your car model name"
            showError = true
            return
        }
        
        if  selectOtherFlag > 2 && selectSeries == nil {
            errorMessage = "Please select your car series"
            showError = true
            return
        }
        
        if  txtNumberPlat.isEmpty {
            errorMessage = "Please enter your car number plate"
            showError = true
            return
        }
        
        if  txtSeat.isEmpty {
            errorMessage = "Please enter your car seat"
            showError = true
            return
        }
        
        if selectImage == nil {
            errorMessage = "Please select your car image"
            showError = true
            return
        }
        
        AddVehicleApi(image: selectImage!)
        
    }
    
    //MARK: ServiceCall
    
    func getBrandList(){
        ServiceCall.post(parameter: [:], path: Globs.svBrandList, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.brandList = responseObj.value(forKey: KKey.payload) as? NSArray ?? []
                    self.modelList = []
                    self.seriesList = []
                    self.selectModel = nil
                    self.selectSeries = nil
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError  = true
                }
            }
            
        
        } failure: { error in
            self.errorMessage = error?.localizedDescription ??  MSG.fail
            self.showError  = true
        }
    }
    
    func getModelList(){
        ServiceCall.post(parameter: ["brand_id": self.selectBrand?.value(forKey: "brand_id") ?? "" ], path: Globs.svModelList, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.modelList = responseObj.value(forKey: KKey.payload) as? NSArray ?? []
                    self.seriesList = []
                    self.selectSeries = nil
                    
                    
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError  = true
                }
            }
            
        
        } failure: { error in
            self.errorMessage = error?.localizedDescription ??  MSG.fail
            self.showError  = true
        }
    }
    
    func getSeriesList(){
        ServiceCall.post(parameter: ["model_id": self.selectModel?.value(forKey: "model_id") ?? ""  ], path: Globs.svSeriesList, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.seriesList = responseObj.value(forKey: KKey.payload) as? NSArray ?? []
                    self.selectSeries = nil
                    
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError  = true
                }
            }
            
        
        } failure: { error in
            self.errorMessage = error?.localizedDescription ??  MSG.fail
            self.showError  = true
        }
    }
    
    func getCarListApi(){
        ServiceCall.post(parameter: [:], path: Globs.svCarList, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.carList = responseObj.value(forKey: KKey.payload) as? NSArray ?? []
                  
                    
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError  = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ??  MSG.fail
            self.showError  = true
        }
    }
    
    func AddVehicleApi(image: UIImage) {
        
        ServiceCall.multipart(parameter: [
            "other_status": "\(selectOtherFlag)",
            "brand":selectOtherFlag > 1 ?  txtBrandName : "\(selectBrand?.value(forKey: "brand_id")  ?? "")",
            "model":selectOtherFlag > 0 && selectOtherFlag <= 2 ?  txtModelName : "\(selectModel?.value(forKey: "model_id")  ?? "")",
            "series": selectOtherFlag > 0 ?  txtManufacturer : "\(selectSeries?.value(forKey: "series_id")  ?? "")",
            "seat": txtSeat,
            "car_number": txtNumberPlat
        ] , path: Globs.svAddCar, imageDic: ["image": image], isTokenApi: true ) { responseObj in
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                                       
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.success
                    self.showError  = true

                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError  = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ??  MSG.fail
            self.showError  = true
        }

        
        
    }
    
    
    func deleteVehicleApi(obj: NSDictionary) {
        
        ServiceCall.post(parameter: [
            "user_car_id": obj.value(forKey: "user_car_id" ) ?? "",
        ] , path: Globs.svDeleteCar, isTokenApi: true ) { responseObj in
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.carList = self.carList.filter( { cObj in
                            
                        if let cObj = cObj as? NSDictionary {
                            return cObj.value(forKey: "user_car_id") as? Int != obj.value(forKey: "user_car_id") as? Int
                        }else{
                            return false
                        }
                        
                    }) as NSArray
                    
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError  = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ??  MSG.fail
            self.showError  = true
        }
    }
    
    func setRunningVehicleApi(obj: NSDictionary) {
        
        ServiceCall.post(parameter: [
            "user_car_id": obj.value(forKey: "user_car_id" ) ?? "",
        ] , path: Globs.svSetRunningCar, isTokenApi: true ) { responseObj in
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.carList = responseObj.value(forKey: KKey.payload) as? NSArray ?? []
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError  = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ??  MSG.fail
            self.showError  = true
        }
    }
    
    
}
