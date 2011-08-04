if exists("g:loaded_related")
  finish
endif

let g:load_related = 1

fun! Related()
python <<EOF
import vim
from yahoo.search.web import RelatedSuggestion

search = RelatedSuggestion(app_id='vimsearch', query=vim.current.line)
results = search.parse_results()
msg = 'Related popular searches are:\n'
for i, result in enumerate(results):
  msg += '%d. %s\n' %  (i+1, result)

print msg
EOF
endfun
