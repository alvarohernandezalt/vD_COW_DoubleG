import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;
boolean record = false;

HDrawablePool pool;
HColorPool colors;
long seed;

void setup() {
	size(600, 600);
	H.init(this).background(#000000);
	smooth();
	seed = (long)random(100000);
	randomSeed(seed);
	println("Seed:" + seed);

	colors = new HColorPool()
		.add(#FF0700)
		.add(#FFFD00)
		.add(#0951F7)
		.fillOnly()
	;

	pool = new HDrawablePool(2000);
	pool.autoAddToStage()
		.add(new HShape("COW2_50.svg"))
		.add(new HShape("OTHER_50.svg"))

		.layout(
			new HShapeLayout()
			.target(
				new HImage("shapeMap2.png")
			)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						//.noStroke()
						//.strokeJoin(ROUND)
						//.strokeCap(ROUND)
						//.strokeWeight(0.3)
						//.stroke(#000000)
						//.fill(#D67D00,400)
						//.scale(random(0.5,1))
						.size((int)random(10, 30))
						.rotate((int)random(360))
						//.loc( (int)random(-200,width+200), (int)random(-200,height+200) )
						.anchorAt(H.CENTER)
					;
					d.randomColors(colors.fillOnly());
				}
			}

		)
		.requestAll()
	;

	
}

void draw() {
	PGraphics tmp = null;

	if (record) {
		tmp = beginRecord(PDF, "render-######"+seed+".pdf");
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

void mousePressed() {
    record = true;
}

	
