int margin = 60;
int plotX1, plotX2, plotY1, plotY2;
int radi;
Float x_1, x_2, y_1, y_2;
Table table; // Create a table object
PFont font;
/**
 initialize our button state values.
 */
boolean sixty_buttonstate = true;
boolean seventy_buttonstate = true;
boolean eighty_buttonstate = true;
boolean ninety_buttonstate = true;
boolean hundred_buttonstate = true;

/**
 Visualisation code was adapted from CS142 Lab 2 .
 
 This visualisation uses data from the OpenPowerlifting project, https://www.openpowerlifting.org.
 You may download a copy of the data at https://gitlab.com/openpowerlifting/opl-data.
 
 Font can be accessed from: https://fonts.google.com/specimen/IBM+Plex+Mono?selection.family=IBM+Plex+Mono
 
 Color pallete was created using: https://coolors.co/
 */
void setup() {
  size(1280, 720);
  table = loadTable("data/powerlift_top_data_final.csv", "csv"); //Initialise the table with values from out csv file
  plotX1 = margin;
  plotX2 = width - margin;
  plotY1 = margin;
  plotY2 = height - margin;
  radi = 20;
  font = createFont("IBMPlexMono-Medium.ttf", 20); // Initalizes the font used in this graph
  textFont(font);
} //setup

/**
 Draws the outline for our visualisation.
 */
