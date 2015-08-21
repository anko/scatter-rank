module.exports = scatter-match = (characters, input) -->

  characters .= split ""
  chars-optional-grouped = characters.map -> "(#it)?"

  matcher = new RegExp "^.*?#{chars-optional-grouped.join ".*?"}.*?$"
  console.log matcher
  [ _, ...groups ] = matcher.exec input
  total-matched = groups.reduce do
    (total, group) -> if group then ++total else total
    0

  console.log groups
  return total-matched
