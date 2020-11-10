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
static const float eyeY= 5;
static const float eyeZ = -1;

void init() {
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
/*
void display() {
    glClearColor(1.0, 1.0, 1.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
    glMatrixMode(GL_PROJECTION);
    glEnable(GL_DEPTH_TEST);
    glLoadIdentity();
    init();
    //gluPerspective(45, 2, 15, -15);
    //gluLookAt(eyeX, eyeY, eyeZ, 0, 0, -5, 0, 0.2, 0);
    
    
    
    for (int i = 0; i < 6; i ++)
    {       
        glPushMatrix();
        glRotatef(0, i * 30 * PI, 1, 0);
        glColor3f(r[i], g[i], b[i]);
        //glTranslatef(2, 0, 0);
        glCallList(id);
        glPopMatrix();
    }
    glColor3f(0.5, 0.2, 0);
    glutSolidSphere(0.9, 50, 50);


    glFlush();
}

void reshape(GLint w, GLint h) {
    static const float razon = 1; // a/b = w'/h'
// Razon de aspecto del area de dibujo
    float razonAD = float(w) / h;
    float wp, hp; // w',h'
    float d = sqrt(eyeX*eyeX + eyeY * eyeY + eyeZ * eyeZ);
    float fovy = 2 * asin(1 / d * 360 / ( 2 * PI));
    /* Centramos un viewport con la misma razon de la vista.
     Si el area tiene razon menor la vista se ajusta en horizontal (w)
     recortando el viewport por arriba y por abajo.
     Si el area tiene mayor razon que la vista se ajusta en vertical (h)
     y se recorta por la izquierda y la derecha. */  /*
    if (razonAD < razon) {
        wp = float(w);
        hp = wp / razon;
        glViewport(0, int(h / 2.0 - hp / 2.0), w, int(hp));
    }
    else {
        hp = float(h);
        wp = hp * razon;
        glViewport(int(w / 2.0 - wp / 2.0), 0, int(wp), h);
    }
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    // Definimos la camara (matriz de proyeccion)
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    /* CAMARA PERSPECTIVA */ /*
    gluPerspective(fovy, razon, 0, 10);
}*/

void display()
// Funcion de atencion al dibujo
{
    init();
    glClear(GL_COLOR_BUFFER_BIT); // Borra la pantalla
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glColor3f(0, 0, 0);
    glCallList(id);
    gluLookAt(eyeX, eyeY, eyeZ, 0, 0, 0, 0, 0, -1); // Situa la camara
    glutWireSphere(1.94, 40, 40); // Dibuja la esfera
    
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
    
    gluPerspective(45, razon, 1, 10);
}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(400, 400);
    glutCreateWindow(PROYECTO);
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    
    glutMainLoop();
    return 0;
}
