#!/bin/sh
# Run from the node's folder, with these packs installed in packs/ (see the README):
#   sh packs/../../planetai-singapore-packs/tests/run.sh      (or copy tests/ into the node's tests/ and run each)
# The tests import each adapter by path ("packs/<id>/adapter.py"), the way the node's own tests/test_earth.py does.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
for t in "$HERE"/test_*.py; do PYTHONPATH=app python3 "$t"; done
python3 tools/check_rules.py | tail -1
