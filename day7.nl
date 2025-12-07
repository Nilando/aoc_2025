input = read;
lines = input.split('\n').map(fn(line) { list(line); });

// I need to add this to the standard library :)
patch($list, $uniq, fn(self) {
  result = {};

  for v in self {
    if result[v] == null {
      result[v] = true;
    }
  }

  return result.keys();
});

beam_positions = [lines[0].find('S')];

@part1 = 0;
for line in lines {
  beam_positions = beam_positions.map(fn(pos) {
    if pos < #line && line[pos] == '^' {
      @part1 = @part1 + 1;
      [pos - 1, pos + 1];
    } else {
      pos;
    }
  })
  .flatten()
  .uniq()
  .filter(fn(p) { p >= 0; });
}

print(@part1);

beam_positions = { lines[0].find('S'): 1 };
next_beam_positions = {};

for line in lines {
  list(beam_positions).map(fn(pair) {
    pos = pair[0];
    timelines = pair[1];

    if pos < #line && line[pos] == '^' {
      if 0 < pos {
        next_beam_positions[pos - 1] = int(next_beam_positions[pos - 1]) + timelines;
      }
      if (pos + 1) < #line {
        next_beam_positions[pos + 1] = int(next_beam_positions[pos + 1]) + timelines;
      }
    } else {
      next_beam_positions[pos] = int(next_beam_positions[pos]) + timelines;
    }
  });

  beam_positions = next_beam_positions;
  next_beam_positions = {};
}

print(beam_positions.values().sum());
