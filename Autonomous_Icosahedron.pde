
import java.util.*;
import toxi.physics.*;
import toxi.physics.behaviors.*;
import toxi.geom.*;
import peasy.*;

PeasyCam cam;
VerletPhysics physics;
icoCloud ic;

long SEED = 83924;  //250728,

void setup() {
  size(1000, 800, P3D); 
  smooth(16);
  //hint(ENABLE_STROKE_PERSPECTIVE);
  // CAM
  cam = new PeasyCam(this, defaultCam[3]);
  cam.setMinimumDistance(0.00001);
  cam.setMaximumDistance(999999999);
  cam.setRotations(defaultCam[0], defaultCam[1], defaultCam[2]);
  cam.lookAt(0, 0, 0);

  randomSeed(SEED);
  initPhysics();

  ic = new icoCloud(4);
} // end of setup

void initPhysics() {
  physics = new VerletPhysics();
  physics.setWorldBounds(new AABB(3500*0.5));  // box size
  physics.setDrag(0.05);   // 0.05
  physics.addBehavior(new GravityBehavior(new Vec3D(0, 1.0, 0)));
}

void draw() {

  background(18, 18, 20);
  // set clipping distance
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/3.0, (float) width/height, cameraZ/100.0, cameraZ*100.0);
  //HUDas
  cam.beginHUD();
  fill(255);
  textAlign(LEFT);
  text((int)frameRate, 5, 15);
  cam.endHUD();
  //
  visualGuide();
  noFill();
  pushStyle();
  strokeWeight(1);
  stroke(255, 10);
  box(3500);
  popStyle();
  //
  //fill(255);
  //box(200);
  
  // delete spring overtime
//  for (int i=0; i<10; i++) {
//    if (physics.springs.size()>4000) {  // 4000
//      VerletSpring s = physics.springs.get(int(random(physics.springs.size())));
//      physics.springs.remove(s);
//      ic.springs_particle.remove(s);
//    } 
//    else {
//      break;
//    }
//  }
  noFill();
  blendMode(ADD);
  physics.update();
  ic.render();
} // end of draw



















////
