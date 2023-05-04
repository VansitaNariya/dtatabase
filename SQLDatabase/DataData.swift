//
//  DataData.swift
//  SQLDatabase
//
//  Created by R93 on 20/09/34.
//

import UIKit

class DataData: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var idText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onClickSave(_ sender: UIButton) {
        
        if nameText.text == "" || idText.text == "" {
            let a = UIAlertController(title: "PLEASE FILL DATA!", message: "TextFeild Not a Blank", preferredStyle: .alert)
            let aa = UIAlertAction(title: "RETRY", style: .destructive)
            a.addAction(aa)
            self.present(a, animated: true)
        } else {
            let text2 = Int32(idText.text ?? "") ?? -1
            let text1 = nameText.text ?? ""
            if SQLHelper.shared.addItem(User(name: text1, id: text2)) == true {
                let a = UIAlertController(title: "ID ALL READY EXIST", message: "", preferredStyle: .alert)
                let aa = UIAlertAction(title: "Ok", style: .default)
                a.addAction(aa)
                self.present(a, animated: true)
            } else {
                let a = UIAlertController(title: "ARE YOU SURE", message: "", preferredStyle: .alert)
                let aa = UIAlertAction(title: "CONFIRM", style: .destructive, handler: { _ in
                    SQLHelper.shared.addData(User(name: text1, id: text2))
                })
                a.addAction(aa)
                a.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                self.present(a, animated: true)
            }
        }
        
    }
    @IBAction func onClickDelete(_ sender: UIButton) {
        if nameText.text != "" {
            name()
        } else {
            id()
        }
    }
    
    func id() {
        if idText.text == "" {
            let a = UIAlertController(title: "PLEASE FILL DATA..!", message: "Enter Your Delete Data..!", preferredStyle: .alert)
            let aa = UIAlertAction(title: "RETRY", style: .destructive)
            a.addAction(aa)
            self.present(a, animated: true)
        } else {
            let text2 = Int32(idText.text ?? "") ?? -1
            let touple = SQLHelper.shared.deleteItem(id: text2)
            
            if  touple.1 {
                let a = UIAlertController(title: touple.0, message: "", preferredStyle: .alert)
                let aa = UIAlertAction(title: "Confirm", style: .destructive, handler: { _ in
                    SQLHelper.shared.delete(id: text2)
                })
                a.addAction(aa)
                let aaa = UIAlertAction(title: "Cancle", style: .default)
                a.addAction(aaa)
                self.present(a, animated: true)
            } else {
                let a = UIAlertController(title: touple.0, message: "", preferredStyle: .alert)
                let aa = UIAlertAction(title: "OK", style: .default)
                a.addAction(aa)
                self.present(a, animated: true)
            }
        }
    }
    
    func name() {
        if nameText.text == "" {
            let a = UIAlertController(title: "PLEASE FILL DATA..!", message: "Enter Your Delete Data..1", preferredStyle: .alert)
            let aa = UIAlertAction(title: "RETRY", style: .destructive)
            a.addAction(aa)
            self.present(a, animated: true)
        } else {
            let nameText = (nameText.text)!
            let idArr = SQLHelper.shared.nameDelete(name: nameText)
            print(idArr)
            
            if idArr.count == 0{
                let a = UIAlertController(title: "Sorry..!", message: "Name Does Not Avaloable..!", preferredStyle: .alert)
                let aa = UIAlertAction(title: "OK", style: .default)
                a.addAction(aa)
                self.present(a, animated: true)
            } else if idArr.count > 1 {
                let x = UIAlertController(title: "WHICH ID YOU DELETE ?", message: "", preferredStyle: .actionSheet)

                for i in idArr {
                    x.addAction(UIAlertAction(title: "\(i)", style: .destructive,handler: { _ in
                        let a = UIAlertController(title: "ARE YOU SURE ?", message: "", preferredStyle: .alert)
                        let aa = UIAlertAction(title: "Confirm", style: .destructive,handler: { _ in
                            SQLHelper.shared.delete(id: i)
                        })
                        a.addAction(aa)
                        a.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(a, animated: true)
                    }))
                }
                x.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
                self.present(x, animated: true)
            } else {
                let a = UIAlertController(title: "ARE YOU SURE ?", message: "", preferredStyle: .alert)
                let aa = UIAlertAction(title: "Confirm", style: .destructive,handler: { _ in
                    SQLHelper.shared.delete(id: idArr[0])
                })
                a.addAction(aa)
                a.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(a, animated: true)
            }
        }
    }
}
