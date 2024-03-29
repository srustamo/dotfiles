"Packaging
	let g:pathogen_disabled = []
	call add(g:pathogen_disabled, 'lusty')
	" call add(g:pathogen_disabled, 'ctrlp.vim')
	" call add(g:pathogen_disabled, 'ctrlp-z.vim')
	" call add(g:pathogen_disabled, 'ctrlp_bdelete.vim')
	" call add(g:pathogen_disabled, 'ctrlp_mark')
	" call add(g:pathogen_disabled, 'nerdtree')
	" call add(g:pathogen_disabled, 'onehalf')
	" call add(g:pathogen_disabled, 'tmuxline.vim')
	call add(g:pathogen_disabled, 'undoquit.vim')
	call add(g:pathogen_disabled, 'vim-airline')
	call add(g:pathogen_disabled, 'vim-airline-themes')
	" call add(g:pathogen_disabled, 'vim-colors-solarized')
	" call add(g:pathogen_disabled, 'vim-commentary')
	" call add(g:pathogen_disabled, 'vim-fugitive')
	" call add(g:pathogen_disabled, 'vim-gitgutter')
	call add(g:pathogen_disabled, 'vim-minimap')
	" call add(g:pathogen_disabled, 'vim-orgmode')
	call add(g:pathogen_disabled, 'vim-speeddating')
	call add(g:pathogen_disabled, 'vim-unimpaired')
	" call add(g:pathogen_disabled, 'vim-vinegar')
	" call add(g:pathogen_disabled, 'vim-which-key')
	call add(g:pathogen_disabled, 'vim-xkbswitch')
	call add(g:pathogen_disabled, 'fzf.vim')
	" call add(g:pathogen_disabled, 'lightline.vim')
" lusty
" nerdtree
" onehalf
" tmuxline.vim
" undoquit.vim
" vim-airline
" vim-airline-themes
" vim-colors-solarized
" vim-commentary
" vim-fugitive
" vim-gitgutter
" vim-minimap
" vim-orgmode
" vim-speeddating
" vim-unimpaired
" vim-vinegar
" vim-which-key
" vim-xkbswitch
	call add(g:pathogen_disabled, 'vim-xkbswitch')
	execute pathogen#infect()
	syntax on
	filetype plugin indent on

	
" map f <Plug>Sneak_s
" map F <Plug>Sneak_S
" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


" " disable theme in terminal vim
"     if !has("gui_running")
"         colorscheme default
"         " for which-key and floatwindow of fzf
"         highlight Pmenu guibg=#3A3A3A
"     endif
" let g:which_key_use_floating_win = 1

"Buffers and bell
	"7 Mar 2014
	set hidden
	set belloff=all
