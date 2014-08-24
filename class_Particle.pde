
class Particle extends VerletParticle {

  Particle(Vec3D pos) {
    super(pos);
  }

  void display() {
    point(x, y, z);
  }
}

///////////////////////////////////////////////////////////////////

class Connection extends VerletSpring {

  Connection(Particle p1, Particle p2, float len, float strength) {
    super(p1, p2, len, strength);
  }

  void display() {
    line(a.x, a.y, a.z, b.x, b.y, b.z);
  }
} // end of class Connection
