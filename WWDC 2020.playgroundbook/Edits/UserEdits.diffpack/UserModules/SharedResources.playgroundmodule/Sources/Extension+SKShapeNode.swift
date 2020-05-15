import SpriteKit
import UIKit
import AVFoundation
import PlaygroundSupport

public enum SoundElement{
    case kick
    case snare
    case hihat
    
    public var description: String {
        switch self {
        case .kick: return "kick"
        case .hihat: return "hihat"
        case .snare: return "snare"
        }
    }
    
    public var file: URL{
        let bundle = Bundle.main
        switch self {
        case .kick:
            return bundle.url(forResource: "kick", withExtension: "mp3")!
        case .snare:
            return bundle.url(forResource: "snare", withExtension: "mp3")!
        case .hihat:
            return bundle.url(forResource: "hihat", withExtension: "mp3")!
        default:
            break 
        }
    }
}

extension RhythmGameScene{
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches as! Set<UITouch>){
            let location = touch.location(in: self)
        }
    }
    
    
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches as! Set<UITouch>){
            let location = touch.location(in: self)
            
            moveNode(location)
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches as! Set<UITouch>){
            let location = touch.location(in: self)
            
            plugInPosition(location)
        }
//          print(firstButton.isUserInteractionEnabled)
//          print(secondButton.isUserInteractionEnabled)
//          print(thirdButton.isUserInteractionEnabled)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches as! Set<UITouch>){
            let location = touch.location(in: self)
            
            plugInPosition(location)
        }
        print(firstButton.isUserInteractionEnabled)
        print(secondButton.isUserInteractionEnabled)
        print(thirdButton.isUserInteractionEnabled)
    }
}

extension RhythmGameScene{
    public func moveNode(_ location: CGPoint){
        
        if firstButton.contains(location){
            firstButton.zPosition = 4
            if firstButton.intersects(secondButton) || firstButton.intersects(thirdButton){
                firstButton.position = firstButton.initialPosition
                firstButton.previousPosition = firstButton.initialPosition
                firstButton.previousNodePosition = nil
            }else{
                firstButton.position = location
            }
//              secondButton.isUserInteractionEnabled = false
//              thirdButton.isUserInteractionEnabled = false
            
        } else if secondButton.contains(location){
            secondButton.zPosition = 4
            if secondButton.intersects(firstButton) || secondButton.intersects(thirdButton){
                secondButton.position = secondButton.initialPosition
                secondButton.previousPosition = secondButton.initialPosition
                secondButton.previousNodePosition = nil
            }else{
                secondButton.position = location
            }
//              firstButton.isUserInteractionEnabled = false
//              thirdButton.isUserInteractionEnabled = false
        } else if thirdButton.contains(location){
            thirdButton.zPosition = 4
            if thirdButton.intersects(firstButton) || thirdButton.intersects(secondButton){
                thirdButton.position = thirdButton.initialPosition
                thirdButton.previousPosition = thirdButton.initialPosition
                thirdButton.previousNodePosition = nil
            }else{
                thirdButton.position = location
            }
//              secondButton.isUserInteractionEnabled = false
//              firstButton.isUserInteractionEnabled = false
        }
        
        
    }
    
    public func plugInPosition(_ location: CGPoint){
        var node: BeatButtonNode? = nil
        
        if firstButton.contains(location){
            node = firstButton
//              secondButton.isUserInteractionEnabled = true
//              thirdButton.isUserInteractionEnabled = true
        } else if secondButton.contains(location){
            node = secondButton
//              firstButton.isUserInteractionEnabled = true
//              thirdButton.isUserInteractionEnabled = true
        } else if thirdButton.contains(location){
            node = thirdButton
//              secondButton.isUserInteractionEnabled = true
//              firstButton.isUserInteractionEnabled = true
        }
        
        guard node != nil else {return}
        
        guard clock.frame.contains(location) else {
            node?.position = node!.initialPosition
            node?.previousPosition = node!.initialPosition
            node?.previousNodePosition = nil
            return
        }
        
        var isInPosition = 0
        for posNode in positionNodes{
            if (node?.frame.contains(CGPoint(x: posNode.position.x, y: posNode.position.y - 100)))! && posNode.isOcupped != true{
                node?.position.x = posNode.position.x
                node?.position.y = posNode.position.y - 100
                if node?.previousNodePosition != nil{
                    node?.previousNodePosition?.isOcupped = false
                    node?.previousNodePosition?.occupedWith = nil
                }
                node?.previousNodePosition = posNode
                node?.previousPosition = node!.position
                posNode.isOcupped = true
                posNode.occupedWith = node!.soundElement
                isInPosition += 1
//                  for button in buttonsList{
//                      button.isUserInteractionEnabled = true
//                  }
                print(firstButton.isUserInteractionEnabled)
                print(secondButton.isUserInteractionEnabled)
                print(thirdButton.isUserInteractionEnabled)
            } 
        }
        if isInPosition == 0{
            node?.position = node!.previousPosition
        }
    }
}

extension RhythmGameScene{
    public func playSoundElement(_ node: SKShapeNode){
        switch node.name {
        case SoundElement.kick.description:
            audioPlayer.playBeat(withIndex: 0)
        case SoundElement.hihat.description:
            audioPlayer.playBeat(withIndex: 1)
        case SoundElement.snare.description:
            audioPlayer.playBeat(withIndex: 2)
        default:
            break 
        }
    }
}
