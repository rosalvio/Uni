#define PROYECTO "Estrella 3D"
#include <iostream>
#include <gl/freeglut.h>
#include <Utilidades.h>
using namespace std;
static GLint id;

static const GLfloat t1[8] = { 1, 0.7, 1, 0.7, 1, 0.7, 1, 0.7 };
static const GLfloat t2[8] = { 1, 0.7, 1, 0.7, 1, 0.7, 1, 0.7 };
static const float r[6] = { 0, 1 , 0, 0, 0.8, 0 };
static const float g[6] = { 0, 0 , 1, 0, 0, 0.4 };
static const float b[6] = { 0, 0 , 0, 1, 0.8, 0 };
static const float eyeX = 0;
static const float eyeY= 2;
static const float eyeZ = -3;
static float d;


void triangulos() {
    glClearColor(1, 1, 1, 1);

    // Lista de acciones para ambos triangulos
    // GL_TRIANGLE_STRIP
    id = glGenLists(1);
    glNewList(id, GL_COMPILE);
    glPushAttrib(GL_CURRENT_BIT);
    
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

void dibujaEstrella() {
    for (int i = 0; i < 6; i++)
    {
        //glPushMatrix();
        
        glColor3f(r[i], g[i], b[i]);
        //glColor3f(0, .2 * i, .1 * i);
        glRotatef( 150 * PI, 0, 1, 0);
        //glRotatef(i*30 * PI, 0, 1, 0); // Si en vez de en y rota en z se parece al resultado
        glCallList(id);
        //glPopMatrix();
    }
}

void display()
// Funcion de atencion al dibujo
{
    
    glClear(GL_COLOR_BUFFER_BIT); // Borra la pantalla
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    gluLookAt(eyeX, eyeY, eyeZ, 0, 0, 0, 0, 0, -1); // Situa la camara
    glRotatef(30, 0, 0, 1); // Dar angulo a la camara
    glColor3f(1, 0, 0);
    
    dibujaEstrella();
    //glCallList(id);

    
    glColor3f(0,0,0);
    glutWireSphere(1, 40, 40); // Dibuja la esfera
    
    glFlush(); // Finaliza el dibujo
}
void reshape(GLint w, GLint h)
// Funcion de atencion al redimensionamiento
{
    // Usamos toda el area de dibujo
    glViewport(0, 0, w, h);
    // Definimos la camara (matriz de proyeccion)
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    float razon = (float)w / h;
    d = sqrt(pow(eyeX, 2) + pow(eyeY, 2) + pow(eyeZ, 2));
    float fovy = 2*asin(1/d)*360/(2*PI);
    
    gluPerspective(fovy, razon, 1, 10);
}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(400, 400);
    glutCreateWindow(PROYECTO);
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    triangulos();
    glutMainLoop();
    return 0;
}
