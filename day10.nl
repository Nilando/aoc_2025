input = read;

lines = input.split('\n').filter(fn(line) { line != ""; });
machines = lines
  .map(fn(l) { 
    items = l.split(' '); 

    indicators = list(items[0]).map(fn(c) { 
      if c == '.' {
        return '.';
      }
      if c == '#' {
        return '#';
      }

      return null;
    }).compact();
    voltage = items.last();
    buttons = items
    .slice(1, #items-1)
    .map(fn(raw_button) {
      indexes = raw_button.slice(1, #raw_button - 1).split(',').map(fn(i) { int(i); });

      button = [];
      i = 0;
      while i < #indicators {
        if indexes.find(i) != null {
          button << '.';
        } else {
          button << '#';
        }

        i = i + 1;
      }

      button;
    });

    { buttons: buttons, indicators: indicators, voltage: null };
  });

fn wait() {
  i = 0;
  while i < 1000000 {
    i = i + 1;
  }
}

fn press_button(indicators, button) {
    new_indicators = [];

    i = 0;
    while i < #indicators {
      if button[i] == '.' {
          if indicators[i] == '.' {
            new_indicators << '#';
          } else {
            new_indicators << '.';
          }
      } else {
          new_indicators << indicators[i];
      }
      i = i + 1;
    }

    print("======================");
    print("old lights: {indicators.join('')}");
    print("btn       : {button.join('')}");
    //wait();

    new_indicators;
}

fn solve_machine_with_min_presses(solution, lights, buttons, min_presses, cache) {
  N = [];

  for button in buttons {
    new_lights = press_button(lights, button);

    if new_lights == solution {
      return 0;
    }

    h = cache[new_lights];
    if (h != null) && ((min_presses + 1) >= h) {
      //print("====== SKIPPING ======");
      continue;
    }

    cache[new_lights] = min_presses + 1;

    //print("new lights: {new_lights.join('')}");
    N << new_lights;
  }

  needed_presses = @INT_MAX;

  for new_lights in N {
    p = solve_machine_with_min_presses(solution, new_lights, buttons, min_presses + 1, cache);

    if p < needed_presses {
      needed_presses = p;
    }
  }

  return needed_presses + 1;
}

part1 = 0;

for machine in machines {
  print("solving machine: {machine}");
  all_off = machine.indicators.map(fn(i) { '.'; });
  print(all_off);
  print(machine.indicators);
  s = solve_machine_with_min_presses(machine.indicators, all_off,
  machine.buttons, 0, {all_off: 0});
  print("min_presses: {s}");
  part1 = part1 +  s + 1;
}

print(part1);
