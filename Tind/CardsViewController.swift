//
//  CardsViewController.swift
//  Tind
//
//  Created by Tianyu Liang on 4/5/18.
//  Copyright © 2018 Tianyu Liang. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var cardImage: UIImageView!
    
    var cardOriginalCenter: CGPoint!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        cardOriginalCenter = cardImage.center
        // Do any additional setup after loading the view.
      
    }
    
    @IBAction func didPanCard(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        var k = sender.location(in: cardImage)
        if sender.state == .began {
            //cardOriginalCenter = cardImage.center
           k = sender.location(in: cardImage)
            
        } else if sender.state == .changed {
            cardImage.center = CGPoint(x: cardOriginalCenter.x + translation.x, y: cardOriginalCenter.y)
        
            //print(k.y)
            
            if(k.y > cardOriginalCenter.y && sender.velocity(in: cardImage).x > 0){
                animation(x: 3)
                //print("a")
            }else if(k.y > cardOriginalCenter.y && sender.velocity(in: cardImage).x < 0){
                animation(x: 4)
                //print("b")
            }else if(k.y < cardOriginalCenter.y && sender.velocity(in: cardImage).x > 0){
                animation(x: 1)
                //print("c")
            }else if(k.y < cardOriginalCenter.y && sender.velocity(in: cardImage).x < 0){
                animation(x: 2)
                //print("d")
            }
            
        } else if sender.state == .ended {
            if(abs(cardImage.center.x - cardOriginalCenter.x) < 50){
                UIView.animate(withDuration:0.4, delay: 0, options:[] ,
                               animations: { () -> Void in
                                self.cardImage.transform = CGAffineTransform(rotationAngle: CGFloat(0 * Double.pi / 180))
                                self.cardImage.center = self.cardOriginalCenter
                }, completion: nil)
            }else{
                UIView.animate(withDuration:0.4, delay: 0, options:[] ,
                               animations: { () -> Void in
                                
                                self.cardImage.isHidden = true
                }, completion: nil)
            }
            
        }
    }
    func animation(x: Int) {
        var value: Double
        if(x == 1){
            value = 45
        }else if (x == 2){
            value = -45
        }else if (x == 3){
            value = -45
        }else{
            value = 45
        }
        
        UIView.animate(withDuration:0.4, delay: 0, options:[] ,
                       animations: { () -> Void in
                        self.cardImage.transform = CGAffineTransform(rotationAngle: CGFloat(value * Double.pi / 180))
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        let profileViewController = segue.destination as! ProfileViewController
        profileViewController.im = cardImage.image
        
        
    }
    

}
