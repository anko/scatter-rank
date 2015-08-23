module.exports = scatter-match = (characters, input) -->

  # Empty search string will always fully match
  if characters.length is 0 then return 1

  # Empty search target will never fully match
  if input.length is 0 then return 0

  characters .= split ""
  input      .= split ""

  n-wanted    = characters.length
  n-matching  = 0

  input.for-each (i) ->

    if characters.length

      for c, index in characters

        if i is c
          ++n-matching
          characters := characters.slice (index + 1), characters.length
          break

  return n-matching / n-wanted
