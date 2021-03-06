import java.util.*;

PShape obj;

Boolean pressedRight = false;

ArrayList<Float> puntosX, puntosY;

void setup()
{
    puntosX = new ArrayList<Float>();
    puntosY = new ArrayList<Float>();
    size (1000, 700, P3D);
    background(0);
    stroke(255, 0, 0);
    
    line(width/2, 0, width/2, height);
}
void draw()
{
    if (!pressedRight)
      return;
      
    background (0) ;
    //Movemos con puntero*
    translate (mouseX, mouseY) ;
    
    //Muestra l a forma
    shape (obj) ;
}
void mousePressed()
{
    // Volvemos al inicio
    if (pressedRight)
    {
        pressedRight = false;
        background(0);
        stroke(255, 0, 0);
        line(width/2 - mouseX, -mouseY, width/2 - mouseX, height - mouseY);
        puntosX.clear();
        puntosY.clear();
        return;
    }
    // Añademos puntos
    if (mouseButton == LEFT)
    {
        int x = mouseX;
        if (x < width/2)
          x = width / 2;
          
        puntosX.add((float)x);
        puntosY.add((float)mouseY);
        int size = puntosX.size();
        
        if (size == 1)
          return;
        
        line(puntosX.get(size - 2), puntosY.get(size - 2), x, mouseY);
    }
    // Creamos el objeto 3D
    else if (mouseButton == RIGHT)
    {
        pressedRight = true;
        obj = createShape();
        
        // El pincel
        obj.beginShape(TRIANGLE_STRIP);
        obj.fill(0, 100, 255);
        obj.stroke(255, 0, 0);
        obj.strokeWeight(1);
        
        float angulo = 10;
        float radian;
        float vueltas = 360 / angulo + 1;
        int size = puntosX.size() - 1;
        float x, y, x2, y2;
        int medio = width/2;
        for (int j = 0; j < size; ++j)
        {
            x = puntosX.get(j); x2 = puntosX.get(j + 1);
            y = puntosY.get(j); y2 = puntosY.get(j + 1);
            for (int i = 0; i < vueltas; ++i)
            {
                radian = radians(i * angulo);
                obj.vertex((x - medio) * cos(radian), y, (x - medio) * sin(radian));
                obj.vertex((x2 - medio) * cos(radian), y2, (x2 - medio) * sin(radian));
            }
        }
        obj.endShape();
    }
}
