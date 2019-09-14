import 'dart:html';
import 'dart:math';

void main() {
  var output = querySelector('#output');
  DivElement input = DivElement();
  output.append(input);
  NumberInputElement levelin = NumberInputElement();
  input.append(levelin);
  input.append(Element.br());
  NumberInputElement x1in = NumberInputElement();
  input.append(x1in);
  NumberInputElement y1in = NumberInputElement();
  input.append(y1in);
  input.append(Element.br());
  NumberInputElement x2in = NumberInputElement();
  input.append(x2in);
  NumberInputElement y2in = NumberInputElement();
  input.append(y2in);
  input.append(Element.br());
  NumberInputElement x3in = NumberInputElement();
  input.append(x3in);
  NumberInputElement y3in = NumberInputElement();
  input.append(y3in);

  ButtonElement generate = ButtonElement() ..text = 'Generate Fractal';
  output.append(generate);
  output.append(Element.br());
  output.append(Element.br());
  CanvasElement fractal = CanvasElement();
  output.append(fractal);
  generate.onClick.listen((e){
    Point p1 = Point(int.parse(x1in.value), int.parse(y1in.value));
    Point p2 = Point(int.parse(x2in.value), int.parse(y2in.value));
    Point p3 = Point(int.parse(x3in.value), int.parse(y3in.value));
    generateFractalTriangle(fractal, int.parse(levelin.value), p1, p2, p3);
  });
  /*fractal = CanvasElement()..width = 200..height = 200 * sqrt(3) ~/2;
  CanvasRenderingContext2D ctx = fractal.getContext('2d');
  drawFractalTriangle(ctx, 9, Point(100,0), Point(0,200 * sqrt(3) ~/2), Point(200,200 * sqrt(3) ~/2));


  output.append(fractal);*/
}
void generateFractalTriangle(CanvasElement fractal, int level, Point p1, Point p2, Point p3){
  fractal.width = max(p1.x, max(p2.x, p3.x));
  fractal.height = max(p1.y, max(p2.y, p3.y));
  CanvasRenderingContext2D ctx = fractal.context2D;
  drawFractalTriangle(ctx, level, p1, p2, p3);
}
void drawFractalTriangle(CanvasRenderingContext2D ctx, int level, Point p1, Point p2, Point p3){
  if(level > 12) level = 12;
  if(level == 0){
    drawTriangle(ctx, p1, p2, p3);
    return;
  }
  Point mid3 = midpoint(p1,p2);
  Point mid1 = midpoint(p2,p3);
  Point mid2 = midpoint(p3,p1);
  drawFractalTriangle(ctx, level - 1, p1, mid2, mid3);
  drawFractalTriangle(ctx, level - 1, p2, mid1, mid3);
  drawFractalTriangle(ctx, level - 1, p3, mid1, mid2);
}
void drawTriangle(CanvasRenderingContext2D ctx, Point p1, Point p2, Point p3){
  ctx.beginPath();
  ctx.moveTo(p1.x, p1.y);
  ctx.lineTo(p2.x, p2.y);
  ctx.lineTo(p3.x, p3.y);
  ctx.closePath();
  ctx.fill('nonzero');
}
Point midpoint(Point p1, Point p2) => Point( (p1.x+p2.x)/2, (p1.y+p2.y)/2);