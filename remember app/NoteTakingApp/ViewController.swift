//
//  ViewController.swift
//  NoteTakingApp
//
//  Created by MacStudent on 2017-08-12.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import CoreLocation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate, CLLocationManagerDelegate {
    
    var mapManager = CLLocationManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var nItem : NotesList? = nil
   
    @IBOutlet weak var txtNotes: UITextView!
    
    @IBOutlet weak var imgPhoto: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var latitude = ""
    var longtitude = ""
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if nItem != nil {
            txtNotes.text = nItem?.note
            
            imgPhoto.image = UIImage(data: (nItem?.image)! as Data)
            
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                
                // The array locations stores all the user's positions, and the position 0 is the most recent one
                let location = locations[0]
                
                // Here we define the map's zoom. The value 0.01 is a pattern
                let zoom:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
                
                // Store latitude and longitude received from smartphone
                let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees( (nItem?.latitude)!)!, CLLocationDegrees( (nItem?.longtitude)!)!)
                
                // Based on myLocation and zoom define the region to be shown on the screen
                let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, zoom)
                
                // Setting the map itself based previous set-up
                mapView.setRegion(region, animated: true)
                
                // Showing the blue dot in a map
                mapView.showsUserLocation = true
        
            }
            
            mapManager.delegate = self                            // ViewController is the "owner" of the map.
            mapManager.desiredAccuracy = kCLLocationAccuracyBest  // Define the best location possible to be used in app.
            mapManager.requestWhenInUseAuthorization()            // The feature will not run in background
            mapManager.startUpdatingLocation()

        }
        else
        {
        
        mapManager.delegate = self                            // ViewController is the "owner" of the map.
        mapManager.desiredAccuracy = kCLLocationAccuracyBest  // Define the best location possible to be used in app.
        mapManager.requestWhenInUseAuthorization()            // The feature will not run in background
        mapManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // The array locations stores all the user's positions, and the position 0 is the most recent one
        let location = locations[0]
        
        // Here we define the map's zoom. The value 0.01 is a pattern
        let zoom:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        // Store latitude and longitude received from smartphone
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        // Based on myLocation and zoom define the region to be shown on the screen
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, zoom)
        
        // Setting the map itself based previous set-up
        mapView.setRegion(region, animated: true)
        
        // Showing the blue dot in a map
        mapView.showsUserLocation = true
        
        latitude = String(location.coordinate.latitude)
        longtitude = String(location.coordinate.longitude)
        
    }

    @IBAction func cancelTapped(_ sender: Any) {
        dismissVC()
        
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if nItem != nil {
            editItem()
        } else {
            newItem()
        }
        
        dismissVC()
        
    }

    func dismissVC()
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        pickerController.allowsEditing = true
        
        self.present(pickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismiss(animated: true, completion: nil)
        self.imgPhoto.image = image
    }
    
    func newItem()
    {
        let context = self.context
        let ent = NSEntityDescription.entity(forEntityName: "NotesList", in: context)
        let nItem = NotesList(entity: ent!, insertInto: context)
        
        nItem.note = txtNotes.text
        
        nItem.image = UIImagePNGRepresentation(imgPhoto.image!) as NSData?
        nItem.latitude = latitude
        nItem.longtitude = longtitude
        
        //nItem.image = imgPhoto.
        
        do{
            try context.save()
        }catch{
            return
        }
    }
    
    func editItem()
    {
        nItem?.note = txtNotes.text
        nItem!.image = UIImagePNGRepresentation(imgPhoto.image!) as NSData?
        nItem?.latitude = latitude
        nItem?.longtitude = longtitude
        
        do{
            try context.save()
        }catch{
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
}
