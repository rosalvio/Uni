#define PROYECTO "Entrega Videojuego"
#define _CRT_SECURE_NO_WARNINGS
#define tam 0.5
#define VMax 10
#include<iostream>
#include<sstream>

#include<Utilidades.h>
#include <ctime>

using namespace std;
double width = 0;
double x = 0, z = 0;
static int y = 1;
float A = 8, T = 100;
float giro = 0.0, velocidad = 0;
GLuint texturas[5];
bool arriba = false, abajo = false, izquierda = false, derecha = false;
bool MODO_ALAMBRICO = false, MODO_LUZ = false, MODO_NIEBLA = false, MODO_SOLIDARIO = false;
float incrementovelocidad = 0.05;
float incrementoGiro = PI / 90;
float rozamiento = 0.01;
GLint anchura = 4; // anchura de la carretera
bool camaraArriba = false;

GLint distanciacarteles = 40;

GLfloat v0[3] = { 0,0,0 }, v1[3] = { 0,0,0 }, v2[3] = { 0,0,0 }, v4[3] = { 0,0,0 }; // vertices para la carretera

GLfloat carreteradifuso[] = { 0.8,0.8,0.8 };
GLfloat carreteraespecular[] = { 0.3,0.3,0.3 };
float anterior = 4;

// Cuanto mas se avanza en el circuito las curvas son ligeramente mas pronunciadas y rectas mas largas
float func(float x) {
	return A * sin(x * 2 * PI / T) * log(x * 2 * PI / T);
}

float deriv(float x) {
	return ((2 * PI * A) / T) * (A * sin((PI * x) / T / 2)) / x + (A / 2 * PI * cos((PI * x) / T/2) * log((PI * x) / T / 2)) / T / 4;
}

void dibujaVehiculo() {
	glPushMatrix();
	glTranslatef(0, -0.75, -2);
	glColor3f(1, 0, 0);
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, BRONCE);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, ROJO);
	glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, 3);
	glRotatef(100 * x, 0, 1, 0);
	glBindTexture(GL_TEXTURE_2D, texturas[1]);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
	// Uso esfera porque no se nota la rotacion del objeto al moverse
	if (MODO_ALAMBRICO) glutWireSphere(tam, 30, 30); else glutSolidSphere(tam, 30, 30);
	glPopMatrix();
}

void onTimer(int valor) {
	static int antes = 0;
	int ahora, tiempo;
	ahora = glutGet(GLUT_ELAPSED_TIME); //Tiempo transcurrido desde el inicio
	time_t rawtime = time(&rawtime);
	struct tm* timeinfo = localtime(&rawtime);
	tiempo = ahora - antes;
	x += velocidad * sin(giro) * tiempo / 1000.0;
	z += velocidad * cos(giro) * tiempo / 1000.0;
	if (arriba) velocidad += incrementovelocidad;
	if (abajo && velocidad > 0.0001) velocidad -= incrementovelocidad;
	if (izquierda) giro += incrementoGiro;
	if (derecha) giro -= incrementoGiro;
	if (velocidad > VMax) {
		velocidad = VMax;
	}
	arriba = abajo = izquierda = derecha = false;
	antes = ahora;
	glutTimerFunc(25, onTimer, 25);
	glutPostRedisplay();
}

void init() {
	glClearColor(0, 0, 0, 1);
	glEnable(GL_LIGHTING); 
	glEnable(GL_DEPTH_TEST); 
	glEnable(GL_LIGHT0);
	glEnable(GL_LIGHT1);
	glEnable(GL_LIGHT2);
	glEnable(GL_LIGHT3);
	glEnable(GL_LIGHT4);
	glEnable(GL_LIGHT5);
	glEnable(GL_TEXTURE_2D); 
	glShadeModel(GL_SMOOTH);

	GLfloat LunaAmbienteDifusa[] = { 0.5,0.5,0.5,1.0 };
	GLfloat LunaEspecular[] = { 0.0,0.0,0.0,1.0 };
	glLightfv(GL_LIGHT0, GL_AMBIENT, LunaAmbienteDifusa);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, LunaAmbienteDifusa);
	glLightfv(GL_LIGHT0, GL_SPECULAR, LunaEspecular);


	glLightfv(GL_LIGHT1, GL_AMBIENT, BLANCO);
	glLightfv(GL_LIGHT1, GL_DIFFUSE, BLANCO);
	glLightfv(GL_LIGHT1, GL_SPECULAR, BLANCO);
	glLightf(GL_LIGHT1, GL_SPOT_CUTOFF, 30.0);
	glLightf(GL_LIGHT1, GL_SPOT_EXPONENT, 3.0);

	
	glGenTextures(1, &texturas[0]);
	glBindTexture(GL_TEXTURE_2D, texturas[0]);
	loadImageFile((char*)"desierto_superficie.jpg");

	glGenTextures(1, &texturas[1]);
	glBindTexture(GL_TEXTURE_2D, texturas[1]);
	loadImageFile((char*)"carretera.jpg");
	
	glGenTextures(1, &texturas[2]);
	glBindTexture(GL_TEXTURE_2D, texturas[2]);
	loadImageFile((char*)"desierto.jpg");

	glGenTextures(1, &texturas[3]);
	glBindTexture(GL_TEXTURE_2D, texturas[3]);
	loadImageFile((char*)"cocacola.jpg");

	glGenTextures(1, &texturas[4]);
	glBindTexture(GL_TEXTURE_2D, texturas[4]);
	loadImageFile((char*)"superficie_gimp.jpg");
}

