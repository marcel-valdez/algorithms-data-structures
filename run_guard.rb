kill_spork_manually = <<BASH
ps -ax | grep -i spork | grep -i -v  "grep.-i.spork" | awk '{print $1}' | xargs kill
BASH

kill_all_guard = <<BASH
ps -ax | grep -i bin/guard | grep -i -v "grep.*-i.*bin/guard" | awk '{print $1}' | xargs kill
BASH

system kill_spork_manually
system kill_all_guard
exec 'guard --no-bundler-warning -c'