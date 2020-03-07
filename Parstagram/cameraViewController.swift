//
//  cameraViewController.swift
//  Parstagram
//
//  Created by Mubarek Mussa on 2/26/20.
//  Copyright © 2020 eventFind. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse


class cameraViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var image: UIImageView!
   
    @IBOutlet weak var comment: UITextField!
    
    @IBAction func sumbitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        post["caption"] = comment.text!
        post["author"] = PFUser.current()!
        let imageData = image.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            }
            else{
                print("failed")
            }
        }
        
        
    }
    
    @IBAction func onCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
        } else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let Simage = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        
        let scaledImage = Simage.af_imageAspectScaled(toFill: size)
        image.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
