#define PROYECTO "Mosaico"
#include <iostream>
#include <gl/freeglut.h>
#include <Utilidades.h>
using namespace std;
static GLint id;

static const GLfloat t1[8] = { 1, 0.7, 1, 0.7, 1, 0.7, 1, 0.7 };
static const GLfloat t2[8] = { 1, 0.7, 1, 0.7, 1, 0.7, 1, 0.7 };

void init() {
    glClearColor(1, 1, 1, 1);

    // Lista de acciones para ambos triangulos
    // GL_TRIANGLE_STRIP
    id = glGenLists(1);
    glNewList(id, GL_COMPILE);
    glPushAttrib(GL_CURRENT_BIT);
    glColor3f(0.0, 0.0, 0.8);
    glBegin(GL_TRIANGLE_STRIP);
    for (int i = 0; i < 4; i++) {
        double angle = (1 + (i * 4) % 12) * PI / 6;
        glVertex3f(1.0 * cos(angle), 1.0 * sin(angle), 0.0);
        glVertex3f(0.7 * cos(angle), 0.7 * sin(angle), 0.0);
    }
    glEnd();
    glBegin(GL_TRIANGLE_STRIP);
    for (int i = 0; i < 4; i++) {
        double angle = (3 + (i * 4) % 12) * PI / 6;
        glVertex3f(1.0 * cos(angle), 1.0 * sin(angle), 0.0);
        glVertex3f(0.7 * cos(angle), 0.7 * sin(angle), 0.0);
    }
    glEnd();
    glPopAttrib();
    glEndList();
}

void display() {
    glClearColor(1.0, 1.0, 1.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
    glMatrixMode(GL_MODELVIEW);
    for (int i = -1; i < 2; i+=2)
    {
        glLoadIdentity();
        glPushMatrix();
        glScalef(0.5f, 0.5f, 0.f);
        glTranslatef(i, i, 0.f);
        glRotatef(15 * PI, 0, 0, 1);
        glCallList(id);
        glScalef(0.4f, 0.4f, 0.f);
        glRotatef(-30.f * PI, 0, 0, 1);
        glCallList(id);
        glPopMatrix();
    }

    for (int i = -1; i < 2; i += 2)
    {
        glLoadIdentity();
        glPushMatrix();
        glScalef(0.5f, 0.5f, 0.f);
        glTranslatef(i, -i, 0.f);
        glRotatef(-15 * PI, 0, 0, 1);
        glCallList(id);
        glScalef(0.4f, 0.4f, 0.f);
        glRotatef(30.f * PI, 0, 0, 1);
        glCallList(id);
        glPopMatrix();
    }

    glFlush();
}

void reshape(GLint w, GLint h) {}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
    glutInitWindowSize(400, 400);
    glutCreateWindow(PROYECTO);
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    init();
    glutMainLoop();
    return 0;
}