"Windows
	"undoquit.vim plugin Sat Dec  2 01:03:25 2017 in submodule
	"Fri 15 May 2020 01:24:09 PM +05
	"https://vi.stackexchange.com/questions/12376/vim-on-wsl-synchronize-system-clipboard-set-clipboard-unnamed
	if system('uname -r') =~ "Microsoft"
		augroup Yank
			autocmd!
			autocmd TextYankPost * :call system('clip.exe ',@")
		augroup END
		noremap "+p :exe 'norm a'.system('/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard')<CR>
	endif
"Load files
	" source $HOME/.vim/setup/uniterc.vim
	"
"Remaps
	" 26_06_2015
	" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
	nnoremap <SPACE> <Nop>
	"let mapleader = "\<SPACE>"
	"let mapleader=" "
	let mapleader = "\<space>"
	" Shortcut to rapidly toggle `set list`
	nmap <leader>l :set list!<CR>
	"5 Mar 2014 also in iTerm set S Space to hex 0x15 for <C-u> to work
	"http://stackoverflow.com/questions/279959/how-can-i-make-shiftspacebar-page-up-in-vim
	"nnoremap <Space> <C-f>
	"nnoremap <S-Space> <C-b>

	"26_06_2015
	"http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
	nnoremap <Leader>w :w<CR>

	"Thu Oct 25 13:24:47 2018
	" nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
	" nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

	"insert date   Sat Dec  2 00:38:41 UZT 2017
	:nnoremap <F3> "=strftime("%c")<CR>P
	:inoremap <F3> <C-R>=strftime("%c")<CR>

	"Unimpaired  https://github.com/tpope/vim-unimpaired Sat Dec  2 00:40:56 UZT 2017
	nmap < [
	nmap > ]
	omap < [
	omap > ]
	xmap < [
	xmap > ]

	"undoquit plugin https://github.com/AndrewRadev/undoquit.vim Sat Dec 2 00:57:48 2017
	"A known problem is that the plugin doesn't work for <c-w>c, since that mapping doesn't
	"seem to throw a QuitPre autocommand. If you use it, you could make it work by calling
	"the undoquit "save history" function manually:
	nnoremap <c-w>c :call undoquit#SaveWindowQuitHistory()<cr><c-w>c
"Leader maps
	" 26_06_2015
	"https://www.reddit.com/r/vim/comments/1vdrxg/space_is_a_big_key_what_do_you_map_it_to/
	"Thu Oct 25 13:36:45 2018
	"removed, it would not WhichKey work
	" nnoremap <SPACE> <Nop>
	" map <Space> :
	map <CR> <Leader>

	" 26_06_201
	" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
	vmap <Leader>y "+y
	vmap <Leader>d "+d
	nmap <Leader>p "+p
	nmap <Leader>P "+P
	vmap <Leader>p "+p

	" 26_06_2015
	" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
	"nnoremap <SPACE> <Nop>
	"let mapleader = "\<SPACE>"
	"let mapleader=" "
	"let mapleader = "\<space>"

	" 11 Jul 2014
	"let maplocalleader = '\'

	"23_Dec_14 https://medium.com/@mozhuuuuu/vimmers-you-dont-need-nerdtree-18f627b561c3
	map <leader>k :E<cr>
"UI
	"http://stackoverflow.com/questions/16047146/disable-bell-in-macvim
	" 26_06_2015
	set noerrorbells
	set novisualbell
	autocmd! GUIEnter * set vb t_vb=
	" Use the same symbols as TextMate for tabstops and EOLs
	set listchars=tab:▸\ ,eol:¬,trail:.
	
	"Invisible character colors 25/12/2013 - this should go into colorschme 30 Dec 2013
	"highlight NonText guifg=#4a4a59
	"highlight SpecialKey guifg=#4a4a59
	"tesing git
	
	"26 Feb 2014
	"let macvim_skip_colorscheme=1
	" colorscheme zenburn
	" colorscheme delek
	" 28_12_2015
	call togglebg#map("")
	" so ~/.vim/colors/vim-colors-solarized/autoload/togglebg.vim
	" let g:solarized_termtrans = 1
	colorscheme solarized
	set background=light
	" 2 Mar 2014 looks this works only in gui Vim; tried this in MacVim, not much
	"success
	"set gcr=a:block
	"
	""mode aware cursors
	"set gcr+=o:hor50-Cursor
	"set gcr+=n:Cursor
	"set gcr+=i-ci-sm:InsertCursor
	"set gcr+=r-cr:ReplaceCursor-hor20
	"set gcr+=c:CommandCursor
	"set gcr+=v-ve:VisualCursor
	"
	"set gcr+=a:blinkon0
	"
	"hi InsertCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=37  guibg=#2aa198
	"hi VisualCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#d33682
	"hi ReplaceCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#dc322f
	"hi CommandCursor ctermfg=15 guifg=#fdf6e3 ctermbg=33  guibg=#268bd2
	"
	" 2 Apr 2014 http://blog.ezyang.com/2010/03/vim-textwidth/
	" disabled
	"augroup vimrc_autocmds
	"	  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
	"	  autocmd BufEnter * match OverLength /\%74v.*/
	"augroup END

	" 2 Apr 2014 http://youtu.be/aHm36-na4-4#t=2m52s
	"highlight ColorColum ctermbg=magenta
	"call matchadd('ColorColum', '\%81v', 100)
	
	"gui font
	set guifont=Inconsolata:h16
	"23_Dec_14 {{{
	"https://github.com/blaenk/dots/blob/275b3b40fa0c57f1b48b5ba59b9ecbc00cddf866/vim/vimrc.ln#L80-L202
	if has('unix') && 'Darwin' == system('echo -n "$(uname)"')
		" mac
		" set gfn=Menlo\ for\ Powerline:h12
		" set gfn=PragmataPro\ Nerd\ Font:h12
		set gfn=Hack\ NF:h14
	endif
	"}}}
	"
	"25_Dec_14 http://superuser.com/questions/771558/line-length-highlighting-works-correctly-in-console-vim-not-gui
	"this solves the issue of colum not bing highlighted in guivim
	" highlight MyLineTooLongMarker ctermbg=magenta guibg=Magenta
	highlight MyLineTooLongMarker ctermbg=LightGray guibg=Magenta
	call matchadd('MyLineTooLongMarker', '\%81v', 100)

	" if strftime("%H") < 17
	" 	set background=light
	" else
	" 	set background=dark
	" endif
"DBEXT
	let g:dbext_default_profile_sqlite = 'type=SQLITE:dbname=~/Databases/Movies.db'
	set number
	"06_02_2015 David Fishburn
	"https://mail.google.com/mail/u/0/#inbox/1435ba837118f895
	let g:loaded_dbext = 1
"VIMROOM
	"let g:vimroom_background = "white"
	"let g:vimroom_guibackground = "white"
"Help system
	"27 Feb 2014
	"http://djcraven5.blogspot.com/2006/10/mastering-vim-help-system.html
	autocmd BufWrite mytips.txt	    :helptags ~/.vim/doc/
	autocmd BufRead  mytips.txt	    set filetype=help
	autocmd BufRead  mytips.txt	    set noreadonly
	autocmd BufRead  mytips.txt	    set modifiable

	nmap <leader>h :tabnew ~/.vim/doc/mytips.txt<CR>
"VimOrganizer
	""\ 11 Jul 2014 15 Aug 2014 this if from VimOrganizer https://github.com/hsitz/VimOrganizer ___ this does not work with vim-orgmode
	"" This is an example vimrc that should work for testing purposes.
	"" Integrate the VimOrganizer specific sections into your own
	"" vimrc if you wish to use VimOrganizer on a regular basis.
	"
	""===================================================================
	"" THE NECESSARY STUFF
	"" The three lines below are necessary for VimOrganizer to work right
	"" ==================================================================
	"let g:ft_ignore_pat = '\.org'
	"filetype plugin indent on
	"" and then put these lines in vimrc somewhere after the line above
	"au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
	"au BufEnter *.org            call org#SetOrgFileType()
	"let g:org_capture_file = '~/org_files/mycaptures.org'
	"command! OrgCapture :call org#CaptureBuffer()
	"command! OrgCaptureFile :call org#OpenCaptureFile()
	""syntax on
	"
	""==============================================================
	"" THE UNNECESSARY STUFF
	""==============================================================
	""  Everything below here is a customization.  None are needed.
	""==============================================================
	"
	"" The variables below are used to define the default Todo list and
	"" default Tag list.  Both of these can also be defined
	"" on a document-specific basis by config lines in a file.
	"" See :h vimorg-todo-metadata and/or :h vimorg-tag-metadata
	"" 'TODO | DONE' is the default, so not really necessary to define it at all
	"let g:org_todo_setup='TODO | DONE'
	"" OR, e.g.,:
	""let g:org_todo_setup='TODO NEXT STARTED | DONE CANCELED'
	"
	"" include a tags setup string if you want:
	"let g:org_tags_alist='{@home(h) @work(w) @tennisclub(t)} {easy(e) hard(d)} {computer(c) phone(p)}'
	""
	"" g:org_agenda_dirs specify directories that, along with
	"" their subtrees, are searched for list of .org files when
	"" accessing EditAgendaFiles().  Specify your own here, otherwise
	"" default will be for g:org_agenda_dirs to hold single
	"" directory which is directory of the first .org file opened
	"" in current Vim instance:
	"" Below is line I use in my Windows install:
	"" NOTE:  case sensitive even on windows.
	"let g:org_agenda_select_dirs=["~/desktop/org_files"]
	"let g:org_agenda_files = split(glob("~/desktop/org_files/org-mod*.org"),"\n")
	"
	"" ----------------------
	"" Emacs setup
	"" ----------------------
	"" To use Emacs you will need to define the client.  On
	"" Linux/OSX this is typically simple, just:
	"let g:org_command_for_emacsclient = 'emacsclient'
	""
	"" On Windows it is more complicated, and probably involves creating
	"" a 'soft link' to the emacsclient executable (which is 'emacsclientw')
	"" See :h vimorg-emacs-setup
	""let g:org_command_for_emacsclient = 'c:\users\herbert\emacsclientw.exe'
	"
	"" ----------------------
	"" Custom Agenda Searches
	"" ----------------------
	"" The assignment to g:org_custom_searches below defines searches that a
	"" a user can then easily access from the Org menu or the Agenda Dashboard.
	"" (Still need to add help on how to define them, assignment below
	"" is hopefully illustrative for now. . . . )
	"let g:org_custom_searches = [
	"            \  { 'name':"Next week's agenda", 'type':'agenda',
	"            \    'agenda_date':'+1w', 'agenda_duration':'w' }
	"            \, { 'name':"Next week's TODOS", 'type':'agenda',
	"            \    'agenda_date':'+1w', 'agenda_duration':'w',
	"            \    'spec':'+UNFINISHED_TODOS' }
	"            \, { 'name':'Home tags', 'type':'heading_list', 'spec':'+HOME' }
	"            \, { 'name':'Home tags', 'type':'sparse_tree', 'spec':'+HOME' }
	"            \  ]
	"
	"" --------------------------------
	"" Custom colors
	"" --------------------------------"
	"" OrgCustomColors() allows a user to set highlighting for particular items
	"function! OrgCustomColors()
	"    " Various text item 'highlightings' below
	"    " are the defaults.  Uncomment and change a line if you
	"    " want different highlighting for the element.
	"    "
	"    " Below are defaults for any TODOS you define.  TODOS that
	"    " come before the | in a definition will use  'NOTDONETODO'
	"    " and those that come after are DONETODO
	"    "hi! DONETODO guifg=green ctermfg=green
	"    "hi! NOTDONETODO guifg=red ctermfg=lightred
	"
	"    " Heading level highlighting is done in pairs, one for the
	"    " heading when unfolded and one for folded.  Default is to make
	"    " them the same except for the folded version being bold:
	"    " assign OL1 pair for level 1, OL2 pair for level 2, etc.
	"    "hi! OL1 guifg=somecolor guibg=somecolor
	"    "hi! OL1Folded guifg=somecolor guibg=somecolor gui=bold
	"
	"
	"    " Tags are lines below headings that have :colon:separated:tags:
	"    "hi! Org_Tag guifg=lightgreen ctermfg=blue
	"
	"    " Lines that begin with '#+' in column 0 are config lines
	"    "hi! Org_Config_Line guifg=darkgray ctermfg=magenta
	"
	"    " Drawers are :PROPERTIES: and :LOGBOOK: lines and their associated
	"    " :END: lines
	"    "hi! Org_Drawer guifg=pink ctermfg=magenta
	"    "hi! Org_Drawer_Folded guifg=pink ctermfg=magenta gui=bold cterm=bold
	"
	"    " This applies to value names in :PROPERTIES: blocks
	"    "hi! Org_Property_Value guifg=pink ctermfg=magenta
	"
	"    " Three lines below apply to different kinds of blocks
	"    "hi! Org_Block guifg=#555555 ctermfg=magenta
	"    "hi! Org_Src_Block guifg=#555555 ctermfg=magenta
	"    "hi! Org_Table guifg=#888888 guibg=#333333 ctermfg=magenta
	"
	"    " Dates are date specs between angle brackets (<>) or square brackets ([])
	"    "hi! Org_Date guifg=magenta ctermfg=magenta gui=underline cterm=underline
	"
	"    " Org_Star is used to "hide" initial asterisks in a heading
	"    "hi! Org_Star guifg=#444444 ctermfg=darkgray
	"
	"    "hi! Props guifg=#ffa0a0 ctermfg=gray
	"
	"    " Bold, italics, underline, and code are highlights applied
	"    " to character formatting
	"    "hi! Org_Code guifg=darkgray gui=bold ctermfg=14
	"    "hi! Org_Itals gui=italic guifg=#aaaaaa ctermfg=lightgray
	"    "hi! Org_Bold gui=bold guifg=#aaaaaa ctermfg=lightgray
	"    "hi! Org_Underline gui=underline guifg=#aaaaaa ctermfg=lightgray
	"    "hi! Org_Lnumber guifg=#999999 ctermfg=gray
	"
	"    " These lines apply to links: [[link]], and [[link][link desc]]
	"    "if has("conceal")
	"    "    hi! default linkends guifg=blue ctermfg=blue
	"    "endif
	"    "hi! Org_Full_Link guifg=cyan gui=underline ctermfg=lightblue cterm=underline
	"    "hi! Org_Half_Link guifg=cyan gui=underline ctermfg=lightblue cterm=underline
	"
	"    " Applies to the Heading line that can be displayed in column view
	"    "highlight OrgColumnHeadings guibg=#444444 guifg=#aaaaaa gui=underline
	"
	"    " Use g:org_todo_custom_highlights to set up highlighting for individual
	"    " TODO items.  Without this all todos that designate an unfinished state
	"    " will be highlighted using NOTDONETODO highlight (see above)
	"    " and all todos that designate a finished state will be highlighted using
	"    " the DONETODO highlight (see above).
	"    let g:org_todo_custom_highlights =
	"               \     { 'NEXT': { 'guifg':'#888888', 'guibg':'#222222',
	"               \              'ctermfg':'gray', 'ctermbg':'darkgray'},
	"               \      'WAITING': { 'guifg':'#aa3388',
	"               \                 'ctermfg':'red' } }
	"
	"endfunction
	"
	"" Below are two examples of Org-mode "hook" functions
	"" These present opportunities for end-user customization
	"" of how VimOrganizer works.  For more info see the
	"" documentation for hooks in Emacs' Org-mode documentation:
	"" http://orgmode.org/worg/org-configs/org-hooks.php#sec-1_40
	""
	"" These two hooks are currently the only ones enabled in 
	"" the VimOrganizer codebase, but they are easy to add so if
	"" there's a particular hook you want go ahead and request it
	"" or look for where these hooks are implemented in 
	"" /ftplugin/org.vim and use them as example for placing your
	"" own hooks in VimOrganizer:
	"function! Org_property_changed_functions(line,key, val)
	"        "call confirm("prop changed: ".a:line."--key:".a:key." val:".a:val)
	"endfunction
	"function! Org_after_todo_state_change_hook(line,state1, state2)
	"        "call confirm("changed: ".a:line."--key:".a:state1." val:".a:state2)
	"        "call OrgConfirmDrawer("LOGBOOK")
	"        "let str = ": - State: " . org#Pad(a:state2,10) . "   from: " . Pad(a:state1,10) .
	"        "            \ '    [' . org#Timestamp() . ']'
	"        "call append(line("."), repeat(' ',len(matchstr(getline(line(".")),'^\s*'))) . str)
	"endfunction
	"
"Rainbow Parentheses
	" 22_Dec_14
	" installed https://github.com/kien/rainbow_parentheses.vim
	let g:rbpt_colorpairs = [
	\ ['brown',       'RoyalBlue3'],
	\ ['Darkblue',    'SeaGreen3'],
	\ ['darkgray',    'DarkOrchid3'],
	\ ['darkgreen',   'firebrick3'],
	\ ['darkcyan',    'RoyalBlue3'],
	\ ['darkred',     'SeaGreen3'],
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['brown',       'firebrick3'],
	\ ['gray',        'RoyalBlue3'],
	\ ['black',       'SeaGreen3'],
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['Darkblue',    'firebrick3'],
	\ ['darkgreen',   'RoyalBlue3'],
	\ ['darkcyan',    'SeaGreen3'],
	\ ['darkred',     'DarkOrchid3'],
	\ ['red',         'firebrick3'],
	\ ]
	let g:rbpt_max = 16
	let g:rbpt_loadcmd_toggle = 0
	"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"Airline {{{
	"25_Dec_14{{{
	"http://sebastiandahlgren.se/2014/08/07/running-vim-airline-with-maximum-awesome/
	let g:airline#extensions#tabline#enabled = 1
	"26_Dec_14
	" let g:airline#extensions#tabline#tab_nr_type = 1
	"28_12_2015
	let g:airline_powerline_fonts = 1 
	"}}}
	" Tue Jun  9 17:57:49 2020
	let g:airline_theme = 'solarized'
	"" 23_Dec_14 https://github.com/blaenk/dots/blob/275b3b40fa0c57f1b48b5ba59b9ecbc00cddf866/vim/vimrc.ln#L80-L202
	" let g:airline_theme = 'angr'
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	let g:airline_symbols.dirty='*'
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	" let g:airline_right_alt_sep = '⮃'
	" Wed Dec 12 19:50:15 2018
	let g:airline#extensions#branch#enabled = 1
	let g:airline#extensions#keymap#enabled = 0
	" let g:airline_symbols.branch = ''
	" let g:airline_symbols.readonly = 'RO'
	" let g:airline_symbols.linenr = '⭡'
	let g:airline_powerline_fonts = 'fancy'
	let g:airline#extensions#hunks#enabled = 1
	let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
	" let g:airline#extensions#whitespace#enabled = 0
	" function! AirLineBlaenk()
	"function! Modified()
	"return &modified ? " +" : ''
	"endfunction
	"call airline#parts#define_raw('filename', '%<%f')
	"call airline#parts#define_function('modified', 'Modified')
	"let g:airline_section_b = airline#section#create_left(['filename'])
	"let g:airline_section_c = airline#section#create([''])
	"let g:airline_section_gutter = airline#section#create(['modified', '%='])
	"let g:airline_section_x = airline#section#create_right([''])
	"let g:airline_section_y = airline#section#create_right(['%c'])
	" let g:airline_section_y = airline#section#create(['branch'])
	"endfunction
	"autocmd Vimenter * call AirLineBlaenk()
	"let g:airline_theme_patch_func = 'AirLineBlaenkTheme'
	"" 0,1: gfg, gbg; 2,3: tfg, tbg; 4: styles
	"function! AirLineBlaenkTheme(palette)
	"if g:airline_theme == 'solarized'
	"let purple = ['#ffffff', '#5f5faf', 255, 13, '']
	"let violet = ['#5f5faf', '#aeaed7', 13, 61, '']
	"let inv_purple = ['#5f5faf', '#ffffff', 13, 255, '']
	"let purple_violet = ['#5f5faf', '#aeaed7', 61, 13, '']
	"" dark = middle
	"" white = focus
	"" light = edges
	"let a:palette.ctrlp = {
	"\ 'CtrlPlight' : purple,
	"\ 'CtrlPwhite' : inv_purple,
	"\ 'CtrlPdark' : violet,
	"\ 'CtrlParrow1': inv_purple,
	"\ 'CtrlParrow2': purple,
	"\ 'CtrlParrow3': purple_violet,
	"\ }
	"let secondary = ['#ffffff', '#657b83', 255, 240, '']
	"let magenta = ['#ffffff', '#d33682', 255, 125, '']
	"let blue = ['#ffffff', '#268bd2', 255, 33, '']
	"let green = ['#ffffff', '#859900', 255, 64, '']
	"let red = ['#ffffff', '#dc322f', 255, 160, '']
	"let orange = ['#ffffff', '#cb4b16', 255, 166, '']
	"let modes = {
	"\ 'normal': blue,
	"\ 'insert': green,
	"\ 'replace': magenta,
	"\ 'visual': orange
	"\}
	"let a:palette.replace = copy(a:palette.insert)
	"let a:palette.replace_modified = a:palette.insert_modified
	"for key in ['insert', 'visual', 'normal']
	"" no red on modified
	"let a:palette[key . '_modified'].airline_c[0] = '#657b83'
	"let a:palette[key . '_modified'].airline_c[2] = 11
	"for section in ['a', 'b', 'y', 'z']
	"let airline_section = 'airline_' . section
	"if has_key(a:palette[key], airline_section)
	"" white foreground for most components; better contrast imo
	"let a:palette[key][airline_section][0] = '#ffffff'
	"let a:palette[key][airline_section][2] = 255
	"endif
	"endfor
	"endfor
	"for key in keys(modes)
	"let a:palette[key].airline_a = modes[key]
	"let a:palette[key].airline_z = modes[key]
	""let a:palette[key . '_modified'].airline_b = ['#002b36', '#93a1a1', 234, 245]
	"let a:palette[key].airline_b = secondary
	"let a:palette[key].airline_y = secondary
	"endfor
	"endif
	"endfunction
	"let g:airline#extensions#default#section_truncate_width = {
	"\ 'x': 60,
	"\ 'y': 60
	"\ }
	"let g:airline_mode_map = {
	"\ '__' : '-',
	"\ 'n' : 'N',
	"\ 'i' : 'I',
	"\ 'R' : 'R',
	"\ 'v' : 'V',
	"\ 'V' : 'V-L',
	"\ 'c' : 'C',
	"\ '' : 'V-B',
	"\ 's' : 'S',
	"\ 'S' : 'S-L',
	"\ '' : 'S-B',
	"\ }
	""}}}
	set laststatus=2 " Always display the statusline in all windows "https://github.com/vim-airline/vim-airline/issues/20  Fri Dec  1 23:48:33 UZT 2017
	" without the above airline would not show up, but only in splits	
"Tmux-line {{{
  let g:tmuxline_preset = 'minimal'
	 " let g:tmuxline_preset = {
      " \'a'    : '#S',
      " \'c'    : ['#(whoami)', '#(uptime  | cut -d " " -f 1,2,3)'],
      " \'win'  : ['#I', '#W'],
      " \'cwin' : ['#I', '#W', '#F'],
      " \'x'    : '#(date)',
      " \'y'    : ['%R', '%a', '%Y'],
      " \'z'    : '#H'}
" " }}}
"Mode aware cursor {{{
	"" https://github.com/blaenk/dots/blob/9843177fa6155e843eb9e84225f458cd0205c969/vim/vimrc.ln#L49-L64
	"" 23_Dec_14
	"set gcr=a:block
	"" mode aware cursors
	"set gcr+=o:hor50-Cursor
	"set gcr+=n:Cursor
	"set gcr+=i-ci-sm:InsertCursor
	"set gcr+=r-cr:ReplaceCursor-hor20
	"set gcr+=c:CommandCursor
	"set gcr+=v-ve:VisualCursor
	"set gcr+=a:blinkon0
	"hi InsertCursor ctermfg=15 guifg=#fdf6e3 ctermbg=37 guibg=#2aa198
	""hki VisualCursor ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#d33682 23_Dec_14 this raises error in terminal
	"hi ReplaceCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65 guibg=#dc322f
	"hi CommandCursor ctermfg=15 guifg=#fdf6e3 ctermbg=166 guibg=#cb4b16
	""}}}
