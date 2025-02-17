" NOTE: You're meant to either source this from your .vimrc using "source /path/to/folder/my-configs/.vimrc"
" or use a symlink to this as your .vimrc.
" You can source it as many times as you like from as many different places and users as you like.
" I don't know about performance if you do it too many times though, because as you can see we're running defaults.vim
" at the top. I'm also not sure anymore what the difference between "source" and "runtime" is, I wrote this a while ago.

" Through this file existing, defaults.vim doesn't get run. This fixes that by forcibly running it before we do our custom stuff.
runtime defaults.vim

" Fixes some stuff to do with deleting. Makes sure specific delete commands don't automatically yank.
nnoremap dd "_dd

nnoremap dw "_dw
nnoremap dW "_dW

nnoremap db "_db
nnoremap dB "_dB

nnoremap x "_x

" Mappings for moving text around easily.
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>
vnoremap <S-Up> :m'<-2<CR>gv
vnoremap <S-Down> :m'>+1<CR>gv

" Prevents vim from wrapping comments and placing comment character on new line.
" The if statement is like an include guard in C, it prevents redefinition if this file is run multiple times by another file.
" autocmd means that set will run when vim starts letting me interact with a buffer (BufEnter) for every file-type that I try to open (*).
" using BufEnter instead of VimEnter means that this will happen again for every buffer, which is the desired behaviour here.
if !exists("autocommands_loaded")
	autocmd BufEnter * set formatoptions-=c
	autocmd BufEnter * set formatoptions-=r
	autocmd BufEnter * set formatoptions-=o
	let autocommands_loaded = 1
endif

" Prevents accessing directories with vim, because it's annoying when it accidentally happens and who would ever even want to.
" It's still possible if you use the ":e" command from inside vim, but that's less likely so it isn't a problem for me.
for f in argv()
	if isdirectory(f)
		echomsg "vimrc: directory access disabled, cannot access " . f
		quit
	endif
endfor

" Sometimes vim is set up so that searching for stuff creates highlighted text spots that don't disappear when you close and reopen.
" This turns that setting off.
set nohls

" Platform-specific changes:
if has("win32")

	" Fixes yanking and putting so that they use the system clipboard instead of default vim register.
	set clipboard=unnamed

	" Makes it so that the newline character at the end of a line is not accidentally selected while using cursor in visual mode.
	behave mswin
	set selectmode=""	" The above command sets a couple of things that make it more windows compatible I guess. We don't want this thing though, so we set it back here.

	" Shift + Backspace and Ctrl + Backspace don't work on my Windows system because Windows for some reason sends three different key codes for normal <BS>, <BS> + Shift and
	" <BS> + Ctrl. They're also not control characters, they're some kind of escape codes, they consist of multiple characters. Here, I've fixed the problem by remapping the
	" two escape codes that don't work to <BS>, allowing them to work.
	nnoremap Îy <BS>
	nnoremap Îz <BS>
	inoremap Îy <BS>
	inoremap Îz <BS>
	vnoremap Îy <BS>
	vnoremap Îz <BS>

	" SIDE-NOTE: noremap doesn't do what you think it does. All it does is prevent recursive mapping, it doesn't prevent you from overwriting previous mappings.

else

	" Linux without a graphical overlay (headless, just console) doesn't support any clipboards.
	" To fix this issue, using these commands will write selection to tmp file which can be read from again so simulate copying and pasting.
	"vnoremap <leader>y :w! /tmp/vimcopytemp<CR>
	"vnoremap <leader>d :w! /tmp/vimcopytemp<CR>gvd
	"nnoremap <leader>p :r! cat /tmp/vimcopytemp<CR>
	" TODO: You're not allowed to have this until you make it work in a multi-user environment.

endif
