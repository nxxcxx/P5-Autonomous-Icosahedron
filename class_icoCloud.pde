
class icoCloud {

  ArrayList<Vec3D> vertexList = new ArrayList<Vec3D>();

  ArrayList<Particle> particles;
  ArrayList<Particle> anchors;
  Particle centerAnchor;

  ArrayList<Connection> springs_particle;
  ArrayList<Connection> springs_centerAnchor;
  ArrayList<Connection> springs_pullerAnchor;

  int subDivision;
  float icoRadius = 600;
  float glen = 50;    // search distance
  float gstr = 1;  // grid spring strength
  float alen = 0;     // anchor spring length
  float astr = 1;     // anchor spring strength

  icoCloud(int _subDivision) {
    subDivision = _subDivision;

    particles = new ArrayList<Particle>();
    springs_particle = new ArrayList<Connection>();
    springs_centerAnchor = new ArrayList<Connection>();
    springs_pullerAnchor = new ArrayList<Connection>();
    anchors = new ArrayList<Particle>();
    initIcoVertex();
    initIcoParticles();
    initIcoConnections();
  }

  void initIcoVertex() {
    Icosahedron ico = new Icosahedron(subDivision);
    for ( int i = 0; i < ico.vertexNormalsList.size(); i+=3 ) {
      float x = ico.vertexNormalsList.get(i) * icoRadius;
      float y = ico.vertexNormalsList.get(i+1) * icoRadius;
      float z = ico.vertexNormalsList.get(i+2) * icoRadius;
      Vec3D v = new Vec3D(x, y, z);
      boolean add = true;
      for ( int j = 0; j < vertexList.size(); j+=1 ) {
        Vec3D v1 = vertexList.get(j);
        if (v.equals(v1)) {
          add = false;
          continue;
        }
      }
      if (add) vertexList.add(v);
    }
    println("NUM_VERTEX: " + vertexList.size());
  }  // end of initIsoVertex

  void initIcoParticles() {
    for (int i=0; i<vertexList.size(); i++) {
      Vec3D v = vertexList.get(i);
      Particle p = new Particle(v);
      physics.addParticle(p);
      particles.add(p);
    }

    //debug distance
    /*
    ArrayList<Float> dis = new ArrayList();
     for (int i=0; i<vertexList.size(); i++) {
     Vec3D v = vertexList.get(i);
     for (int j=i; j<vertexList.size(); j++) {
     Vec3D v1 = vertexList.get(j);
     dis.add(v.distanceTo(v1));
     }
     }
     Collections.sort(dis);
     println(dis);
     */
  }  // end of initIsoParticles

  void initIcoConnections() {
    // init cloud spring
    for (int i=0; i<particles.size(); i++) {
      Particle p = particles.get(i);
      for (int j=i; j<particles.size(); j++) {
        Particle p1 = particles.get(j);
        if ( !(p.equals(p1)) && (p.distanceTo(p1) < glen) ) {
          float len = p.distanceTo(p1);
          Connection c =new Connection(p, p1, len, 0.05);  //*********** spring settings  0.05
          physics.addSpring(c);
          springs_particle.add(c);
        }
      }
    }

    // init center spring anchor
    centerAnchor = new Particle(new Vec3D(0, 0, 0));
    for (int i=0; i<particles.size(); i++) {
      Particle p = particles.get(i);
      Connection c = new Connection(p, centerAnchor, icoRadius, 0.0165);  //*********** spring settings  0.017
      physics.addSpring(c);
      springs_centerAnchor.add(c);
    }

    // init anchors (puller)
    for (int i=0; i<40; i++) {  //40
      Particle p = particles.get(int(random(particles.size())));

      Vec3D newPos = p.copy();
      newPos.normalize();
      newPos.scaleSelf(random(800, 1200));  // 600,1200
      Particle p1 = new Particle(newPos);
      physics.addParticle(p1);
      particles.add(p1);
      p1.lock();

      //float len = p.distanceTo(p1);
      Connection c = new Connection(p, p1, 0, 0.175);  //*********** spring settings  0.2
      physics.addSpring(c);
      springs_pullerAnchor.add(c);
    }
  }  // end of initIsoConnections

  void render() {

    strokeWeight(1);
    stroke(#3E89FF, 127);
    for (Connection c : springs_particle) {
      c.display();
    }
    
    for (Connection c : springs_pullerAnchor) {
      c.display();
      // display ellipse at puller
      pushMatrix();
      Vec3D dir = c.b.copy().normalize();
      Vec3D orien = new Vec3D(0, 0, 1).normalize();
      Vec3D axis = orien.cross(dir);
      float theta = orien.angleBetween(dir);
      translate(c.b.x, c.b.y, c.b.z);
      rotate(theta, axis.x, axis.y, axis.z);
      ellipse(0, 0, 40, 40);
      popMatrix();
    }
    
    strokeWeight(3);
    stroke(#3EBDFF, 200);
    for (Particle p : particles) {
      p.display();
    }
    
  }  // end of render
}// end of class






























////
