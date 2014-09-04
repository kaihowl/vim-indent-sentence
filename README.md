vim-indent-sentence
===================

A simple addition to vim to indent sentences in tex files

Each sentence (ending in either full-stop, question mark, colon, semicolon, or
exclamation mark) is put on its own line.
Sentences are wrapped according to ```textwidth```.
Wrapped lines are indented according to ```shiftwidth```.

This formatting makes tex source files easier to read and maintain in version
control.

This plugin just defines one global function, g:IndentSentence().

Example
===============
You might have written the following sentences in tex:

```tex
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tempus ligula
molestie dapibus cum vestibulum - duis interdum taciti nascetur: senectus
cursus litora. Pharetra sociis hac ligula semper facilisi aliquam viverra duis
velit proin; habitasse libero nibh. Pharetra donec augue porta elementum eu
vitae fringilla proin dolor lorem, at nam mauris. Ridiculus turpis morbi nec
viverra justo elit: parturient adipiscing penatibus maecenas - vulputate ad
curabitur! Nisi iaculis Ullamcorper pulvinar convallis commodo, ultricies elit
etiam interdum penatibus sem varius quis?
```

This is hard to read. But more importantly, it gets messy when maintaining this
in a line-based version control system.
Therefore the following format is a best practise for tex source files:

```tex
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Donec tempus ligula molestie dapibus cum vestibulum - duis interdum taciti
  nascetur:
senectus cursus litora.
Pharetra sociis hac ligula semper facilisi aliquam viverra duis velit proin;
habitasse libero nibh.
Pharetra donec augue porta elementum eu vitae fringilla proin dolor lorem, at
  nam mauris.
Ridiculus turpis morbi nec viverra justo elit:
parturient adipiscing penatibus maecenas - vulputate ad curabitur!
Nisi iaculis Ullamcorper pulvinar convallis commodo, ultricies elit etiam
  interdum penatibus sem varius quis?
```

This format can easily be achieved by using g:IndentSentence which accepts
a range.
See usage below for examples on key mappings.

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

Alternatively, you can also define a reformat paragraph keymapping which will
restore your original cursor position.
Please note, though, that this haphazardly works by inserting, finding, and
deleting the string "//CURSOR//":
```vim
nnoremap <leader>ip i//CURSOR//<esc>vip :call g:IndentSentence()<cr>:%s/\/\/CURSOR\/\///<cr>
```
