//
//  WoodBlockMaker.swift
//  delegateCollections
//
//  Created by MacBook Air M1 on 2022/12/10.
//

import SwiftUI

enum BlockShape {
    case maru
    case sankaku
    case shikaku
    
    case genboku
}

// 積み木
class WoodBlock {
    var shape: BlockShape = .genboku    // 形状
    var color: Color = .clear           // 色
    var surfaceCoated: Bool = false     // 表面コーティング済みか
}

/* ---------------------------------------------- */
protocol BlockPainter: AnyObject {
    func paint(block: WoodBlock)
}

extension BlockPainter {
    func paint(block: WoodBlock) {
        block.color = .black
    }
}
/* ---------------------------------------------- */

/// 積み木を作るプロ。（だが色塗りはできない）
// 塗装技術者の称号を持った人(＝プロトコル準拠した人)を紹介すれば、積み木を作ってくれる
class WoodBlockMakerA {
    weak var delegatePainter: BlockPainter? = nil   // 塗装技術者の称号を持った人

    /// 積み木を作る
    func makeWoodBlock(shape: BlockShape) -> WoodBlock? {

        // 色を塗る人が決まってないと、積み木を作れない
        guard delegatePainter != nil else {
            return nil
        }

        // 積み木の原木を調達
        let block = WoodBlock()

        // 木を切り出す
        cutWood(block: block, shape: shape)

        // 色を塗る
        delegatePainter?.paint(block: block)

        // 表面をコーティングする
        coatBlock(block: block)
        
        return block    // 積み木が完成しました！
    }

    /// 木を切り出す
    private func cutWood(block: WoodBlock, shape: BlockShape) {
        block.shape = shape
    }

    /// 表面をコーティングする
    private func coatBlock(block: WoodBlock) {
        block.surfaceCoated = true
    }
}

/* ---------------------------------------------- */

/// 積み木を作るプロ。（だが色塗りはできない）
// 塗装技術者の称号を持った人を紹介しなくても、積み木を作ってくれる
class WoodBlockMakerB {

    /// 積み木を作る
    func makeWoodBlock(
        shape: BlockShape, 
        delegatePaintFunc: (WoodBlock) -> Void      // 関数が引数
    ) -> WoodBlock? {

        // 積み木の原木を調達
        let block = WoodBlock()

        // 木を切り出す
        cutWood(block: block, shape: shape)

        // 色を塗る
        delegatePaintFunc(block)

        // 表面をコーティングする
        coatBlock(block: block)
        
        return block    // 積み木が完成しました！
    }

    /// 木を切り出す
    private func cutWood(block: WoodBlock, shape: BlockShape) {
        block.shape = shape
    }

    /// 表面をコーティングする
    private func coatBlock(block: WoodBlock) {
        block.surfaceCoated = true
    }
}
