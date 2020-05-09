import SpriteKit

public class RhythmGameScene: SKScene{
    public let firstButton = SKShapeNode(circleOfRadius: 60)
    public let secondButton = SKShapeNode(circleOfRadius: 60)
    public let thirdButton = SKShapeNode(circleOfRadius: 60)
    
    public let clock = SKShapeNode(circleOfRadius: 300)
    
    override public func didMove(to view: SKView) {
        backgroundColor = .purple
        setupButton()
        setupClock()
    }
}
