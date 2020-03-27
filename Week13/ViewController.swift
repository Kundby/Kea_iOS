//
//  ViewController.swift
//  Week13
//
//  Created by admin on 27/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    var imagePicker = UIImagePickerController() // Will handle task of fetching image from iOS system
    var origImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self // Assign the object form this class to handle image picking return
        
    }

    @IBAction func GalleryBtnPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary // Type of task, camera vs gallery
        imagePicker.allowsEditing = true // Allow/disallow editing of image
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraBtnPressed(_ sender: UIButton) {
        launchCamera()
    }
    
    @IBAction func putTextBtnPressed(_ sender: UIButton) {
        if imageView.image != nil {
            let s = textField.text!
            let s2 = NSAttributedString(string: s, attributes: [.font:UIFont(name: "Georgia", size: 200)!, .foregroundColor: UIColor.white])
            let sz = imageView.image!.size
            let r = UIGraphicsImageRenderer(size:sz)
            imageView.image = r.image
                { _ in imageView.image!.draw(at: .zero)
                    s2.draw(at: CGPoint(x:30, y:sz.height-250))
            }
        }else{
            print("No image yet")
        }
    }
    
    @IBAction func removeTxtBtnPressed(_ sender: UIButton) {
        if origImage != nil {
            imageView.image = origImage
        }else{
            print("No image yet")
        }
    }
    
    fileprivate func launchCamera() {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func resizeImgBtnPressed(_ sender: UIButton) {
        if imageView.image != nil {
            imageView.image = resizeImage(image: imageView.image!, targetSize: CGSize(width:150, height: 150))
            print("Resized image")
        }
    }
    
    @IBAction func saveImgBtnPressed(_ sender: UIButton) {
        guard let selectedImage = imageView.image else{
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error{
            print(error.localizedDescription)
        }else{
            print("Success")
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage{
        let size = image.size
        
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize : CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        }else{
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            imageView.image = image
            origImage = image!
            picker.dismiss(animated: true, completion: nil)
    }
    
}

