const getStdin = require('get-stdin')

const tokenize = function(lexicon_string) {
	return { "records" : 

		// record-level split
		lexicon_string.split(/\n*[\s\t]*(?=\\lx\s)/)
		
		// within records, do token-level split
		.map(
				// splits a string "\\lx bla ... \ps bla" => ["\\lx bla", "\\ps bla"]
				record_string => record_string.split(/\n?[\s\t]*(?=\\[a-z|_]+)/)
			)

		.map(
				// convert token strings ["\ps Noun", ...] to
				// JSON objects [{ "type" : "ps", "value" : "Noun" }, ... ]
				token_string_array  => token_string_array.map(

					function(token_string) {

						var keyValueBits = token_string.match(/\\([a-z|_]+)\s([\s\S]*)/)

						return { key:   keyValueBits[1], value: keyValueBits[2] }

					})
			)
	}

}

getStdin().then(
	stdin_str => {
		var dictionary_json = JSON.stringify(tokenize(stdin_str), {}, "\t")

		process.stdout.write(dictionary_json)
	})
