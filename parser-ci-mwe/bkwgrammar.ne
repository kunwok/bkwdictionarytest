@{%
    // Lexer library
    // https://github.com/no-context/moo
    const moo = require('moo');

    const myLexer = moo.compile({
        newline:    { match: '\n', lineBreaks: true },
        indent:     { match: /[\t\s]+/, lineBreaks: true },
        key:        { match: /\\[a-zA-Z]+\s/, value: x => x.replace(/\\|\s/g, "") },
        contents:   /.+$/
    });

%}

# Use # for comments in the grammar
# Specify to parser generator that you're using lexer defined above
@lexer myLexer

# Dictionary is made up of 1 or more headwords
dictionary ->
    headword:+
    
headword ->
    lexeme
    variant:?
    partOfSpeech
    senseEntry:+
    
senseEntry ->
    senseLabel
    definition
    
# Using Nearley macros: https://nearley.js.org/docs/grammar#macros
# to make it less repetetive when grabbing 'backslash-coded data', or 'bsdata'

bsdata[codeText] ->
    # 'newline' comes from the lexer, so access using '%newline'
    # 'codeText' comes from the macro argument, so use '$
    # name is not prefixed with $ or #, it should be defined as a (non-)terminal
    %newline:? %indent:? $codeText %contents
    
# Make sure to define non-terminals that use the macro after the macro has been defined. So, everything using bsdata is defined below bsdata

lexeme       -> bsdata["lx"]
variant      -> bsdata["va"]
partOfSpeech -> bsdata["ps"]
senseLabel   -> bsdata["sn"]
definition   -> bsdata["de"]
