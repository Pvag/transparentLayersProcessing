// An example of how to draw on different layers, without leaving a trail,
// as explained on my blog at: http://paolovagnini.blogspot.com/2019/09/transparent-background-with-multiple.html

// canvas: fixed red dot, in the middle of the screen
// layerDots: green dots (on dragging)
// layerRect: interactive violet rectangle (on dragging)

// INTERACTIONS
// ============
// press 's' to save the drawing in the sketch folder
// press spacebar to clear layerDots

// Author: Paolo Vagnini ( paolondon at gmail dot com )
// Date: 3 Sep. 2019


PGraphics layerDots; // layer added on top of canvas
PGraphics layerRect; // layer added on top of layerDots

void setup() {
  size(400, 200);
  noStroke();
  fill(255, 0, 0); // red for the dot fixed on the canvas
  
  layerDots = createGraphics(width, height);
  layerRect = createGraphics(width, height);
  
  // specify settings for layerDots
  layerDots.beginDraw();
  layerDots.fill(0, 255, 0); // green filling
  layerDots.noStroke();
  layerDots.endDraw();
  
  // specify settings for layerRect
  layerRect.beginDraw();
  layerRect.noFill();
  layerRect.stroke(150, 90, 200); // violet filling
  layerRect.strokeWeight(6);
  layerRect.endDraw();
}

void draw() {
  // draw directly on canvas
  background(0);
  ellipse(width/2, height/2, 30, 30); // draw the red fixed dot

  layerDots.beginDraw();
  layerDots.ellipse(random(width), random(height), 10, 10);
  layerDots.endDraw();
  
  // actually draw the 2 layers
  image(layerDots, 0, 0); // render layerDots on top of the canvas
  image(layerRect, 0, 0); // render layerRect on top of layerDots
}

// drag mouse to draw dynamically
void mouseDragged() {
  layerRect.beginDraw();
  // interesting part: setting a fully transparent (0 opacity, i.e. 0 as alpha value) background
  // to any color, will not show its color, but will make any previous drawing made on that layer
  // disappear. This behavior is different to the one you get with fill and then rect (typically
  // used for fading trails). This way, you can add layers on top of each other and they will allow
  // for the lower layers to be seen perfectly; at the same time, the layer will be clean, if
  // desired so, containing only the actual stroke / object made at a particular frame.
  layerRect.background(0, 0); // can draw on this, but fully transparent background --> layerDots will be visible
  layerRect.rect(15, 15, mouseX, mouseY);
  layerRect.endDraw();
}

// clear layerDots pressing the spacebar
void keyPressed() {
  if (key == ' ') {
    layerDots.beginDraw();
    layerDots.background(255, 0);
    layerDots.endDraw();
  }
  else if (key == 's') {
    save("beauty.png");
  }
}
