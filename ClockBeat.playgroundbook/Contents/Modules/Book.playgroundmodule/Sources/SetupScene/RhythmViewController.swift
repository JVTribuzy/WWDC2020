import Foundation
import UIKit
import SpriteKit

public class RhythmGameViewController: UIViewController{
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    public let skView = SKView()
    public let skScene = RhythmGameScene()
    
    private func setupViewController(){
        skScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        skScene.scaleMode = .resizeFill
        skView.presentScene(skScene)
        self.view = skView
    }
}
