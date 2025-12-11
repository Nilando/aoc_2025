input = read;

@counter = 0;
machine_name_map = {};

fn name_to_int(machine_name) {
  i = machine_name_map[machine_name];

  if i == null {
    x = @counter;
    machine_name_map[machine_name] = x;
    @counter = @counter + 1;
    return x;
  } else {
    return i;
  }
}

machines = input
  .split('\n')
  .filter(fn(l) { l != ""; })
  .map(fn(line) {
    split_line = line.split(':');
    outputs = (^split_line)
        .split(' ')
        .filter(fn(l) { l != ""; })
        .map(fn(name) { name_to_int(name); });
    name = name_to_int(^split_line);

    [name, outputs];
  });

machines = map(machines);

fn trace_paths_from_a_to_b(machine_name, destination) {
  if (@no_path_machines[machine_name]) == true {
    return 0;
  }

  h = @cache[machine_name];
  if h != null {
    return h;
  }

  outputs = machines[machine_name];

  @next_no_path_machines[machine_name] = true;

  paths = 0;
  for output in outputs {
    if output == out_machine || output == destination {
      if output == destination {
          paths = paths + 1;
      }
    } else {
      paths = paths + trace_paths_from_a_to_b(output, destination);
    }
  }

  @cache[machine_name] = paths;

  return paths;
}

out_machine = name_to_int("out");
dac_machine = name_to_int("dac");
fft_machine = name_to_int("fft");
svr_machine = name_to_int("svr");
you_machine = name_to_int("you");

@cache = {};
@no_path_machines = {};
@next_no_path_machines = {};
part1 = trace_paths_from_a_to_b(you_machine, out_machine);
print("part1 {part1}");

@cache = {};
@no_path_machines = {};
@next_no_path_machines = {};
dac_to_out = trace_paths_from_a_to_b(dac_machine, out_machine);

@no_path_machines = @next_no_path_machines;
@next_no_path_machines = {};
@cache = {};
fft_to_dac = trace_paths_from_a_to_b(fft_machine, dac_machine);

@no_path_machines = @no_path_machines.merge(@next_no_path_machines);
@next_no_path_machines = {};
@cache = {};
svr_to_fft = trace_paths_from_a_to_b(svr_machine, fft_machine);

// print("{svr_to_fft} => {fft_to_dac} => {dac_to_out}");
print("part2 {svr_to_fft * fft_to_dac * dac_to_out}");