"Netrw 23_Dec_14 {{{
	"https://medium.com/@mozhuuuuu/vimmers-you-dont-need-nerdtree-18f627b561c3
	let g:netrw_liststyle=1
	"}}}
"gtfo 25_Dec_14 {{{
	"https://github.com/justinmk/vim-gtfo
	"advised by https://inuits.eu/blog/veni-vidi-vim-journey-perfect-vim-configuration
	"let g:gtfo#terminals = { 'mac' : 'iterm' } "iTerm
	"let g:gtfo#terminals['mac']
	"}}}
"indentLine 25_Dec_14 {{{
	let g:indentLine_loaded = 1
	let g:indentLine_char = '︙'
	"}}}
"View options
	"11_06_2015 https://github.com/vim-scripts/restore_view.vim
	set viewoptions=cursor,folds,slash,unix
	"let g:skipview_files = ['*\.vim']
"Filytype
	" 11_06_2015 http://vim.wikia.com/wiki/Forcing_Syntax_Coloring_for_files_with_odd_extensions
	" associate * with php filetype
	au BufRead,BufNewFile *vimperator* setfiletype vimperator
"Folding
	"http://vim.wikia.com/wiki/Folding
	"26_06_2015
	augroup vimrc
	au BufReadPre * setlocal foldmethod=indent
	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
	augroup END
