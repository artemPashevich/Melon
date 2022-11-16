//
//  FireBaseRequest.swift
//  Melon
//
//  Created by Артем Пашевич on 28.09.22.
//

import UIKit
import Firebase
import FirebaseStorage


class Request {

    static var shared: Request = {
            let instance = Request()
        return instance
        }()
    
    private init() {}
        
     func registration(emailTF: UITextField, phoneTF: UITextField, passwordTF: UITextField) {
         Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { result, error in
             if error == nil {
                 if let result = result {
                     let ref = Database.database().reference().child("Users")
                     ref.child(result.user.uid).updateChildValues(["Phone": phoneTF.text!, "Email": emailTF.text!])
                    // go to app
                 } else {
                     passwordTF.text = ""
                     emailTF.text = ""
                 }
             }
         }
    }
    
    func logIn(emailTF: UITextField, passwordTF: UITextField) {
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { _, error in
                    if error == nil {
                        
                    } else {
                        passwordTF.text = ""
                        emailTF.text = ""
                    }
                }
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage) -> Void) {
        let ref = Storage.storage().reference(forURL: url)
        let megaBate = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megaBate) { data, _ in
            guard let imageData = data else { return }
            let image = UIImage(data: imageData)
            completion(image!)
        }
    }
    
    func upload(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        
       let photo = Photo(image: photo)
        
       let ref = Storage.storage().reference().child(photo.uuid) // уникальный id photo

        let imageData = (photo.image?.jpegData(compressionQuality: 0.4))!

        ref.putData(imageData) { metadata, error in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            ref.downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
    }
    
    private var imageCashe = NSCache<NSString, UIImage>()
    
    func downloadImageWithCache(urlString: String, complition: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCashe.object(forKey: urlString as NSString) {
            complition(cachedImage)
        } else {
            guard let url = URL(string: urlString) else { return }
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                if let error = error {
                    print(error)
                }
                
                guard let image = UIImage(data: data!) else { return }
                self?.imageCashe.setObject(image, forKey: urlString as NSString)
                
                DispatchQueue.main.async {
                    complition(image)
                }
            }.resume()
        }
    }
    
}
