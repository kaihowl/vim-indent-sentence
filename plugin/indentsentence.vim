function! g:IndentSentence() range
  let sentence_stops = ['\.', '\;', '\!', '\:', '\?']
  let regex_stop = '\v('.join(sentence_stops, '|').')'

  " Left-right Trim old lines
  exe 'silent!'.a:firstline.",".a:lastline.'s/\v^ *//ge'
  exe 'silent!'.a:firstline.",".a:lastline.'s/\v *$//ge'

  " Mask all present occurences of STOPMARKER.
  exe 'silent!'.a:firstline.",".a:lastline.'s/STOPMARKER./\\\\STOPMARKER./ge'

  let singleline = join(getline(a:firstline, a:lastline))
  let unfmt_lines = split(singleline, regex_stop.'\zs ')

  " append stop marker
  " This ensures that the paragraph will end with a line containing a period
  let unfmt_lines += ["STOPMARKER."]

  execute a:firstline.",".a:lastline."delete"
  call append(a:firstline-1, unfmt_lines)
  " From last to first line since gw will make lines move
  let curline = a:firstline - 1 + len(unfmt_lines)
  while curline >= a:firstline
    exe curline.",".curline."normal gww"
    " Indent newly created/wrapped lines
    let lastline = curline
    " This will terminate, because we have the stop marker added
    while getline(lastline) !~ regex_stop.'$'
      let lastline += 1
    endwhile
    if lastline > curline
      exe (curline+1).",".(lastline)."normal >>"
    endif
    let curline -= 1
  endwhile

  " Delete superfluous stop marker
  /\v^ *STOPMARKER\.$/
  normal dd
  let new_lastline = getpos(".")[1] - 1

  " Convert masked STOPMARKER occurences back
  exe 'silent!'.a:firstline.",".new_lastline.'s/\\\\STOPMARKER./STOPMARKER./ge'
endfunction
