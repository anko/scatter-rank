# scatter-rank [![](https://img.shields.io/travis/anko/scatter-rank.svg?style=flat-square)][1]

This is a very similar (identical?) matcher algorighm as behind [TextMate][2]'s
<kbd>Cmd</kbd>+<kbd>T</kbd> feature, [the `command-t` vim plugin][3] and [Emacs
Icicles `scatter-match` completion][4], as a Node.js library.

Exports a function that looks for a subsequence of a given sequence of
characters in an input string, ignoring other characters, and outputs what
proportion of that sequence was found, as a number between 0 and 1.

Kind of like `/.*a.*b.*c.*/`, while counting the longest a-b-c subsequence.

## Why

This works great to rank some text items from which a user wants to choose one
really quickly by approximately typing it.  The heuristic is simple,
predictable and tolerates abbreviations and inaccurate typing.

For example, a user might type "nsfudt", and scatter-rank would find that it
matches *100%* with "node js foundation" (because all the letters are there in
the right order), *somewhat* also with "apache foundation" (because "fudt" is
in there) and *hardly at all* with "wikipedia" (because only the "d" would
hit).

## Examples

    var rank = scatterRank("abcd");

    rank("abcd")        // => 1     all OK
    rank("abc")         // => 0.75  "d" wasn't found
    rank("XYZ")         // => 0     nothing found
    rank("gah")         // => 0.25  only "a" found
    rank("_a___b_c_d_") // => 1     all OK
    rank("dcba")        // => 0.25  only "d" found; rest were out of order
    rank("cab")         // => 0.5   "ab" was longest matching subsequence

Alternatively, pass the *string to search in* as second parameter:

    scatterRank("abcd", "i know my abcs") // => 0.75

## Related libraries

-   [*fast-levenshtein*][5] is better for ranking mispellings and
    approximations, but too rigid for abbreviations to match well.

-   [*string_score*][6] is like a fuzzy, more complex version of this.  It's
    better for natural language use-cases where you don't necessarily know much
    about the string you're looking for.  Modifies the `String` prototype.

-   [*fuzzy*][7] is more complex, can't produce a rank value, and to be honest
    I don't understand what it does.

-   [*fuzzy-filter*][8] can filter strings for matches and do fancy
    highlighting stuff, but also can't produce a similarity value.

## License

[ISC][9].

[1]: https://travis-ci.org/anko/scatter-rank
[2]: https://macromates.com/
[3]: https://github.com/wincent/Command-T
[4]: http://www.emacswiki.org/emacs?action=browse;oldid=Icicles_-_Fuzzy_Completion;id=Icicles_-_Completion_Methods_and_Styles#toc7
[5]: https://github.com/hiddentao/fast-levenshtein
[6]: https://github.com/joshaven/string_score
[7]: https://github.com/mattyork/fuzzy
[8]: https://github.com/stratuseditor/fuzzy-filter
[9]: http://opensource.org/licenses/ISC
