" Run from the repository root with VIM_MISC_PATH set to the vim-misc checkout.
set nomodeline encoding=utf-8
if !filereadable($VIM_MISC_PATH . '/autoload/xolox/misc.vim')
  echoerr 'Set VIM_MISC_PATH to the vim-misc checkout'
  cquit
endif
execute 'set runtimepath^=' . fnameescape($VIM_MISC_PATH)
execute 'set runtimepath^=' . fnameescape(getcwd())

" Populate the real title cache without creating any note files.
let g:notes_directories = []
let g:notes_word_boundaries = 0
call xolox#notes#get_titles(0)
let s:short = 'Projet'
let s:long = 'Projet étude SQL'
let s:cache_root = tempname()
call xolox#notes#cache_add(s:cache_root . '/short', s:short)
call xolox#notes#cache_add(s:cache_root . '/long', s:long)
call setline(1, ['Titre du tampon', 'cf. ' . s:long, 'cf. ' . s:short])
syntax sync fromstart

for s:bucket in ['small', 'shared prefixes']
  if s:bucket ==# 'shared prefixes'
    for s:i in range(1, 30)
      call xolox#notes#cache_add(s:cache_root . '/' . s:i, printf('Projet Alpha %03d', s:i))
    endfor
  endif
  for s:engine in [0, 1, 2]
    let &regexpengine = s:engine
    let s:case = printf('%s, regexpengine=%d', s:bucket, s:engine)
    call xolox#notes#highlight_names(1)
    call assert_equal('notesName', synIDattr(synID(2, strlen(getline(2)), 1), 'name'), s:case . ': full title')
    call assert_equal('notesName', synIDattr(synID(3, strlen(getline(3)), 1), 'name'), s:case . ': short title')
    call assert_equal(s:engine, &regexpengine, s:case . ': global option unchanged')
  endfor
endfor

if !empty(v:errors)
  for s:error in v:errors
    echomsg s:error
  endfor
  cquit
endif
qa!