void onSpecialKey(int tecla, int xp, int yp) {
	switch (tecla) {
	case GLUT_KEY_UP:
		arriba = true;
		break;
	case GLUT_KEY_DOWN:
		abajo = true;
		break;
	case GLUT_KEY_LEFT:
		izquierda = true;
		break;
	case GLUT_KEY_RIGHT:
		derecha = true;
		break;
	}
	glutPostRedisplay();

}

void onKey(unsigned char letra, int xp, int yp) {
	switch (letra) {
	case 's':
		MODO_ALAMBRICO = !MODO_ALAMBRICO;
		break;
	case 'l':
		MODO_LUZ = !MODO_LUZ;
		break;
	case 'n':
		MODO_NIEBLA = !MODO_NIEBLA;
		break;
	case 27:
		exit(0);
	case 'c':
		MODO_SOLIDARIO = !MODO_SOLIDARIO;
		break;
	case 'a':
		camaraArriba = !camaraArriba;
		break;
	}
	glutPostRedisplay();

}



void hud() {
	if (MODO_ALAMBRICO) {
			glPushMatrix();
			glTranslatef(-0.75, -0.75, -2);
			glScalef(0.25, 0.2 * velocidad, 0);
			if (velocidad >= VMax*0.75)
			{
				glColor3f(1, 0, 0);
			}
			else if (velocidad <= VMax*0.5)
			{
				glColor3f(0, 0, 1);
			}
			else
			{
				glColor3f(0, 1, 0);
			}
			glutWireCube(1);
			glPopMatrix();
		}
		else {
			glPushMatrix();
			glTranslatef(-0.75, -0.75, -2);
			glScalef(0.25, 0.2 * velocidad, 0);
			glutSolidCube(1);
			glPopMatrix();
		}
}


void carretera() {
	//Dibujo Carretera dinamica 
	float inicio = x - 20, vfseno = func(inicio);
	float derivada = deriv(inicio);
	GLfloat precalculo[3] = { inicio,0,vfseno };
	GLfloat tz[3] = { -derivada,0,1 };
	GLfloat normales[3] = { (1 / sqrt(1 + derivada * derivada)) * tz[0] , 0 ,(1 / sqrt(1 + derivada * derivada)) * tz[2] };

	for (int i = 0; i < 3; i++) {
		v0[i] = precalculo[i] - (normales[i] * anchura);
		v4[i] = precalculo[i] + (normales[i] * anchura);
	}
	for (int i = 1; i < 100; i++) {
		float aux = inicio + i;
		vfseno = func(aux);
		float derivada = deriv(aux);
		GLfloat precalculo2[3] = { aux,0,vfseno };
		GLfloat tz[3] = { -derivada,0,1 };
		GLfloat normales2[3] = { (1 / sqrt(1 + derivada * derivada)) * tz[0] , 0 ,(1 / sqrt(1 + derivada * derivada)) * tz[2] };
		for (int i = 0; i < 3; i++) {
			v1[i] = precalculo2[i] - (normales2[i] * anchura);
			v2[i] = precalculo2[i] + (normales2[i] * anchura);
		}
		glPushMatrix();
		if (MODO_ALAMBRICO) {
			glPolygonMode(GL_BACK, GL_LINE);
			glPolygonMode(GL_FRONT, GL_LINE);
		}
		else {
			glPolygonMode(GL_BACK, GL_FILL);
			glPolygonMode(GL_FRONT, GL_FILL);
		}

		glBindTexture(GL_TEXTURE_2D, texturas[1]);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);


		glColor3f(0, 1, 0);
		glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, carreteradifuso);
		glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, carreteraespecular);
		glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, 3);

		quadtex(v4, v0, v1, v2, 0, 1, 0, 1, 50, 50);
		glPopMatrix();
		for (int i = 0; i < 3; i++) {
			v0[i] = v1[i];
			v4[i] = v2[i];
		}
	}
}

void carteles() {
	GLfloat inicio = anterior;

	for (int i = 0; i < 4; i++) {
		inicio += 80; // distancia entre los carteles
		float xcartel = inicio;
		float zcartel = func(xcartel);
		glPushMatrix();
		glBindTexture(GL_TEXTURE_2D, texturas[3]);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		if (MODO_ALAMBRICO) {
			glPolygonMode(GL_BACK, GL_LINE);
			glPolygonMode(GL_FRONT, GL_LINE);
		}
		else {
			glPolygonMode(GL_BACK, GL_FILL);
			glPolygonMode(GL_FRONT, GL_FILL);
		}
		glTranslatef(xcartel, 1, zcartel);
		GLfloat g0[3] = { 1 , 1,-4 }, g1[3] = { 1, 1, +4 }, g2[3] = { 1, 6, +4 }, g3[3] = { 1, 6, -4 };
		quadtex(g0, g1, g2, g3, 0, 1, 0, 1, 50, 50);
		glPopMatrix();


	}
	if (x > inicio) {
		anterior = inicio;
	}
}

