# Return the first element of an array to satisfy a predicate
find = (array, predicate) ->
  for x, i in array
    if predicate x, i then return x
  return null

# Assumes to get an array of arrays, with each inner array sorted ascending
longest-ascending-sequence = (array-of-arrays) ->

  { max } = array-of-arrays.reduce do
    (previous, next) ->

      # If this array has nothing to contribute (it's empty), just pass on the
      # current result
      if next.length is 0 then return previous

      # If the current state indicates we haven't found anything yet, then OK,
      # we've found at least this one now.
      if previous.got-to-number is null
        return max : 1, got-to-number : next.0

      # Otherwise we'll check if we've got a number larger than where we've
      # gotten to now, and return that with incremented max steps if so.
      minimum-exceeding = find next, (> previous.got-to-number)
      if minimum-exceeding?
        return max : (previous.max + 1), got-to-number : minimum-exceeding

      # Otherwise we didn't have any number that could continue the ascending
      # sequence, so just pass on the current result.
      return previous

    { # initial state
      max : 0              # the current length of the ascending sequence
      got-to-number : null # the highest number in the ascending sequence
    }

  return max

module.exports = scatter-match = (wishes, input) -->

  if wishes.length is 0 then return 1 # Empty wish matches anything
  if input.length  is 0 then return 0 # Empty input matches nothing

  wishes .= split ""
  input  .= split ""

  at-indices = []
  for _ til wishes.length then at-indices.push []

  input.for-each (input-char, input-index) ->

    for wish-char, wish-index in wishes

      if input-char is wish-char

        # Record that this wish char was found here
        at-indices[wish-index].push input-index

  if at-indices.every (.length is 0) then return 0 # nothing matched

  sequence-length = longest-ascending-sequence at-indices
  return sequence-length / wishes.length
