module.exports = scatter-match = (characters, input) -->

  # Empty search string will always fully match
  if characters.length is 0 then return 1

  # Empty search target will never fully match
  if input.length is 0 then return 0

  characters .= split ""
  input      .= split ""

  n-wanted = characters.length

  n-matching  = 0
  n-processed = 0
  n-skipped   = 0
  n-not-found = 0

  input.for-each (i) ->
    if characters.length

      found-something = false

      for c, index in characters

        # console.log \index index
        # console.log \c c
        # console.log \i i
        # console.log "chars left" characters

        if i is c
          n-skipped += index
          ++n-matching
          characters := characters.slice (index + 1), characters.length
          found-something := true
          break

      if not found-something
        ++n-not-found

    else # no more characters to match; must be a trailing then
      ++n-not-found

    ++n-processed

  #console.log n-matching, n-wrong, n-wanted
  return n-matching / n-wanted
