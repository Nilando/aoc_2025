input = read;


tiles = input.split('\n')
.filter(fn(i) { i != ""; })
.map(fn(i) { i.split(',').map(fn(k) { int(k); }); });


fn calc_area(a, b) {
  (1 + (a[0] - b[0]).abs()) * ( 1 + (a[1] - b[1]).abs());
}


fn contained(a, b, c) {
  x_contained = (a[0] < c[0] && c[0] < b[0])
    || b[0] < c[0] && c[0] < a[0];
  y_contained = (a[1] < c[1] && c[1] < b[1])
    || b[1] < c[1] && c[1] < a[1];

  return x_contained && y_contained;
}

max_area = 0;
i = 0;
while i < #tiles {
  k = i + 1; 
  while k < #tiles {
    a = tiles[i];
    b = tiles[k];

    area = calc_area(a, b);
    if area > max_area {
      max_area = area;
    }

    k = k + 1;
  }
  i = i + 1;
}

print(max_area);



red_tile_perimeter_lines = [[tiles[0], tiles.last()]];
s = [tiles[0], 0];
i = 0;
while i < #tiles - 1 {
  a = tiles[i];
  b = tiles[i + 1];

  red_tile_perimeter_lines << [a, b];

  i = i + 1;
}


fn create_perimeter() {
}

print(#tiles);
print(#red_tile_perimeter_lines);
print(red_tile_perimeter_lines.last());
print(#red_tile_perimeter_lines);


fn find_axis(line) {
  if line[0] == line[0] {
    return line[0];
  } else {
    return line[1];
  }
}


fn between(x, y, a) {
  (x < a && a < y) || (y < a && a < x);
}


fn lines_equal(x, y, m, n) {
  [x,y] == [m, n] || [x,y] == [n, m];
}


fn crosses_line(a, b, line) {

  if line[0][0] == line[1][0] {
    axis = line[0][0];
    x = line[0][1];
    y = line[1][1];
    m = a[1];
    n = b[1];

    return between(a[0], b[0], axis) && (between(x, y, m) || between(x, y, n) || lines_equal(x, y, m, n));
  } else {
    axis = line[0][1];

    x = line[0][0];
    y = line[1][0];
    m = a[0];
    n = b[0];
    return between(a[1], b[1], axis) && (between(x, y, m) || between(x, y, n) || lines_equal(x, y, m, n));
  }
}

part2 = 0;
i = 0;
while i < #tiles {
  k = i + 1; 
  while k < #tiles {
    a = tiles[i];
    b = tiles[k];

    flag = true;
    v = 0;
    while v < #red_tile_perimeter_lines {
      line = red_tile_perimeter_lines[v];

      if (contained(a, b, line[0]) || contained(a, b, line[1])) {
        //print("CONTAINED: line {line}, (a,b): {a}, {b}");
        flag = false;
        break;
      }

      if crosses_line(a, b, line) {
        //print("CROSSED: line {line}, (a,b): {a}, {b}");
        flag = false;
        break;
      }
      v = v + 1;
    }

    if flag {
      area = calc_area(a, b);
      if area > part2 {
        print("new max {a} {b}");
        part2 = area;
      }
    }

    k = k + 1;
  }
  print(((i * 1.0) / #tiles) * 100.0);
  i = i + 1;
}

print("part2 {part2}");
