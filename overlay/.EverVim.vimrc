let g:evervim_no_patched_fonts = 1
let g:evervim_font_size = "11"
let g:evervim_font="FuraCode Nerd Font Mono"
let g:evervim_bundle_groups=['general', 'appearance', 'writing', 'youcompleteme', 'programming', 'python', 'javascript', 'typescript', 'html', 'css', 'misc', 'go', 'rust', 'cpp', 'lua', 'cue']

set foldlevel=25
"" enable line numners by default
set number

" enable clipboard integration
set clipboard=unnamed

set shiftwidth=2
set tabstop=2
set softtabstop=2

noremap <F4> :set list!<CR>
noremap <F5> :set listchars=eol:¬,tab:>·,trail:$,extends:>,precedes:<,space:␣<CR>

" make yaml indentation sane
autocmd FileType python,py setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescript setlocal indentexpr=
autocmd FileType typescript setlocal formatexpr=
autocmd FileType xml setlocal indentexpr=
autocmd FileType typescript let b:tsx_ts_indentexpr = &indentexpr
autocmd FileType typescript let b:did_indent = 0
autocmd FileType typescript let s:did_indent = 0
let g:syntastic_typescript_checkers = []

let g:evervim_use_syntastic = 1

" golang (vim-go) settings
let g:go_fmt_autosave = 1



let g:loaded_syntastic_python_python_checker = 1
let g:syntastic_go_checkers = []
let g:syntastic_typescript_checkers = []

let g:syntastic_quiet_messages = { "type": "style" }
let g:airline#extensions#syntastic#enabled = 0
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 0
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_operators = 0
" let g:go_highlight_build_constraints = 0
let g:go_fmt_command = "goimports"
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" custom javascript settings
" let g:syntastic_javascripts_checkers = ['eslint']

" custom html settings
let g:loaded_syntastic_bemhtml_bemhtmllint_checker = 0
let g:loaded_syntastic_html_htmlhint_checker = 0
let g:loaded_syntastic_html_tidy_checker = 0

let g:pymode = 0
let g:pymode_syntax = 0
let g:pymode_indent = 0
let g:pymode_motion = 0
let g:pymode_run = 0
let g:pymode_lint = 0
let g:pymode_syntax_print_as_function = 1

