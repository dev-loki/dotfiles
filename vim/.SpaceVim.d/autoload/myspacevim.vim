function! myspacevim#before() abort
  let g:user_emmet_leader_key = '<C-e>'
  let g:neoformat_python_black = { 'exe': 'black', 'stdin': 1, 'args': ['-q', '-'] }
  let g:neoformat_enabled_python = ['black']
endfunction

function! myspacevim#after() abort
  let g:user_emmet_leader_key='<C-e>'
endfunction