void desierto() {
	glPushMatrix();
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, BLANCO);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, BLANCO);
	glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, 4);
	glBindTexture(GL_TEXTURE_2D, texturas[4]);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

	glColor3f(0, 0, 1);

	GLfloat p0[3] = { 100 + x, -0.1, -100 - z }, p1[3] = { 100 + x, -0.1, 100 - z }, p2[3] = { -100 - x, -0.1, 100 + z }, p4[3] = { -100 - x, -0.1, -100 - z };
	quadtex(p0, p1, p2, p4, 0, 10, 0, 10, 10 * 10, 5 * 10);
	glPopMatrix();
}

void fondo() {
	glPushMatrix();
	glBindTexture(GL_TEXTURE_2D, texturas[2]);
	float alpha = 2 * PI / 50;
	GLfloat cil0[3] = { 200 * cos(0) + x,100,200 * -sin(0) + z };
	GLfloat cil1[3] = { 200 * cos(0) + x,-55,200 * -sin(0) + z };
	GLfloat cil2[3];
	GLfloat cil3[3];
	for (int i = 1; i <= 50; i++) {
		cil2[0] = 200 * cos(i * alpha) + x;
		cil2[1] = 100;
		cil2[2] = 200 * -sin(i * alpha) + z;
		cil3[0] = 200 * cos(i * alpha) + x;
		cil3[1] = -55;
		cil3[2] = 200 * -sin(i * alpha) + z;
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		quadtex(cil3, cil1, cil0, cil2, (i) / 50.0 + 0.5, (i - 1) / 50.0 + 0.5, 0, 1);
		for (int j = 0; j < 3; j++) {
			cil0[j] = cil2[j];
			cil1[j] = cil3[j];
		}
	}
	glPopMatrix();
}

void display() {
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);


	//MODO Alambrico --> activa modo sin luces ni texturas

	if (MODO_ALAMBRICO) {
		glDisable(GL_LIGHTING); //desactivamos las luces
		glDisable(GL_TEXTURE_2D); // desactivamos las texturas
	}
	else {
		glEnable(GL_LIGHTING); //activamos las luces
		glEnable(GL_TEXTURE_2D); // activamos las texturas
	}
	if (MODO_NIEBLA) {
		glEnable(GL_FOG);
		glFogfv(GL_FOG_COLOR, BLANCO);
		glFogf(GL_FOG_DENSITY, 0.05);
	}
	else {
		glDisable(GL_FOG);
	}

	glMatrixMode(GL_MODELVIEW);
	GLfloat posicionLuna[] = { 0.0, 10.0, 0.0, 0.0 };
	glLightfv(GL_LIGHT0, GL_POSITION, posicionLuna);

	carteles();

	glLoadIdentity();
	if (!camaraArriba) dibujaVehiculo(); // Como esta antes del lookat va pegado a la camara
	//Faros
	GLfloat posl1[] = { 0.5, 0.9, -5, 2.0 };
	GLfloat dir_centrall1[] = { 0.0, -1.0, -1.0 };
	glLightfv(GL_LIGHT1, GL_POSITION, posl1);
	glLightfv(GL_LIGHT1, GL_SPOT_DIRECTION, dir_centrall1);

	if (MODO_SOLIDARIO) {
		hud();
	}

	if (!camaraArriba)
		gluLookAt(x, y, z, 10 * sin(giro) + x, 0, 10 * cos(giro) + z, 0, 1, 0);
	else
		gluLookAt(x, 100, z, 10 * sin(giro) + x, 0, 10 * cos(giro) + z, 0, 1, 0);

	carretera();

	desierto();

	fondo();

	if (MODO_LUZ) glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);
	else glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);

	glutSwapBuffers();
}

void reshape(GLint w, GLint h) {
	glViewport(0, 0, w, h);
	width = w;
	// Ratio
	float ra = float(w) / float(h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(45, ra, 1, 200);
}

int main(int argc, char** argv) {
	FreeImage_Initialise(); 
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(600, 600);
	width = 600;
	glutCreateWindow(PROYECTO);
	init();
	glutDisplayFunc(display);
	glutReshapeFunc(reshape);
	glutKeyboardFunc(onKey);
	glutSpecialFunc(onSpecialKey);
	glutTimerFunc(25, onTimer, 25);

	cout << "flechas arriba / abajo --> acelerar / decelerar " << endl << "flechas izquierda / derecha --> girar"
		<< endl << "s --> activa / desactiva modo alambrico" << endl << "l --> diurno / nocturno "
		<< endl << "n--> activa / desactiva niebla" << endl <<
		"c --> activa objeto solidario a la camara" << endl <<
		"a --> situa la camara arriba" << endl;

	glutMainLoop();
	FreeImage_DeInitialise();
}