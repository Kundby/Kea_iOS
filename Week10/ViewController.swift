//
//  ViewController.swift
//  Week10
//
//  Created by admin on 06/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Photos
import UIKit
import FirebaseStorage

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var downloadText: UITextField!
    
    @IBOutlet weak var btnCamera: UIButton!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var btnGallery: UIButton!
    
    @IBOutlet weak var downloadImg: UIButton!
    
    
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      picker.delegate = self
    }
    
    @IBAction func galleryPressed(_ sender: AnyObject) {
        print("Gallery")
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        uploadImage()
    }
    
    
    @IBAction func cameraPressed(_ sender: Any) {
        print("Camera")
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func downloadPressed(_ sender: Any) {
        if let text = downloadText.text{
            Cloud_storage.downloadImage(name: text, vc: self)
        }else{
            print("No text in downloadText")
        }
    }
    
    
    func uploadImage(){
         let uuid = UUID().uuidString
         let storageRef = Storage.storage().reference().child("week10/" + uuid + ".jpg")
             if let uploadData = self.imageView.image!.pngData() {
                storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                       if error != nil {
                           print("error")
                           
                       } else {
                           // your uploaded photo url.
                        print("Image uploaded")
                       }
                   }
               }
    }
    
    //MARK: - Delegates
    //What to do when the picker returns with a photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
