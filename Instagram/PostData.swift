//
//  PostData.swift
//  Instagram
//
//  Created by 佐々木　祐太 on 2018/12/21.
//  Copyright © 2018 佐々木　祐太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
// 投稿後のデータ
// データの置き換えしてる
class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var comments: [String] = []
    var sentence: String?
    init(snapshot: DataSnapshot, myId: String) {
        // データのidを取得
        self.id = snapshot.key
        // データを辞書として取得
        let valueDictionary = snapshot.value as! [String: Any]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
        
        self.name = valueDictionary["name"] as? String
        
        self.caption = valueDictionary["caption"] as? String
        
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        // (表示名:キャプション)の文字列作成
        let postCaption: String! = "\(self.name!):\(self.caption!)"
        
        if let comments = valueDictionary["comments"] as? [String] {
            self.comments = comments
        }
        // キャプションとコメントを合体させてsentenceデータを作成
        // commentsの全要素を出す。→\nを挟みながら合体
        var preSentence = ""
        for item in comments{
            preSentence += item + "\n"
        }

        self.sentence = postCaption + "\n" + preSentence
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in self.likes {
            if likeId == myId {
                self.isLiked = true
                break
            }
        }
    }
    
}






