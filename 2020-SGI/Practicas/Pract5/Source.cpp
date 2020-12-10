// Jose Antonio Mira Garcia
#define Proyecto "Reloj 3D"
#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <utilidades.h>
#include <time.h>
using namespace std;
static GLfloat giro = 0;
static double x = 0, y = 0, z = 3;
time_t  hora = time(NULL);
struct tm* aTime = localtime(&hora);
//inicializamos el reloj
static float alphaSegundo = (360/60) * aTime->tm_sec, alphaHora = (360 / 12) * aTime->tm_hour, alphaMinuto = 360 / (60) * aTime->tm_min, radS = 0.04, radM = 0.05, radH = 0.065;

void timerSegundos(int valor) {
	alphaSegundo += (360/60);
	glutPostRedisplay();
	glutTimerFunc(valor, timerSegundos, valor);
}
void timerHoras(int valor) {
	alphaHora += (360 / 12);
	glutPostRedisplay();
	glutTimerFunc(valor, timerHoras, valor);
}
void timerMinutos(int valor) {
	int minutos = aTime->tm_min;
	alphaMinuto += (360 / 60);
	glutPostRedisplay();
	glutTimerFunc(valor, timerMinutos, valor);
}
void onIdle() {
	giro += 0.25;
	glutPostRedisplay();
}

void display() {
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	gluLookAt(x, y, z, 0, 0, 0, 0, 1, 0);
	glClearColor(1, 1, 1, 1);
	glColor3f(0, 0, 0);
	glutWireSphere(1, 12, 2);
	glPushMatrix();
	glTranslatef(0.5, 0.5, 0);
	glScalef(0.25, 0.25, 0.25);
	glRotatef(giro, 0, 1, 1);
	glColor3f(0.5, 0.2, 0);
	glutSolidCone(0.2, 0.3, 20, 20);
	glTranslatef(-0.5, -0.5, 0);
	glColor3f(0, 0, 1);
	glutSolidCone(0.2, 0.3, 20, 20);
	glPopMatrix();

	//Segundero
	glPushMatrix();
	glRotatef(-alphaSegundo, 0, 0, 1);
	glTranslatef(0, 1-radS, 0);
	glColor3f(1, 0, 1);
	glutSolidSphere(radS, 20, 20);
	glPopMatrix();

	//Minutos
	glPushMatrix();
	glRotatef(-alphaMinuto, 0, 0, 1);
	glRotatef(15 * alphaSegundo, 0, 1, 0);
	glColor3f(1, 0.1, 0.3);
	glTranslatef(0, 0.7 , 0);
	glutSolidSphere(radM, 20, 20);
	glPopMatrix();

	//Horas
	glPushMatrix();
	glRotatef(-alphaHora, 0, 0, 1);
	glRotatef(15 * alphaHora, 0, 1, 0);
	glColor3f(1, 0, 0);
	glTranslatef(0, 0.4, 0);
	glutSolidSphere(radH,20,20);
	glPopMatrix();
	glutSwapBuffers(); 



}
void reshape(GLint w, GLint h) {
	glViewport(0, 0, w, h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	float razon = (float)w / h;
	static float d = sqrt(x * x + y * y + z * z);
	static float fovy = 2 * asin(1 / d) * 360 / (2 * PI);
	gluPerspective(fovy, razon, 1, 5);
}

void main(int argc, char** argv) {
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(700, 500);
	glutInitWindowPosition(50, 200);

	glutCreateWindow(Proyecto);
	glEnable(GL_DEPTH_TEST);
	glutDisplayFunc(display);
	glutReshapeFunc(reshape);
	glutIdleFunc(onIdle);
	// cout << aTime->tm_sec << endl;
	cout << "Jose Antonio Mira Garcia" << endl;
	glutTimerFunc(1000-(aTime->tm_sec), timerSegundos, 1000);
	// -1 para que cambie despues de que el segundero llegue a 60s
	glutTimerFunc(60 * 1000 - (aTime->tm_sec - 1) * 1000, timerMinutos, 60  * 1000 - aTime->tm_sec);
	glutTimerFunc(60 * 60 * 1000 - (aTime->tm_min - 1) * 60 * 1000, timerHoras, 60 * 60 * 1000 - aTime->tm_hour);
	glutMainLoop();
}