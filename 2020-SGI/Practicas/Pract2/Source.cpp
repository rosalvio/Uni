#define PROYECTO "Estrella de David"
#include <iostream>
#include <gl/freeglut.h>
#include <Utilidades.h>

void display()
// Funcion de atencion al dibujo
{
	glClear(GL_COLOR_BUFFER_BIT);
	glClearColor(1, 1, 1, 1);
	glBegin(GL_TRIANGLE_STRIP);
	for (int i = 0; i < 6; i+=2)
	{
		glColor3f(0.0, 0.0, 0.3);
		glVertex3f(cos(i * 2 * PI / 6 + PI / 2), sin(i * 2 * PI / 6 + PI / 2), 0);
		glVertex3f(0.7 * cos(i * 2 * PI / 6 + PI / 2),0.7 * sin(i * 2 * PI / 6 + PI / 2), 0);
	}
	glVertex3f(cos(0 * 2 * PI / 6 + PI / 2), sin(0 * 2 * PI / 6 + PI / 2), 0);
	glVertex3f(0.7 * cos(0 * 2 * PI / 6 + PI / 2),0.7 * sin(0 * 2 * PI / 6 + PI / 2), 0);
	glEnd();
	glBegin(GL_TRIANGLE_STRIP);
	for (int i = 1; i < 6; i += 2)
	{
		glColor3f(0.0, 0.0, 0.3);
		glVertex3f(cos(i * 2 * PI / 6 + PI / 2), sin(i * 2 * PI / 6 + PI / 2), 0);
		glVertex3f(0.7 * cos(i * 2 * PI / 6 + PI / 2), 0.7 * sin(i * 2 * PI / 6 + PI / 2), 0);
	}
	glVertex3f(cos(1 * 2 * PI / 6 + PI / 2),sin(1 * 2 * PI / 6 + PI / 2), 0);
	glVertex3f(0.7 * cos(1 * 2 * PI / 6 + PI / 2),0.7 * sin(1 * 2 * PI / 6 + PI / 2), 0);
	glEnd();
	glFlush();
}
void reshape(GLint w, GLint h)
// Funcion de atencion al redimensionamiento
{
}

void main(int argc, char** argv)
// Programa principal
{
	glutInit(&argc, argv); // Inicializacion de GLUT
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB); // Alta de buffers a usar
	glutInitWindowSize(400, 400); // Tamanyo inicial de la ventana
	glutCreateWindow(PROYECTO); // Creacion de la ventana con su titulo
	std::cout << PROYECTO << " running" << std::endl; // Mensaje por consola
	glutDisplayFunc(display); // Alta de la funcion de atencion a display
	glutReshapeFunc(reshape); // Alta de la funcion de atencion a reshape
	glutMainLoop(); // Puesta en marcha del programa
}