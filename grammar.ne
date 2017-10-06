# Do not remove this @include line!
@include "_artifacts/token_matchers.ne"

# This part should be user-entered

headword 		-> %lx grammaticalInfo senseInfo %dt

grammaticalInfo -> %ps %ge %re

senseInfo 		-> %de:+ %ng:*
