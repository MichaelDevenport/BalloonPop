import QtQuick 1.1
import VPlay 1.0
import Box2D 1.0 // for accessing the Body.Static type

entityBase {
   entityType: "wall"
   // default width and height
   width: 1
   height: 1

   // only collider since we want the wall to be invisible
   BoxCollider {
     anchors.fill: parent
     bodyType: Body.Static // the body shouldn't move
   }
}

