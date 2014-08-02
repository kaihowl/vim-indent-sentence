vim-indent-sentence
===================

A simple addition to vim to indent sentences in tex files

Each sentence (ending in either full-stop, question mark, semicolon, or
exclamation mark) is put on its own line.
Sentences are wrapped according to ```textwidth```.
Wrapped lines are indented according to ```shiftwidth```.

This formatting makes tex source files easier to read and maintain in version
control.

This plugin just defines one global function, g:IndentSentence().

Installation
==============
Use vundle, pathogen, or whatever floats your boat.
With vundle it's an easy:
```
Bundle 'kaihowl/vim-indent-sentence'
```


Usage
==============

We recommend setting up simple keymappings in your vimrc:

```vim
" Indent Paragraph
nnoremap <leader>ip vip :call g:IndentSentence()<cr>
" Indent Sentence / Visual Selection
vnoremap <leader>is :call g:IndentSentence()<cr>
```
