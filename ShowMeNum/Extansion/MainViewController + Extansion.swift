//
//  MainViewController + Extansion.swift
//  ShowMeNum
//
//  Created by Aleksey Alyonin on 23.10.2023.
//

import UIKit

//MARK: - Move view after show/hide keyboard
extension MainViewController {
    
    @objc func hidenKayBoard(){
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShowNotification(notification: NSNotification){
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyBoardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyBeardY = self.view.frame.height - keyBoardSize.height
        let editingTextField = inputNun.convert(inputNun.bounds, to: self.view).minY;
        
        let screen = UIScreen.main.bounds.height / 3.3
        
        if self.view.frame.minY >= 0
        {
            if editingTextField > keyBeardY - screen
            {
                UIView.animate(withDuration: 0.1,
                               delay: 0.0,
                               options: UIView.AnimationOptions.curveEaseInOut)
                {
                    self.view.frame = CGRect(
                        x: 0,
                        y:self.view.frame.origin.y-(editingTextField-keyBeardY + screen),
                        width: self.view.frame.width,
                        height: self.view.bounds.height)
                }
            }
        }
    }
    
    @objc func keyBoardWillHide(){
        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseIn)
        {
            self.view.frame = CGRect(
                x: 0,
                y: 0,
                width: self.view.frame.width,
                height: self.view.bounds.height)
        }
    }
}
