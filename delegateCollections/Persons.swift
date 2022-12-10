//
//  Persons.swift
//  delegateCollections
//
//  Created by MacBook Air M1 on 2022/12/10.
//

import SwiftUI

/// 「塗装技術者の称号」をもつ中島
class Nakajima: BlockPainter {
    private var maker = WoodBlockMakerA()
    private var myBlock: WoodBlock? = nil
    
    /// 自分で塗装した積み木が欲しい！
    func getWoodBlock() {
        // 塗装者は自分
        maker.delegatePainter = self
        
        // 丸の積み木作成
        myBlock = maker.makeWoodBlock(shape: .maru)
    }

    // 色塗りできます！
    func paint(block: WoodBlock) {
        block.color = .blue
    }
}

/// 塗装技術をもってない矢竹
class Yatake {
    private var makerA = WoodBlockMakerA()
    private var makerB = WoodBlockMakerB()
    
    private var myBlock1: WoodBlock? = nil
    private var myBlock2: WoodBlock? = nil
    private var myBlock3: WoodBlock? = nil
    
    private let nakajima = Nakajima()
    private let gussan = Yamaguchi()
    
    /// 色々な種類の積み木が欲しい！
    func getWoodBlocks() {
        
        // 塗装者は中島
        makerA.delegatePainter = nakajima
        // 丸の積み木作成
        myBlock1 = makerA.makeWoodBlock(shape: .maru)
        
        // 塗装者はぐっさん
        makerA.delegatePainter = gussan
        // 三角の積み木作成
        myBlock2 = makerA.makeWoodBlock(shape: .sankaku)
        
        // 四角の積み木を作成。塗装技術者の称号はないが、自力で塗装する
        myBlock2 = makerB.makeWoodBlock(
            shape: .shikaku, 
            delegatePaintFunc: paintSelfStyle   // 我流で塗る関数を渡す
        )
    }

    // 我流で塗る
    func paintSelfStyle(block: WoodBlock) {
        block.color = .orange
    }
}

/// 見かけの「塗装技術者の称号」をもつ山口
class Yamaguchi: BlockPainter {
    // func paint() {} がないぞ！？！？
    // →extensionでデフォルト実装されている
}
