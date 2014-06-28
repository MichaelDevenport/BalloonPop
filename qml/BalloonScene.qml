import VPlay 1.0
import QtQuick 1.1
//...
import "entities"
Scene {
    id: balloonScene

    // provide the pop sound public for the balloons
    property alias popSound: popSound
    //...
    // the pop sound used by balloon entities
    Sound {id:popSound; source:"snd/balloonPop.wav"}
    //...

    // number of balloons currently on the scene
    property int balloons: 0
    // maximum number of balloons
    property int balloonsMax : 100
    // duration of the game
    property int time : 50
    // flag if game is running
    property bool gameRunning: false

    // position the scene on the top edge
    sceneAlignmentY: "top"

    // used to create balloons at runtime
    EntityManager {
        id: entityManager
        entityContainer: balloonScene
    }

    // make the balloons float up
    PhysicsWorld {gravity.y:1}

    // add a background image
    Image {source:"img/clouds.png"; anchors.fill:gameWindowAnchorItem}

    // the pop sound used by balloon entities
    Sound {source:"snd/balloonPop.wav"}

    // add background music
    BackgroundMusic {source:"snd/music.mp3"}
    //...
    // left wall
    Wall {height:parent.height+50; anchors.right:parent.left}
    // right wall
    Wall {height:parent.height+50; anchors.left:parent.right}
    // ceiling
    Wall {width:parent.width; anchors.bottom:parent.top}
    //...
    // HUD
    Row {
       anchors.bottom: parent.bottom
       z: 1 // make sure the HUD is always on top
       // info text area
       Text {id:infoText; width:200; height:40; text:"Loading Stephs & Lizzys balloons..."}
       // display remaining time
       Text {id:timeText; height:40; text:"Time: "+balloonScene.time ;font.family: "Marker Felt"}
    }
    //...
    // create balloons with short intervals in between
    Timer {
        interval: 20 // milliseconds
        running: true // start running from the beginning, when the scene is loaded
        repeat: true
        onTriggered: {
            // after every 20ms we create a new balloon
            entityManager.createEntityFromUrl(Qt.resolvedUrl("entities/Balloon.qml"));
            balloons++
            // if the maximum number of balloons is reached, we stop the timer and therefore the balloon creation and start the game
            if(balloons===balloonsMax) {
               running = false
               gameRunning = true
               infoText.text = "Hurry Girls!"
               //...
            }
        }
    }
    //..
    // game timer, default interval is 1 second
     Timer {
        id: gameTimer
        running: gameRunning // time only counts down if game is running
        repeat: true
        onTriggered: {
           time--
           // if time is over, or each balloon is popped, we stop the game and give the player some feedback about his success
           if(time === 0 || balloons === 0) {
              gameRunning = false
               if(balloons === 0) infoText.text = "Perfect, your quick-pop champion!"
               else if(balloons < balloonsMax/2) infoText.text = "Well, that was close...Pop em again"
               else infoText.text = "Not your day huh...try again, you can do it.."
           }
           //...
        }
     }
  }