"Cyrillic
	:"http://habrahabr.ru/post/98393/ 09_09_2015
	set keymap=russian-jcukenwin
	set iminsert=0
	set imsearch=0
	highlight lCursor guifg=NONE guibg=Cyan
	"xkbswitch
	"	let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
	"	let g:XkbSwitchEnabled = 1
	"	let g:XkbSwitchIMappings = ['ru']
"Spelling
	" http://habrahabr.ru/post/98393/ 09_09_2015
	:setlocal spell spelllang=ru_yo,en_us
	:setlocal nospell 
	"Diminactive - reduce brightness of inactive window
	let g:diminactive_enable_focus = 1
	" let g:diminactive_use_syntax = 1
"Ranger
	" 14_01_2016
	"http://www.everythingcli.org/use-ranger-as-a-file-explorer-in-vim/
	function RangerExplorer()
	exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
	if filereadable('/tmp/vim_ranger_current_file')
		exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
		call system('rm /tmp/vim_ranger_current_file')
	endif
	redraw!
	endfun
	
" 	map <Leader>x :call RangerExplorer()<CR>
" "Matchit
" 	" let b:match_words = '<:>,<tag>:</tag>'
" 	let b:match_words = '\<if\>:\<endif\>,\<tag\>:\</tag\>'
" 	" let b:match_words = &matchpairs
" 	set mps+=<:>
" 	runtime macros/matchit.vim
" "Nugget
" 	"http://www.oschrenk.com/vim-nuggets/
" 	"jump to last cursor position when opening a file
" 	"dont do it when writing a commit log entry
" 	autocmd BufReadPost * call SetCursorPosition()
" 	function! SetCursorPosition()
" 	if &filetype !~ 'svn\|commit\c'
" 		if line("'\"") > 0 && line("'\"") <= line("$")
" 		exe "normal! g`\""
" 		normal! zz
" 		endif
" 	end
" 	endfunction
" "Persistent undo
" 	" " Keep undo history across sessions
" 	" " see :help undo-persistence
" 	" if exists("+undofile")
" 	" " create dir if it doesn't exist
" 	" if isdirectory($HOME . '/.vim/undo') == 0
" 	" :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
" 	" endif
" 	" " if path ends in two slashes, file name will use complete path
" 	" " :help dir
" 	" set undodir=~/.vim/undo//
" 	" set undofile
" 	" set undolevels=500
" 	" set undoreload=500
" 	" endif
" "Unite {{{ 
" 	"	" 01_03_2016
" 	"	"https://github.com/unr/dotfiles/blob/master/vim/vim.symlink/plugin/unite.vim
" 	"	"https://github.com/OliverUv/Configuration-files/blob/master/vimrc#L305
" 	"	"https://www.reddit.com/r/vim/comments/2g791z/anyone_have_any_unitevim_vimrc_snippets_to_share/
" 	"	" Fuzzy match by default
" 	"	call unite#filters#matcher_default#use(['matcher_fuzzy'])
" 	"	call unite#filters#sorter_default#use(['sorter_rank'])
" 	"	
" 	"	" Fuzzy matching for plugins not using matcher_default as filter
" 	"	call unite#custom#source('outline,line,grep,session', 'matchers', ['matcher_fuzzy'])
" 	"	
" 	"	" Ignore some things
" 	"	" KEEP THESE IN SYNC WITH WILDIGNORE!
" 	"	" Need to escape dots in the patterns!
" 	"	call unite#custom#source('file_rec,file_rec/async,file_mru,file,grep',
" 	"	\ 'ignore_pattern', join([
" 	"	\ '\.swp', '\.swo', '\~$',
" 	"	\ '\.git/', '\.svn/', '\.hg/',
" 	"	\ '^tags$', '\.taghl$',
" 	"	\ '\.ropeproject/', '\.pbxproj$', '\.xcodeproj', '\.vcproj',
" 	"	\ 'node_modules/', 'bower_components/', 'log/', 'tmp/', 'obj/',
" 	"	\ '/vendor/gems/', '/vendor/cache/', '\.bundle/', '\.sass-cache/',
" 	"	\ '/tmp/cache/assets/.*/sprockets/', '/tmp/cache/assets/.*/sass/',
" 	"	\ 'thirdparty/', 'Debug/', 'Release/', 'build/', 'dist/',
" 	"	\ 'web/static/components/', 'web/static/external/', 'web/static/images/',
" 	"	\ '\.pyc$', 'pb2\.py$', '\.class$', '\.jar$', '\.min\.js$',
" 	"	\ '\.jpg$', '\.jpeg$', '\.bmp$', '\.png$', '\.gif$',
" 	"	\ '\.o$', '\.out$', '\.obj$', '\.rbc$', '\.rbo$', '\.gem$',
" 	"	\ '\.zip$', '\.tar\.gz$', '\.tar\.bz2$', '\.rar$', '\.tar\.xz$'
" 	"	\ ], '\|'))
" 	"	
" 	"	" call unite#custom#source('file_rec,file_rec/async,file_mru,file,grep', 'ignore_globs',
" 	"	" \ split(&wildignore, ','))
" 	"	
" 	"	let g:unite_source_rec_max_cache_files = 0
" 	"	call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep',
" 	"	\ 'max_candidates', 0)
" 	"	
" 	"	" Keep track of yanks
" 	"	let g:unite_source_history_yank_enable = 1
" 	"	" Prettier prompt
" 	"	call unite#custom#profile('default', 'context', {
" 	"	\   'prompt': '» ',
" 	"	\   'start_insert': 1,
" 	"	\   'update_time': 200,
" 	"	\   'cursor_line_highlight': 'UniteSelectedLine',
" 	"	\   'direction': 'botright',
" 	"	\   'prompt_direction': 'top',
" 	"	\ })
" 	"	" Autosave sessions for unite-sessions
" 	"	let g:unite_source_session_enable_auto_save = 1
" 	"	" Non-ugly colors for selected item, requires you to set 'hi UnitedSelectedLine'
" 	"	let g:unite_cursor_line_highlight = "UniteSelectedLine"
" 	"	" Set to some better time formats
" 	"	let g:unite_source_buffer_time_format = "%Y-%m-%d  %H:%M:%S  "
" 	"	let g:unite_source_file_mru_time_format = "%Y-%m-%d  %H:%M:%S  "
" 	"	
" 	"	" Use ag or ack as grep command if possible
" 	"	if executable('ag')
" 	"		let g:unite_source_grep_command = 'ag'
" 	"		let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore-case --ignore tags'
" 	"		let g:unite_source_grep_recursive_opt = ''
" 	"	elseif executable('ack-grep')
" 	"		let g:unite_source_grep_command = 'ack-grep'
" 	"		let g:unite_source_grep_default_opts =
" 	"		\ '--no-heading --no-color -a -H'
" 	"		let g:unite_source_grep_recursive_opt = ''
" 	"	endif
" 	"	
" 	"	function! g:DoUniteFuzzy()
" 	"		call unite#custom#source('file_rec/async,file/new', 'sorters', 'sorter_rank')
" 	"		call unite#custom#source('file_rec/async,file/new', 'converters', 'converter_relative_word')
" 	"		call unite#custom#source('file_rec/async,file/new', 'matchers', 'matcher_fuzzy')
" 	"		exec "Unite -buffer-name=files file_rec/async file/new"
" 	"	endfunction
" 	"	function! g:DoUniteNonFuzzy()
" 	"		call unite#custom#source('file_rec/async,file/new', 'sorters', 'sorter_nothing')
" 	"		call unite#custom#source('file_rec/async,file/new', 'converters', 'converter_relative_word')
" 	"		call unite#custom#source('file_rec/async,file/new', 'matchers', 'matcher_glob')
" 	"		exec "Unite -buffer-name=files file_rec/async file/new"
" 	"	endfunction
" 	"	function! g:DoUniteFuzzyQuickfix()
" 	"		call unite#custom#source('quickfix', 'sorters', 'sorter_rank')
" 	"		call unite#custom#source('quickfix', 'matchers', 'matcher_fuzzy')
" 	"		exec "Unite -buffer-name=quickfix quickfix"
" 	"	endfunction
" 	"	function! g:DoUniteNonFuzzyQuickfix()
" 	"		call unite#custom#source('quickfix', 'sorters', 'sorter_nothing')
" 	"		call unite#custom#source('quickfix', 'matchers', 'matcher_glob')
" 	"		exec "Unite -buffer-name=quickfix quickfix"
" 	"	endfunction
" 	"	function! UltiSnipsCallUnite()
" 	"		Unite -immediately -no-empty -vertical -buffer-name=ultisnips ultisnips
" 	"		return ''
" 	"	endfunction
" 	"	
" 	"	" Bindings
" 	"	inoremap <silent><leader>l<tab> <C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
" 	"	nnoremap <silent><leader>l<tab> a<C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
" 	"	nnoremap <silent><leader>lr :call g:DoUniteFuzzy()<CR>
" 	"	nnoremap <silent><leader>lR :call g:DoUniteNonFuzzy()<CR>
" 	"	nnoremap <silent><leader>lq :call g:DoUniteFuzzyQuickfix()<CR>
" 	"	nnoremap <silent><leader>lQ :call g:DoUniteNonFuzzyQuickfix()<CR>
" 	"	nnoremap <silent><leader>le :<C-u>Unite -buffer-name=files file_mru bookmark<CR>
" 	"	nnoremap <silent><leader>lE :<C-u>Unite -buffer-name=files file_mru bookmark file_rec/async file/new<CR>
" 	"	nnoremap <silent><leader>lB :<C-u>Unite -buffer-name=buffers buffer<CR>
" 	"	nnoremap <silent><leader>lb :<C-u>Unite -buffer-name=buffers buffer_tab<CR>
" 	"	nnoremap <silent><leader>ly :<C-u>Unite -buffer-name=yanks history/yank<CR>
" 	"	nnoremap <silent><leader>lc :<C-u>Unite -buffer-name=changes change<CR>
" 	"	nnoremap <silent><leader>lj :<C-u>Unite -buffer-name=jumps jump<CR>
" 	"	nnoremap <silent><leader>lf :<C-u>Unite -buffer-name=jumps jump<CR>
" 	"	nnoremap <silent><leader>l; :<C-u>Unite -buffer-name=commands history/command<CR>
" 	"	nnoremap <silent><leader>l/ :<C-u>Unite -buffer-name=commands history/search<CR>
" 	"	nnoremap <silent><leader>lo :<C-u>Unite -buffer-name=outline outline<CR>
" 	"	nnoremap <silent><leader>la :<C-u>Unite -buffer-name=outline -vertical outline<CR>
" 	"	nnoremap <silent><leader>ll :<C-u>Unite -buffer-name=line line<CR>
" 	"	nnoremap <silent><leader>lw :<C-u>Unite -buffer-name=location_list location_list<CR>
" 	"	nnoremap <silent><leader>l* :<C-u>UniteWithCursorWord -buffer-name=line line<CR>
" 	"	nnoremap <silent><leader>lg :<C-u>Unite -buffer-name=grep grep<CR>
" 	"	nnoremap <silent><leader>lG "zyiw:<C-u>Unite -buffer-name=grepword grep<CR><CR><C-R>z<CR>
" 	"	vnoremap <silent><leader>lG "zy:<C-u>Unite -buffer-name=grepword grep<CR><CR><C-R>z<CR>
" 	"	nnoremap <silent><leader>ls :<C-u>Unite session<CR>
" 	"	nnoremap <silent><leader>lt :<C-u>Unite -buffer-name=tags tag<CR>
" 	"	nnoremap <silent><leader>lT :<C-u>Unite -buffer-name=tagfiles tag/file<CR>
" 	"	nnoremap <silent><leader>li :<C-u>Unite -buffer-name=autotags tag/include<CR>
" 	"	nnoremap <silent><leader>ld :<C-u>Unite -buffer-name=change-cwd -default-action=lcd directory_mru directory<CR>
" 	"	nnoremap <silent><leader>l, :<C-u>UniteResume<CR>
" 	"	nnoremap <silent><leader>lv :<C-u>UniteResume<CR>
" 	"	nnoremap <silent><leader>lV :<C-u>UniteResume
" 	"	
" 	"	nnoremap <leader>lS :<C-u>UniteSessionSave
" 	"	
" 	"	function! s:unite_my_settings()
" 	"	"Don't add parens to my filters
" 	"	let b:delimitMate_autoclose = 0
" 	"	
" 	"	"Keymaps inside the unite split
" 	"	nmap <buffer> <nowait> <leader>d <Plug>(unite_exit)
" 	"	nmap <buffer> <nowait> <C-c> <Plug>(unite_exit)
" 	"	imap <buffer> <nowait> <C-c> <Plug>(unite_exit)
" 	"	
" 	"	nnoremap <buffer> <C-n> <Plug>(unite_select_next_line)
" 	"	nnoremap <buffer> <C-p> <Plug>(unite_select_previous_line)
" 	"	
" 	"	nnoremap <buffer> <Up> 3<c-y>
" 	"	nnoremap <buffer> <Down> 3<c-e>
" 	"	inoremap <buffer> <Up> <esc>3<c-y>
" 	"	inoremap <buffer> <Down> <esc>3<c-e>
" 	"	
" 	"	inoremap <silent><buffer><expr> <C-j> unite#do_action('split')
" 	"	nnoremap <silent><buffer><expr> <C-j> unite#do_action('split')
" 	"	inoremap <silent><buffer><expr> <C-k> unite#do_action('vsplit')
" 	"	nnoremap <silent><buffer><expr> <C-k> unite#do_action('vsplit')
" 	"	endfunction
" 	"	
" 	"	if has("autocmd")
" 	"	augroup UniteSettingsGroup
" 	"		" Clear autocmds for this group
" 	"		autocmd!
" 	"		autocmd FileType unite call s:unite_my_settings()
" 	"		augroup end
" 	"	endif
" 	"	}}} Unite"
" "Fasd
" 	" 03_03_2016
" 	let g:unite_fasd#fasd_path = '/usr/local/bin/fasd'
" "CtrlP Z - fasd
" 	" let g:ctrlp_extensions = ['Z', 'F']
" 	nnoremap sz :CtrlPZ<Cr>
" 	nnoremap sf :CtrlPF<Cr>
" 	"fzf.vim
" 	set rtp+=/usr/local/opt/fzf
" "CtrlP {{{ "
" 	" http://stackoverflow.com/questions/21346068/slow-performance-on-ctrlp-it-doesnt-work-to-ignore-some-folders
" 	let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" 	let g:ctrlp_use_caching = 1
" 	if executable('ag')
" 		set grepprg=ag\ --nogroup\ --nocolor
" 		let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" 	else
" 		let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
" 		let g:ctrlp_prompt_mappings = {
" 		\ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
" 		\ }
" 	endif
" 	"ctrlp related
" 	"from http://pyjamacoder.com/2013/04/25/getting-fuzzy-with-ctrlp/ in the
" 	"comments, did not try as of 20/12/13
" 	" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" 	"
" 	set wildignore+=*/tmp/*,*/Library/*,*/android-sdk*/*,*/eclipse/*,*.so,*.swp,*.zip,*.pdf,*.mp3,*.doc*,*.xls*
" 	let g:ctrlp_clear_cache_on_exit=0
" 	let g:ctrlp_extensions = ['dir',  'undo',  'bookmarkdir', 'Z', 'F']
	
" 	" 2 Mar 2014 http://www.blaenkdenum.com/posts/dots/
" 	"if executable('ag')
" 	"  set grepprg=ag\ -nogroup\ --nocolor
" 	"  let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor --ignore-dir .git -g ""'
" 	""  let g:ctrlp_use_caching = 0
" 	"endif
" 	let g:ctrlp_working_path_mode = 'ra'
" 	"}}}
" " cursorline
" 	" https://www.blaenkdenum.com/posts/dots/
" 	augroup cursorline
" 		autocmd!
" 		autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
" 		autocmd WinLeave * setlocal nocursorline
" 	augroup END
" "Completion
" 	"http://vim.wikia.com/wiki/Omni_completion Sat Dec  2 01:10:50 2017
" 	set omnifunc=syntaxcomplete#Complete
" "Bookmark last buffers
" 	"https://stackoverflow.com/questions/16082991/vim-switching-between-files-rapidly-using-vanilla-vim-no-plugins Fri Nov  9 15:23:46 2018
" 	augroup VIMRC
" 		autocmd!
" 		autocmd BufLeave *.css  normal! mC
" 		autocmd BufLeave *.html normal! mH
" 		autocmd BufLeave *.js   normal! mJ
" 		autocmd BufLeave *.php  normal! mP
" 		autocmd BufLeave *.txt  normal! mT
" 	augroup END
" 	"Cursor shape in iTerm2 and tmux Wed Sep 25 15:58:29 2019, "https://gist.github.com/andyfowler/1195581
" 	if exists('$TMUX')
" 	  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" 	  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" 	else
" 	  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" 	  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" 	endif
" 	"Delay in cursor
" 	" upon hitting escape to change modes,
" 	" send successive move-left and move-right
" 	" commands to immediately redraw the cursor
" 	inoremap <special> <Esc> <Esc>hll
	
	highlight Cursor guifg=white guibg=black
	highlight iCursor guifg=white guibg=steelblue
	set guicursor=n-v-c:block-Cursor
	set guicursor+=i:ver25-iCursor
	set guicursor+=n-v-c:blinkon0
	" set guicursor+=i:blinkwait10
"which_key
" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
" nnoremap <silent> <leader> :silent WhichKey<CR>
" vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual ','<CR>

" let g:which_key_map =  {}
" let g:which_key_sep = ': '
" Set a shorter timeout, default is 1000
"set timeoutlen=100

let g:which_key_use_floating_win = 1

"" Single mappings
"let g:which_key_map['/'] = [ '<Plug>NERDCommenterToggle'        , 'comment' ]
"let g:which_key_map['f'] = [ ':Files'                           , 'search files' ]
"let g:which_key_map['h'] = [ '<C-W>s'                           , 'split below']
"let g:which_key_map['S'] = [ ':Startify'                        , 'start screen' ]
"let g:which_key_map['T'] = [ ':Rg'                              , 'search text' ]
"let g:which_key_map['E'] = [ ':SSave'                           , 'save session']
"let g:which_key_map['L'] = [ ':SLoad'                           , 'load session']
"let g:which_key_map['l'] = [ ':Limelight!!'                     , 'limelight']
"let g:which_key_map['z'] = [ ':Goyo'                            , 'zen mode']
"let g:which_key_map['r'] = [ ':RnvimrToggle'                    , 'ranger' ]
"let g:which_key_map['g'] = [ ':FloatermNew lazygit'             , 'git']
"let g:which_key_map['d'] = [ ':FloatermNew lazydocker'          , 'docker']
"let g:which_key_map['k'] = [ ':FloatermNew k9s'                 , 'k9s']
"let g:which_key_map['t'] = [ ':FloatermNew'                     , 'terminal']
"let g:which_key_map['v'] = [ '<C-W>v'                           , 'split right']

"" s is for search
"let g:which_key_map.s = {
"      \ 'name' : '+search' ,
"      \ '/' : [':History/'                 , 'history'],
"      \ ';' : [':Commands'                 , 'commands'],
"      \ 'a' : [':Ag'                       , 'text Ag'],
"      \ 'b' : [':BLines'                   , 'current buffer'],
"      \ 'B' : [':Buffers'                  , 'open buffers'],
"      \ 'c' : [':Commits'                  , 'commits'],
"      \ 'C' : [':BCommits'                 , 'buffer commits'],
"      \ 'f' : [':Files'                    , 'files'],
"      \ 'g' : [':GFiles'                   , 'git files'],
"      \ 'G' : [':GFiles?'                  , 'modified git files'],
"      \ 'h' : [':History'                  , 'file history'],
"      \ 'H' : [':History:'                 , 'command history'],
"      \ 'l' : [':Lines'                    , 'lines'] ,
"      \ 'm' : [':Marks'                    , 'marks'] ,
"      \ 'M' : [':Maps'                     , 'normal maps'] ,
"      \ 'p' : [':Helptags'                 , 'help tags'] ,
"      \ 'P' : [':Tags'                     , 'project tags'],
"      \ 's' : [':CocList snippets'         , 'snippets'],
"      \ 'S' : [':Colors'                   , 'color schemes'],
"      \ 't' : [':Rg'                       , 'Rg text'],
"      \ 'T' : [':BTags'                    , 'buffer tags'],
"      \ 'w' : [':Windows'                  , 'search windows'],
"      \ 'y' : [':Filetypes'                , 'file types'],
"      \ 'z' : [':FZF'                      , 'FZF'],
"      \ }

"" P is for vim-plug
"let g:which_key_map.p = {
"      \ 'name' : '+plug' ,
"      \ 'i' : [':PlugInstall'              , 'install'],
"      \ 'u' : [':PlugUpdate'               , 'update'],
"      \ 'c' : [':PlugClean'                , 'clean'],
"      \ 's' : [':source ~/.config/nvim/init.vim', 'source vimrc'],
"      \ }
"
"" Register which key map
"call which_key#register(',', "g:which_key_map")
""
let g:ctrlp_z_nerdtree = 1

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" call ctrlp_bdelete#init()
"
" autocmd! FileType fzf set laststatus=0 noshowmode noruler
  " \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" -----------
" let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
" let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
" let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" function! FloatingFZF()
"   let buf = nvim_create_buf(v:false, v:true)
"   call setbufvar(buf, '&signcolumn', 'no')

"   let height = float2nr(10)
"   let width = float2nr(80)
"   let horizontal = float2nr((&columns - width) / 2)
"   let vertical = 1

"   let opts = {
"         \ 'relative': 'editor',
"         \ 'row': vertical,
"         \ 'col': horizontal,
"         \ 'width': width,
"         \ 'height': height,
"         \ 'style': 'minimal'
"         \ }

"   call nvim_open_win(buf, v:true, opts)
" endfunction
" -------------
" let g:height = float2nr(&lines * 0.9)
"   let g:width = float2nr(&columns * 0.95)
"   let g:preview_width = float2nr(&columns * 0.7)
"   let g:fzf_buffers_jump = 1
"   let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
"   let $FZF_DEFAULT_OPTS=" --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4 --preview 'if file -i {}|grep -q binary; then file -b {}; else bat --style=changes --color always --line-range :40 {}; fi' --preview-window right:" . g:preview_width
"   let g:fzf_layout = { 'window': 'call FloatingFZF(' . g:width . ',' . g:height . ')' }
"   ----------------
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_preview_window = []
" nnoremap <C-p> :<C-u>FZF<CR> 
nnoremap <leader>s :<C-u>FZF<CR>
" nnoremap <C-p> :Files<Cr>
nnoremap <leader>M :<C-u>Marks<CR>
nnoremap <leader>m :<C-u>FZFMru<CR>
let g:fzf_vim_statusline = 0
" let g:airline#extensions#branch#enabled = 0
"------
" Sat Sep 18 18:27:01 2021
"Lightline
"{{{
"
set rtp+=~/dotfiles/vim/.vim/bundle/onehalf/vim

let g:lightline = {
	\ 'colorscheme': 'solarized',
	\	'active': {
	\     'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'readonly', 'filename', ] ],
	\     'right': [
	\        		[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
	\         	['percent', 'lineinfo'],
	\         	['fileformat'],
	\			['indent'] ],
	\ },
	\ 'component_function': {
	\	'gitbranch': 'FugitiveHead',
	\ 'indent': 'LightlineIndent',
	\ 'fileformat': 'LightLineFileformat',
	\	'filename' : 'LightlineFname3',
	\ },
	\ 'mode_map': {
	\ 'n' : 'N',
	\ 'i' : 'I',
	\ 'R' : 'R',
	\ 'v' : 'V',
	\ 'V' : 'VL',
	\ "\<C-v>": 'VB',
	\ 'c' : 'C',
	\ 's' : 'S',
	\ 'S' : 'SL',
	\ "\<C-s>": 'SB',
	\ 't': 'T',
	\ },
	\}

function! LightlineFilename()
	" return winwidth(0) > 120 ? '' : ('' != expand('%:p') ? expand('%:p') : '[No Name]')
	return expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction
" Tue Sep 21 15:17:09 2021"
"https://github.com/itchyny/lightline.vim/issues/532
function! LightlineTruncatedFileName()
let l:filePath = expand('%')
    if winwidth(0) > 100
        return l:filePath
    else
        return pathshorten(l:filePath, 2)
    endif
endfunction

function! LightlineFilename2()
	let name = ""
	let subs = split(expand('%'), "/") 
	let i = 1
	for s in subs
		let parent = name
		if  i == len(subs)
			let name = parent . '/' . s
		elseif i == 1
			let name = s
		else
			let name = parent . '/' . strpart(s, 0, 2)
		endif
		let i += 1
	endfor
  return name
endfunction

function! LightlineFname3() 
  let icon = (strlen(&filetype) ? ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') 
  let filename = LightlineTruncatedFileName()

  let modified = ModifiedStatus()
  if filename == ''
      return ''
  endif
  return join([filename, icon, modified],'')
endfunction

" Tue Sep 21 15:22:00 2021
" https://github.com/itchyny/lightline.vim/issues/593
" https://ncona.com/2016/04/disable-expandtab-in-vim/
function! LightlineIndent() abort
  return (&expandtab ? "Sp" : "Tb") . ':' . (&expandtab ? &shiftwidth : &tabstop)
endfunctio
" Wed Sep 22 16:06:21 2021
"https://github.com/itchyny/lightline.vim/issues/405
function! LightLineFileformat()
  return &fileencoding . ' ' . FileFormatIcon()
endfunction

function! FileFormatIcon()
  return strlen(&filetype) ? WebDevIconsGetFileFormatSymbol() : 'no ft'
endfunction


function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! ModifiedStatus()
  let modified = LightLineModified()
  return ('' != modified ? ' ' . modified : '')
endfunction
      "}}}
     
command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})
