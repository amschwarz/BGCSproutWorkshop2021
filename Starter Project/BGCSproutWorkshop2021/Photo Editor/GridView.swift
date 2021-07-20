//
//  GridView.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/19/21.
//

import UIKit

class GridView: UIView
{
    private var gridNumber: CGFloat = 3
    private var gridLineWidth: CGFloat = 1.0
    private var gridColor: UIColor  = .white
    
    private var path = UIBezierPath()

    private var gridWidth: CGFloat
    {
        bounds.width/CGFloat(gridNumber)
    }

    private var gridHeight: CGFloat
    {
        bounds.height/CGFloat(gridNumber)
    }

    private var gridCenter: CGPoint {
        CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    override func draw(_ rect: CGRect)
    {
        drawGrid()
        gridColor.setStroke()
        path.stroke()
    }

    private func drawGrid()
    {
        path = UIBezierPath()
        path.lineWidth = gridLineWidth

        //Draw vertical lines
        for index in 1...Int(gridNumber) - 1
        {
            let start = CGPoint(x: CGFloat(index) * gridWidth, y: 0)
            let end = CGPoint(x: CGFloat(index) * gridWidth, y:bounds.height)
            path.move(to: start)
            path.addLine(to: end)
        }

        //Draw horizontal lines
        for index in 1...Int(gridNumber) - 1 {
            let start = CGPoint(x: 0, y: CGFloat(index) * gridHeight)
            let end = CGPoint(x: bounds.width, y: CGFloat(index) * gridHeight)
            path.move(to: start)
            path.addLine(to: end)
        }

        path.close()
    }
}

