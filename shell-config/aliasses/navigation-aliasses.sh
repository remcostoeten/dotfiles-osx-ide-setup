# -----------------------------------------------------------------------------
# Alias related to navigation
# -----------------------------------------------------------------------------

export ROOT="$HOME"
export EXACT_DIR="$HOME/projects"
export BOUW="$EXACT_DIR/Bouw7"

# Navigate without having to type cd for backwards.
# e.g. 1 = cd .. | 2 = cd ../.. | 3 = cd ../../..
for i in {1..10}; do
  alias $i="cd $(printf '../%.0s' $(seq 1 $i))"
done
