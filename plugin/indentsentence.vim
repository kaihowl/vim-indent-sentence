function! g:IndentSentence() range
  " save cursor position for restore at end
  let save_cursor = getpos(".")

  let sentence_stops = ['\.', '\;', '\!', '\:', '\?']
  let regex_stop = '\v('.join(sentence_stops, '|').')'
  "stop marker has to end in a valid sentence stop
  let stopmarker = 'STOPMARKER.'

  " Left-right Trim old lines
  exe 'silent!'.a:firstline.",".a:lastline.'s/\v^ *//ge'
  exe 'silent!'.a:firstline.",".a:lastline.'s/\v *$//ge'

  " Mask all present occurences of STOPMARKER.
  exe 'silent!'.a:firstline.",".a:lastline.'s/'.stopmarker.'/\\\\'.stopmarker.'/ge'

  " Join to single line
  let prev_joinspaces = &joinspaces
  set nojoinspaces
  exe a:firstline.",".( a:lastline ).'join'
  let &joinspaces = prev_joinspaces

  " append stop marker
  " This ensures that the selection will end with a line containing a period
  call append(a:firstline, stopmarker)

  " Break up in sentences
  exe 'silent!'.a:firstline.'s/'.regex_stop.'\zs /\r'

  " From last to first line since gw will make lines move
  " Since we wrap lines, stopmarker will move further down
  let curline = search("^".stopmarker."$")
  while curline >= a:firstline
    exe curline.",".curline."normal gww"

    " Indent newly created/wrapped lines
    " Search forward till either sentence end or stopmarker found
    " This will terminate, because we have the stop marker ending in a valid
    "   sentence stop
    let lastline = curline
    while getline(lastline) !~ regex_stop.'$'
      let lastline += 1
    endwhile

    " Check if lastline is placed on stopmarker
    if (search("\^".stopmarker."\$") == lastline)
      let lastline -= 1
    endif

    " If new lines were created from wrapping the sentence:
    if lastline > curline
      exe (curline+1).",".(lastline)."normal >>"
    endif

    let curline -= 1
  endwhile

  " Delete superfluous stop marker
  let stopmarkerline = search("\^".stopmarker."\$")
  exe stopmarkerline." delete"
  let new_lastline = line(".") - 1

  " Convert masked STOPMARKER occurences back
  exe 'silent!'.a:firstline.",".new_lastline.'s/\\\\'.stopmarker.'/'.stopmarker.'/ge'

  " restore cursor position
  call setpos('.', save_cursor)
endfunction
