input = read;

fn solve_equation(equation) {
  op = equation[1];
  values = equation[0];

  if op == "+" {
    return values.sum();
  } else {
    return values.reduce(fn(acc, x) { return acc * x; }, 1);
  }
}

lines = input.split('\n').filter(fn(i) { i != ""; });
op_line = (^lines).split(' ').filter(fn(i) { i != ""; });

part1 = lines
  .map(fn(line) { 
    line.split(' ') 
      .filter(fn(i) { i != ''; })
      .map(fn(i) { int(i); });
  })
  .transpose()
  .zip(op_line)
  .map(fn(e) { solve_equation(e); })
  .sum();

print(part1);

part2 = lines
  .map(fn(line) { list(line); })
  .transpose()
  .map(fn(i) { int(i.filter(fn(k) { k != " "; }).join("")); })
  .split(null)
  .zip(op_line)
  .map(fn(e) { solve_equation(e); })
  .sum();

print(part2);
