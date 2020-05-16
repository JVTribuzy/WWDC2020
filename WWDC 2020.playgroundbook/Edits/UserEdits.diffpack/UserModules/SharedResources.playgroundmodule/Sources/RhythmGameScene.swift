import SpriteKit

public class RhythmGameScene: SKScene{
    public let firstButton = BeatButtonNode(circleOfRadius: 30)
    public let secondButton = BeatButtonNode(circleOfRadius: 30)
    public let thirdButton = BeatButtonNode(circleOfRadius: 30)
    
    public var buttonsList: [BeatButtonNode] = [] 
    public let clock = SKShapeNode(circleOfRadius: 300)
    
    public var pointer = SKSpriteNode(color: .brown, size: CGSize(width: 10, height: 280))
    
    public var positionNodes: [PositionNode] = []
    
    public var playButton: SKShapeNode = SKShapeNode(circleOfRadius: 50)
    
    let audioPlayer = BeatPlayer(urls: [.kick, .hihat, .snare])
    
    override public func didMove(to view: SKView) {
        buttonsList = [firstButton, secondButton, thirdButton]
        backgroundColor = .purple
        setupClock()
        setupButton()
        setupPositionNodes()
        audioPlayer.start()
        setupPlayButton()
        setupPointer()
    }
}


