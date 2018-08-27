//
//  MapKitViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/4.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapKitViewController: UIViewController, CLLocationManagerDelegate {
    
    //UI建立事件
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var lblShopTEL: UILabel!
    @IBOutlet weak var lblShopTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var btnTel: UIButton!
    @IBOutlet weak var btnNavigate: UIButton!
    
    //開啟電話
    @IBAction func btnTel_Click(_ sender: Any) {
        
        if let photoURL = URL(string: "tel://\(shopTel)") {
            if UIApplication.shared.canOpenURL(photoURL) {
                UIApplication.shared.open(photoURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    //開啟導航
    @IBAction func btnNavigate_Click(_ sender: Any) {
        
    //要提供從一個位置到另一個位置的導航方向，請在saddr和daddr參數中提供起始和目標地址，如下所示。您還可以提供比此處所示的更多開始和目標地址的詳細信息。
    //http://maps.apple.com/?saddr=Cupertino&daddr=San+Francisco
    //http://maps.apple.com/?saddr=\(address)&daddr=\(userLocal)
    //iosamap://navi?sourceApplication=导航功能&backScheme=djlsj&lat=\(Double(self.map_latitude)!)&lon=\(Double(self.map_longitude)!)&dev=0&style=2
        
        let loc = CLLocationCoordinate2DMake(Double(self.map_latitude)! ,Double(self.map_longitude)!)
        let currentLocation = MKMapItem.forCurrentLocation()
        let toLocation = MKMapItem(placemark:MKPlacemark(coordinate:loc,addressDictionary:nil))
        toLocation.name = "\(address)"
        MKMapItem.openMaps(with: [currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: "true"])


        let urlString = "iosamap://navi?sourceApplication=導航功能&backScheme=djlsj&lat=\(Double(self.map_latitude)!)&lon=\(Double(self.map_longitude)!)&dev=0&style=2" as NSString

        let url = NSURL(string:urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        
  
//
//        if let mapURL = URL(string: "iosamap://navi?sourceApplication=导航功能&backScheme=djlsj&lat=\(Double(self.map_latitude)!)&lon=\(Double(self.map_longitude)!)&dev=0&style=2") {
//            if UIApplication.shared.canOpenURL(mapURL) {
//                UIApplication.shared.open(mapURL, options: [:], completionHandler: nil)
//            }
//        }
    }
    
    //let locationManager: CLLocationManager = CLLocationManager()
    
    
    var locationManager: CLLocationManager!
    var map_longitude: String = ""
    var map_latitude: String = ""
    var address: String = ""
    var startTime: String = ""
    var endTime: String = ""
    var shopName: String = ""
    var shopTel: String = ""
    var opentime: String = ""
    var closetime: String = ""
    var userLocal: String = ""

    var userLocation: CLLocation!
    var shopLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //標準地圖
        self.myMapView.mapType = MKMapType.standard
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        
        
        
        //詢問是否要開啟定位
        locationManager.requestWhenInUseAuthorization()
        //locationManager.stopUpdatingLocation()
        let nowLocation = locationManager.location?.coordinate
        
        
        
        //移動10m更新地圖
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        //取得定位精確度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        locationManager.startUpdatingLocation()

        
        //創建MKCoordinateSpan對象,設置地圖範圍
        let latDetail = 0.02
        let longDetail = 0.02
        let currentLocationSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDetail, longitudeDelta: longDetail)
        let latDouble = Double(self.map_latitude)
        let longDouble = Double(self.map_longitude)
        //自定義位置
        let center: CLLocation = CLLocation(latitude: latDouble!, longitude: longDouble!)
        self.shopLocation = center

        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        
        //設置顯示區域
        self.myMapView.setRegion(currentRegion, animated: true)
        
        //設置大頭針
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(latitude: latDouble!, longitude: longDouble!).coordinate
        
        objectAnnotation.title = shopName
        objectAnnotation.subtitle = address
        
        self.myMapView.addAnnotation(objectAnnotation)
        
        self.lblShopName.text = shopName
        self.lblAddress.text = address
        self.lblShopTEL.text = shopTel
        
        //顯示user位置
        self.myMapView.showsUserLocation = true
        //隨著user移動
        //self.myMapView.userTrackingMode = .follow
        
        let nowLocat: CLLocation = CLLocation(latitude: (nowLocation?.latitude)!, longitude: (nowLocation?.longitude)!)
        self.userLocation = nowLocat
        
        let distance: CLLocationDistance = center.distance(from: nowLocat)
        let removing = String(format: "%.2f", distance/1000)
        self.lblDistance.text = "\(removing)公里"
        
        self.lblShopTime.text = "時間:\(opentime)~\(closetime)"
        
        self.btnTel.setTitle("通話", for: .normal)
        self.btnNavigate.setTitle("導航", for: .normal)
        
        //reverseGeocode()
//        print("開店時間:\(opentime)")
//        print("關店時間:\(closetime)")
    
        
//        print(map_latitude)
//        print(map_longitude)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hidesBottomBarWhenPushed = true
        if (CLLocationManager.authorizationStatus() != .denied) {
            
        } else {
            let aleat = UIAlertController(title: "請打開定位服務", message:"定位服務未開啟,請進入系統設置>隱私>定位服務中打開開關,並允許使用定位服務", preferredStyle: .alert)
            let tempAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            }
            let callAction = UIAlertAction(title: "立即设置", style: .default) { (action) in
                let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
                if(UIApplication.shared.canOpenURL(url! as URL)) {
                    UIApplication.shared.openURL(url! as URL)
                }
            }
            aleat.addAction(tempAction)
            aleat.addAction(callAction)
            self.present(aleat, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.stopUpdatingLocation()
        } else if CLLocationManager.authorizationStatus() == .denied {
            let alertController = UIAlertController(title: "定位權限已關閉", message: "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //避免耗電,停止執行關閉定位
        locationManager.stopUpdatingLocation()
    }
    
    //地理信息反编碼
    func reverseGeocode(){
        let geocoder = CLGeocoder()
        let currentLocation = userLocation//CLLocation(latitude: 32.029171, longitude: 118.788231)
        geocoder.reverseGeocodeLocation(currentLocation!, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            //轉成繁體中文
            let array = NSArray(object: "zh-tw")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            //顯示所有信息
            if error != nil {
                //print("錯誤：\(error.localizedDescription))")
                
                return
            }
            
            if let p = placemarks?[0]{
                //print(p) //反編碼訊息
                
                var address = ""
                
                
                if let country = p.country {
                    address.append("國家：\(country)\n")
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("省份：\(administrativeArea)\n")
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("其他行政區域：\(subAdministrativeArea)\n")
                }
                if let locality = p.locality {
                    address.append("城市：\(locality)\n")
                }
                if let subLocality = p.subLocality {
                    address.append("區域：\(subLocality)\n")
                }
                if let thoroughfare = p.thoroughfare {
                    address.append("街道：\(thoroughfare)\n")
                }
                if let subThoroughfare = p.subThoroughfare {
                    address.append("門牌：\(subThoroughfare)\n")
                }
                if let name = p.name {
                    address.append("地名：\(name)\n")
                }
                if let isoCountryCode = p.isoCountryCode {
                    address.append("國家編碼：\(isoCountryCode)\n")
                }
                if let postalCode = p.postalCode {
                    address.append("郵遞區號：\(postalCode)\n")
                }
                if let areasOfInterest = p.areasOfInterest {
                    address.append("關聯地標：\(areasOfInterest)\n")
                }
                if let ocean = p.ocean {
                    address.append("海洋：\(ocean)\n")
                }
                if let inlandWater = p.inlandWater {
                    address.append("水源，湖泊：\(inlandWater)\n")
                }
                
                self.userLocal = "\(String(describing: p.addressDictionary!["FormattedAddressLines"]))"
                //print(p.addressDictionary!["FormattedAddressLines"])
                //print(address)
            } else {
                print("No placemarks!")
            }
        })
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
}
