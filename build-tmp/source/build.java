import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import hype.*; 
import hype.extended.behavior.*; 
import hype.extended.colorist.*; 
import hype.extended.layout.*; 
import hype.interfaces.*; 
import processing.pdf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {







boolean record = false;

HDrawablePool pool;
HColorPool colors;
long seed;

public void setup() {
	
	H.init(this).background(0xff000000);
	
	seed = (long)random(100000);
	randomSeed(seed);
	println("Seed:" + seed);

	colors = new HColorPool()
		.add(0xffBC2D19)
		.add(0xff1E4363)
		.add(0xffFFB00D)
		.add(0xffFCF2CB)
		.add(0xffFF8926)
		.fillOnly()
	;

	pool = new HDrawablePool(5);
	pool.autoAddToStage()
		.add(new HShape("COW2.svg"),2)
		.add(new HShape("OTHER.svg"))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.noStroke()
						//.strokeJoin(ROUND)
						//.strokeCap(ROUND)
						//.strokeWeight((int)random(1,3))
						//.stroke(#333333)
						.fill(0xffD67D00)
						.scale(random(0.5f,1))
						//.size( (int)random(100,200),(int)random(100,200) )
						.rotate((int)random(360))
						.loc( (int)random(-100,width+200), (int)random(-100,height+200) )
						.anchorAt(H.CENTER)
					;
					d.randomColors(colors.fillOnly());
				}
			}

		)
		.requestAll()
	;

	
}

public void draw() {
	PGraphics tmp = null;

	if (record) {
		tmp = beginRecord(PDF, "render-######.pdf");
	}

	if (tmp == null) {
		H.drawStage();
	} else {
		PGraphics g = tmp;
		boolean uses3D = false;
		float alpha = 1;
		H.stage().paintAll(g, uses3D, alpha);
	}

	if (record) {
		endRecord();
		record = false;
	}	
	
}

public void mousePressed() {
    record = true;
}

	
  public void settings() { 	size(600, 600); 	smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
