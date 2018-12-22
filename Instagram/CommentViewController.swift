//
//  CommentViewController.swift
//  Instagram
//
//  Created by 佐々木　祐太 on 2018/12/21.
//  Copyright © 2018 佐々木　祐太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CommentViewController: UIViewController, UITextFieldDelegate {
    
    var postData: PostData!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendCommentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextField.delegate = self
        //送信ボタンの無効
        sendCommentButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    //送信ボタン
    @IBAction func sendCommentButton(_ sender: UIButton) {
        print("DEBUG_PRINT:コメントを送信しました")
        //commentTextFieldのテキストに自分の表示名を加えたものをcommentデータとして追加　このとき配列として一番最後に追加
        let name: String? = Auth.auth().currentUser?.displayName
        let preComments = commentTextField.text
        let postComments = "\(name!):\(preComments!)"
    
        postData.comments.append(postComments)
    
        // postsフォルダのユニークフォルダ
        let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
        // パス作る
        let comments = ["comments": postData.comments]
        // 保存
        postRef.updateChildValues(comments)
        
        self.dismiss(animated: true, completion: nil)
   
        
    }
    
    //キャンセルボタン
    @IBAction func cancelButon(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ビューのタップ
    @IBAction func tapView(_ sender: Any) {
        view.endEditing(true)  // キーボードを下げる
    }
    //エンターキー
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)  // キーボードを下げる
        //コメントがあるときのみ送信可能
        if commentTextField.text == "" {
            sendCommentButton.isEnabled = false
        }else{
            sendCommentButton.isEnabled = true
        }
        return false
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
