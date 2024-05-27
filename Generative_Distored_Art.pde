PImage img; /* This built in class allows us to display an image and access 
properties which allow us to change or adjust an image */

int totalLines = 80000;  // Increase total number of lines to draw for more detail
int linesDrawn = 0;      // Counter for the number of lines drawn
int linesPerFrame = 50;  // Number of lines to draw per frame
float noiseScale = 0.01; // Scale of the Perlin noise for finer control

void setup() {
  size(1482, 1000); // size of the canvas
  img = loadImage("Grace-Hopper.jpg"); // The image you want to be drawn with the distored effect
  img.resize(width, height);  // Resize the image to fit the canvas
  background(255);
  noFill();
}

void draw() {
  /*linesPerFrame and totalLines, 
  control the number of lines drawn in each frame
  and the overall number of lines drawn the outer for loop basically
  allows for the image to keep being drawn as long as the following 
  condition are met within the for loop arugment */
  
  for (int i = 0; i < linesPerFrame && linesDrawn < totalLines; i++) {
    // Generate random starting point
    float x0 = random(width);
    float y0 = random(height);
    
    /*The noise function is used to generate smooth, 
    pseudo-random values based on the x0, y0, and noiseScale values */
    
    float x1 = x0 + noise(x0 * noiseScale, y0 * noiseScale) * 50 - 25;
    float y1 = y0 + noise(x0 * noiseScale, y0 * noiseScale + 10000) * 50 - 25;
    
    // This Gets the color of the midpoint between (x0, y0) and (x1, y1)
    float midX = (x0 + x1) / 2;
    float midY = (y0 + y1) / 2;
    /* This line is sampling the color value from the original image
    so the correct colors are applied */
    color c = img.get(int(midX), int(midY));
    
   
    stroke(c);
    strokeWeight(1);
    
    
    //The beignShape function is used to record vertices
    
    beginShape();
    /* this inner loop is responsible for generating the smooth,
    curved, and swirly lines that make up the image.
    It does this by iterating along the line segment between the start and end points, 
    adding noise-based perturbations to create the swirly effect. */
    
    for (float t = 0; t <= 1; t += 0.01) {
      /*The xt and yt values are calculated by adding the offset to the interpolated points. 
      The offset is determined by the noise function */
      float xt = lerp(x0, x1, t) + noise(t * 10, frameCount * 0.1) * 5 - 2.5;
      float yt = lerp(y0, y1, t) + noise(t * 10 + 1000, frameCount * 0.1) * 5 - 2.5;
      
      // The vertex function is used to specify the cordinates of a vertex
      vertex(xt, yt);
    }
    //This stops the recording of vertices
    endShape();
    
    //allows for lines to repeatedly drawn
    linesDrawn++;
  }
  
  if (linesDrawn >= totalLines) {
    // Stop drawing once the entire image is drawn
    noLoop();
  }
}
//Code written by Callum Thomas
