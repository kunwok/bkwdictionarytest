const ejs = require('ejs')
const getStdin = require('get-stdin')

var matchers_template = `
@{%

	const token_matcher = function(key_name) {
		// Nearley calls the function assigned to the "test" attribute
		// of an object, i.e. { test: function({}) => true/false }
		// to parse a stream of objects
		// https://nearley.js.org/docs/tokenizers#custom-token-matchers
		return {
			test: function(token) { return token.key == key_name }
		}
	}

	<% for(var i = 0; i < keys.length; i++) { %>
		const <%= keys[i] %> = token_matcher("<%= keys[i] %>")
	<% } %>

%}
`

getStdin()
	.then(schema_str => {

		var token_codes = Object.keys(JSON.parse(schema_str))

		var rendered_string = ejs.render(
			matchers_template,

			// data to inject into template
			{ "keys" : token_codes },

			// Empty options object
			{}
		)

		process.stdout.write(rendered_string)

	})
