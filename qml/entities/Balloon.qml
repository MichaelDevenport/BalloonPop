import QtQuick 1.1
import VPlay 1.0

EntityBase {
   entityType: "balloon"

   CircleCollider {
       radius: sprite.width/2
       anchors.centerIn: parent
       // restitution is bounciness, balloons are quite bouncy
       fixture.restitution: 0.5
   }

   MultiResolutionImage {
      id: sprite
      source: "../img/balloon-hd.png"
      anchors.centerIn: parent
   }

   MultiTouchArea {
      anchors.fill: sprite
      onPressed: {
        // if you touch a balloon and the game is running, it will pop
        if(balloonScene.gameRunning) {
           balloonScene.balloons--
           balloonScene.popSound.play()
           removeEntity()
        }
      }
   }

   // gives the balloon a random position when created
   Component.onCompleted: {
      x = utils.generateRandomValueBetween(15,balloonScene.width-15)
      y = balloonScene.height
   }
}