void draw() {
  background(#FFF7F7); // Sets background colour
  drawPlotArea();
  drawTitle();
  drawXlabels();
  drawYlabels();
  drawButtons();
  drawScatter();
}

/**
 Checks these statements if a key is pressed. 
 */
void keyPressed() {
  if (key == 's') {
    save("output.png");
  }
  if (key == 'c') { // Clears the changes we made by clicking the buttons and setting the graph back to its original state
    sixty_buttonstate = true;
    seventy_buttonstate = true;
    eighty_buttonstate = true;
    ninety_buttonstate = true;
    hundred_buttonstate = true;
  }
}

/**
 Draws rectangle where the data will be plotted.
 */
void drawPlotArea() {
  fill(#F2F2F2);
  rectMode(CORNERS);
  noStroke();
  rect(plotX1, plotY1, plotX2, plotY2); // Draws rectangle inside the margins
}


/**
 Draws the title for our visualisation.
 */
void drawTitle() {
  textSize(25);
  textAlign(CENTER, CENTER);
  fill(#0A0A0A);
  text("Top Powerlifting Total Compared To Year. ", 360, plotY1 * 0.5);
}

/**
 Draws all scatter plots for each weight class
 */
void drawScatter() {
  sixty_draw();
  seventy_draw();
  eighty_draw();
  ninety_draw();
  hundred_draw();
}

/**
 Draws labels for our x axes
 */
void drawXlabels() {
  textAlign(CENTER, CENTER);
  textSize(15);
  text("Year", 640, plotY2+30);
  textSize(15);
  for (int i = 1995; i <= 2020; i++) {
    float x = map_X(i);
    if (i % 5 == 0) { // Only creates text when the current value is divisble by 5
      fill(#0A0A0A);
      text(i, x, plotY2 + 15);
      stroke(10);
      strokeWeight(3);
      line(x, plotY2-5, x, plotY2); // Draws marking on the axes to make it easier to indicate what value the point is.
    } else if (i % 5 != 0) {
      stroke(10);
      strokeWeight(1);
      line(x, plotY2 - 5, x, plotY2); // Draws marking with a lighter stroke
    }
  }
}

/**
 Draws labels for our y axes
 */
void drawYlabels() {
  textSize(15);
  textAlign(CENTER, CENTER);
  pushMatrix();
  translate(plotX1 - 45, 360);
  rotate(HALF_PI*3); // Rotates the translated values by 270 degrees
  text("Overall Total (kg)", 0, 0);
  popMatrix();
  for (int i = 300; i <= 1200; i++) {
    Float y = map_Y(i);
    if ((i % 300 == 0)) { // Only creates text when the current value is divisble by 300
      fill(#0A0A0A);
      text(i, plotX1 - radi, y);
      if (i != 300) {
        stroke(10);
        strokeWeight(3);
        line(plotX1, y, plotX1 + 5, y); // Draws marking on the axes to make it easier to indicate what value the point is.
      }
    } else if ((i % 50 == 0)) {
      stroke(10);
      strokeWeight(1);
      line(plotX1, y, plotX1 + 5, y); // Draws marking with a lighter stroke
    }
  }
}

/**
 Draws our buttons for each weight class 
 */
void drawButtons() { 
  noStroke();
  ellipseMode(CENTER);
  fill(#DF2935);
  textSize(15);
  textAlign(CENTER, CENTER);
  text(" -60kg", plotX2 - radi, 0.5 * plotY1);
  ellipse(plotX2 - 50, 0.5*plotY1, radi, radi);
  fill(#995D81);
  text(" -70kg", plotX2 - 120, 0.5 * plotY1);
  ellipse(plotX2 - 150, 0.5*plotY1, radi, radi);
  fill(#FDCA40);
  text(" -80kg", plotX2 - 220, 0.5 * plotY1);
  ellipse(plotX2 - 250, 0.5*plotY1, radi, radi);
  fill(#5ACAEA);
  text(" -90kg", plotX2 - 320, 0.5 * plotY1);
  ellipse(plotX2 - 350, 0.5*plotY1, radi, radi);
  fill(#3BB273);
  text(" -100kg", plotX2 - 415, 0.5 * plotY1);
  ellipse(plotX2 - 450, 0.5*plotY1, radi, radi);
  fill(#0A0A0A);
  textSize(10);
  text("Weight Class:", plotX2 - 500, 0.5 * plotY1);
}

/**
 Checks if the mouse is clicked and if the location it was clicked corresponds to
 any buttons
 */
void mouseClicked() { 
  if (overellipse(plotX2 - 450, 0.5 * plotY1, radi)) { // 100kg button
    hundred_buttonstate = update(hundred_buttonstate); // Updates the state of the button
  }
  if (overellipse(plotX2 - 350, 0.5 * plotY1, radi)) { // 90kg button
    ninety_buttonstate = update(ninety_buttonstate);
  }
  if (overellipse(plotX2 - 250, 0.5 * plotY1, radi)) { // 80kg button
    eighty_buttonstate = update(eighty_buttonstate);
  }
  if (overellipse(plotX2 - 150, 0.5 * plotY1, radi)) { // 70kg button
    seventy_buttonstate = update(seventy_buttonstate);
  }
  if (overellipse(plotX2 - 50, 0.5 * plotY1, radi)) { // 60kg button
    sixty_buttonstate = update(sixty_buttonstate);
  }
}

/**
 Updates a button value by negating its 
 current value.
 */
boolean update(boolean button) { // Negates the button value
  if (button == false) {
    return true;
  } else {
    return false;
  }
}

/**
 Function was adapted from a function found in a button example from
 the processing website: https://processing.org/examples/button.html
 */
boolean overellipse(float x, float y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}


/**
 Maps x values from our table to suitable values for our graph plot
 */
Float map_X(float x) { 
  float map_x;
  map_x = map(x, 1995, 2020, plotX1, plotX2);
  return map_x;
}
/**
 Maps y values from our table to suitable values for our graph plot
 */
Float map_Y(float y) { 
  float map_y;
  map_y = map(y, 300, 1200, plotY2, plotY1);
  return map_y;
}


/**
 Draws our scatter line plot for our values in each weight class
 */
void sixty_draw() {
  if (sixty_buttonstate == true) { // If the button has not been pressed
    for (int i = 1; i < 22; i++) {
      Float x_1 = table.getFloat(i, 0); // Getting values from the table.
      Float y_1 = table.getFloat(i, 1);
      Float x_2 = table.getFloat(i - 1, 0);
      Float y_2 = table.getFloat(i - 1, 1);
      if (i > 1) { // Only creates a line between two points if i > 1 (to not draw a trailing line).
        stroke(#DF2935);
        strokeWeight(3);
        line(map_X(x_1), map_Y(y_1), map_X(x_2), map_Y(y_2)); // Draws a line between each point
      }
    }
    for (int i = 1; i < 22; i++) {
      Float x_1 = table.getFloat(i, 0); 
      Float y_1 = table.getFloat(i, 1);
      noStroke();
      fill(#DF2935);
      ellipse(map_X(x_1), map_Y(y_1), radi, radi); // Draws a ellipse for each point in the table
      if (overellipse(map_X(x_1), map_Y(y_1), radi)) { // If we are hovering over a scatter point
        textSize(15);
        fill(#0A0A0A);
        textAlign(CENTER, CENTER);
        text(y_1 + "kg", map_X(x_1), map_Y(y_1) + 15); // Displays the current kg value next to the point
      }
    }
  } else { // If button has been pressed, doesn't draw plot.
    fill(#DF2935); 
    stroke(#8e1d24); 
    strokeWeight(2); // Add a outline to the button to indicate it hasn't been pressed
    ellipse(plotX2 - 50, 0.5 * plotY1, radi, radi);
  }
}


void seventy_draw() {
  if (seventy_buttonstate == true) {
    for (int i = 1; i < 23; i++) {
      x_1 = table.getFloat(i, 2);
      y_1 = table.getFloat(i, 3);
      x_2 = table.getFloat(i - 1, 2);
      y_2 = table.getFloat(i - 1, 3);
      if (i > 1) {
        stroke(#995D81);
        strokeWeight(3);
        line(map_X(x_1), map_Y(y_1), map_X(x_2), map_Y(y_2));
      }
    }
    for (int i = 1; i < 23; i++) {
      x_1 = table.getFloat(i, 2);
      y_1 = table.getFloat(i, 3);
      noStroke();
      fill(#995D81);
      ellipse(map_X(x_1), map_Y(y_1), radi, radi);
      if (overellipse(map_X(x_1), map_Y(y_1), radi)) {
        textSize(15);
        fill(#0A0A0A);
        textAlign(CENTER, CENTER);
        text(y_1 + "kg", map_X(x_1), map_Y(y_1) + 15);
      }
    }
  } else {
    fill(#995D81);
    stroke(#553548);
    strokeWeight(2);
    ellipse(plotX2 - 150, 0.5 * plotY1, radi, radi);
  }
}


void eighty_draw() {
  if (eighty_buttonstate == true) {
    for (int i = 1; i < 21; i++) {
      x_1 = table.getFloat(i, 4);
      y_1 = table.getFloat(i, 5);
      x_2 = table.getFloat(i - 1, 4);
      y_2 = table.getFloat(i - 1, 5);
      if (i > 1) {
        stroke(#FDCA40);
        strokeWeight(3);
        line(map_X(x_1), map_Y(y_1), map_X(x_2), map_Y(y_2));
      }
    }
    for (int i = 1; i < 21; i++) {
      x_1 = table.getFloat(i, 4);
      y_1 = table.getFloat(i, 5);
      noStroke();
      fill(#FDCA40);
      ellipse(map_X(x_1), map_Y(y_1), radi, radi);
      if (overellipse(map_X(x_1), map_Y(y_1), radi)) {
        textSize(15);
        fill(#0A0A0A);
        textAlign(CENTER, CENTER);
        text(y_1 + "kg", map_X(x_1), map_Y(y_1) + 15);
      }
    }
  } else {
    fill(#FDCA40);
    stroke(#ab8b33);
    strokeWeight(2);
    ellipse(plotX2 - 250, 0.5 * plotY1, radi, radi);
  }
}


void ninety_draw() {
  if (ninety_buttonstate == true) {
    for (int i = 2; i < 23; i++) {
      x_1 = table.getFloat(i, 6);
      y_1 = table.getFloat(i, 7);
      x_2 = table.getFloat(i - 1, 6);
      y_2 = table.getFloat(i - 1, 7);
      if (i > 1) {
        stroke(#5ACAEA);
        strokeWeight(3);
        line(map_X(x_1), map_Y(y_1), map_X(x_2), map_Y(y_2));
      }
    }
    for (int i = 1; i < 23; i++) {
      x_1 = table.getFloat(i, 6);
      y_1 = table.getFloat(i, 7);     
      noStroke();
      fill(#5ACAEA);
      ellipse(map_X(x_1), map_Y(y_1), radi, radi);
      if (overellipse(map_X(x_1), map_Y(y_1), radi)) {
        textSize(15);
        fill(#0A0A0A);
        textAlign(CENTER, CENTER);
        text(y_1 + "kg", map_X(x_1), map_Y(y_1) + 15);
      }
    }
  } else {
    fill(#5ACAEA);
    stroke(#377f93);
    strokeWeight(2);
    ellipse(plotX2 - 350, 0.5 * plotY1, radi, radi);
  }
}


void hundred_draw() {
  if (hundred_buttonstate == true) {
    for (int i= 1; i < 24; i++) {
      x_1 = table.getFloat(i, 8);
      y_1 = table.getFloat(i, 9);
      x_2 = table.getFloat(i - 1, 8);
      y_2 = table.getFloat(i - 1, 9);
      if (i > 1) {
        stroke(#3BB273);
        strokeWeight(3);
        line(map_X(x_2), map_Y(y_2), map_X(x_1), map_Y(y_1));
      }
    }
    for (int i= 1; i < 24; i++) {
      x_1 = table.getFloat(i, 8);
      y_1 = table.getFloat(i, 9);
      noStroke();
      fill(#3BB273);
      ellipse(map_X(x_1), map_Y(y_1), radi, radi);
      if ((overellipse(map_X(x_1), map_Y(y_1), radi))) {
        textSize(15);
        fill(#0A0A0A);
        textAlign(CENTER, CENTER);
        text(y_1 + "kg", map_X(x_1), map_Y(y_1) + 30);
      }
    }
  } else {
    fill(#3BB273);
    stroke(#276b47);
    strokeWeight(2);
    ellipse(plotX2 - 450, 0.5 * plotY1, radi, radi);
  }
}
