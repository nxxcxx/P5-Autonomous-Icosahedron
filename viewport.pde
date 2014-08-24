
double[] defaultCam = {
  0, 0, 0, 2800
};
boolean enableAxis = true, 
enableGrid = false;

void keyPressed() {
  if ( key == 'q' || key == 'Q') {
    cam.setRotations(defaultCam[0], defaultCam[1], defaultCam[2]);
    cam.lookAt(0, 0, 0);
    cam.setDistance(defaultCam[3]);
  }
  else if ( key == 'a' || key == 'A') {
    enableAxis = !enableAxis;
  }
  else if ( key == 's' || key == 'S') {
    enableGrid = !enableGrid;
  }

  else if (key == 'r' || key == 'R') {
    SEED = millis();
    randomSeed(SEED);
    println("SEED: " + SEED);
    initPhysics();
    ic = new icoCloud(4);
  }

}

void visualGuide() {
  //// world AXIS
  if (enableAxis) {
    noFill();
    strokeWeight(1);
    stroke(0, 255, 0, 128);
    line(0, 0, 0, 0, 80, 0); // y
    stroke(255, 0, 0, 128);
    line(0, 0, 0, 80, 0, 0);  // x
    stroke(0, 0, 255, 128);
    line(0, 0, 0, 0, 0, 80);  // z
    stroke(255, 50);
    box(10);
    stroke(255);
  }
  //// world GRID
  if (enableGrid) {
    stroke(255, 80);
    for (int i = 0; i < 10; i++) {
      int spc = i*50;
      pushMatrix();
      translate(-450/2, 0, -450/2);
      line(spc, 0, 0, spc, 0, 450);  // z
      line(0, 0, spc, 450, 0, spc);  // x
      popMatrix();
    }
    stroke(255);
  }
}

void mouseClicked() {
  //println(cam.getRotations());
}
