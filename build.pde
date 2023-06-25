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
		.add(#BC2D19)
		.add(#1E4363)
		.add(#FFB00D)
		.add(#FCF2CB)
		.add(#FF8926)
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
						.fill(#D67D00)
						.scale(random(0.5,1))
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

void draw() {
	PGraphics tmp = null;

	if (record) {
		tmp = beginRecord(PDF, "render-######_"+seed+".pdf");
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

	
