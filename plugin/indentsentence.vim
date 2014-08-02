function! g:IndentSentence() range
  " execute a:firstline  . "," . a:lastline . 'join'
  let singleline = join(getline(a:firstline, a:lastline))
  let unfmt_lines = split(singleline, '\v(\.|;|!)\zs ')
  execute a:firstline.",".a:lastline."delete"
  call append(a:firstline-1, unfmt_lines)
  " From last to first line since gw will make lines move
  let curline = a:firstline - 1 + len(unfmt_lines)
  while curline >= a:firstline
    exe curline.",".curline."normal gww"
    " Indent newly created/wrapped lines
    let lastline = curline
    while getline(lastline) !~ '\v(\.|;|!)$'
      let lastline += 1
    endwhile
    if lastline > curline
      exe (curline+1).",".(lastline)."normal >>"
    endif
    let curline -= 1
  endwhile
endfunction
