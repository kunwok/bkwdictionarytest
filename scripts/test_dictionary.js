const Ajv      = require('ajv')
const path     = require('path')
const jsonfile = require('jsonfile')

const nearley  = require('nearley')
const grammar  = require('../_artifacts/grammar.js')

var dictionary    = jsonfile.readFileSync(path.resolve(__dirname, "../_artifacts", "dictionary.json"))
var token_schemas = jsonfile.readFileSync(path.resolve(__dirname, "../", "schema.json"))

// Subsetting for current demo
dictionary.records = dictionary.records.slice(0, 2).map(token_array => {

	let return_object = {}

	return_object.tokens = token_array.map(

		token => {
			var token_schema = token_schemas[token.key]

			if (token_schema == undefined) {

				token.valid = false
				token.errors = { "message": 'backslash code "' +  token.key + '" not defined in schema' }
				
			} else {

				var validate = new Ajv().compile(token_schema)
	
				token.valid = validate(token.value)
				token.errors = token.valid == false ? validate.errors : null

			}

			return token
		}

	)

	var parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar))

	try {
		parser.feed(token_array)
	} catch(parse_error) {
	    // slice(0, 6) omits source code location, e.g. "at nearley.js on line 1234"
	    return_object.parse_error = { "error" : parse_error.stack.split(/\n/).slice(0, 6).join("<br />") }

	}

	if(!return_object.parse_error) {
		return_object.parse_result = parser.results
	}

	return return_object

})

jsonfile.writeFileSync(
	path.resolve(__dirname, "../_artifacts", "dictionary_tested.json"),
	dictionary
)

console.log(JSON.stringify(dictionary, null, "\t"))

// process.stderr.write("I know there are failed tests, check /_artifacts/dictionary_tested.json file\n")
// process.exit(1)
