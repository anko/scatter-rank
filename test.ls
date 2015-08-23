#!/usr/bin/env lsc

M = require \./index.js

test = (name, func) ->
  (require \tape) name, (t) ->
    func.call t   # Make `this` refer to tape's asserts
    t.end!        # Automatically end tests

to = ([ input1, input2 ], output, description) -->
  test description, -> (M input1, input2) |> @deep-equals _, output

[ '' '' ]    `to` 1 <| "matching for nothing"
[ 'abc' '' ] `to` 0 <| "matching for abc in nothing"

[ 'abc' 'def' ] `to` 0 <| "total mismatch"

[ 'abc' 'abc' ]  `to` 1 <| "exact match"
[ 'abc' 'abc_' ] `to` 1 <| "all matched, with 1 trailing (no problem)"
[ 'abc' '_abc' ] `to` 1 <| "all matched, with 1 leading"
[ 'abc' 'a_bc' ] `to` 1 <| "all matched, with 1 between"

[ 'abc' 'a' ] `to` (1/3) <| "1 matched at start"
[ 'abc' 'b' ] `to` (1/3) <| "1 matched in middle"
[ 'abc' 'c' ] `to` (1/3) <| "1 matched at end"

[ 'abc' 'ac' ]  `to` (2/3) <| "2 matched with 1 missing between"
[ 'abc' 'a_c' ] `to` (2/3) <| "2 matched with wrong between"
