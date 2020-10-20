" =====
" basic setting
" =====
syntax on
set number
set relativenumber
set cursorline
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set wrap
set showcmd
set wildmenu
set hlsearch
set ignorecase
set smartcase
set scrolloff=4
set incsearch
" set nobackup
set clipboard=unnamed
set noshowmode
set laststatus=2
set splitbelow splitright
set termguicolors
set hidden
set shortmess+=c

" ====
" mapping
" ====
let mapleader=" "

noremap ; :

" source init.vim in nvim
noremap <LEADER>rc :source ~/.config/nvim/init.vim<CR>

" search
noremap <LEADER><CR> :nohlsearch<CR>


" ===
" === Markdown Snippets
" ===
" Snippets
source $XDG_CONFIG_HOME/nvim/md-snippets.vim


" Compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
        exec "CocCommand python.execInTerminal"
		" :sp
		" :term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device
		CocCommand flutter.dev.openDevLog
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc

let g:python3_host_prog = '/home/poo/miniconda3/envs/dtsc/bin/python'

" ========================================================================
" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" appearance
Plug 'itchyny/lightline.vim'
Plug 'sainnhe/forest-night'

" css color
Plug 'ap/vim-css-color'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'

" latex
Plug 'lervag/vimtex'


" Editor Enhancement
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular' " ga, or :Tabularize <regex> to align
Plug 'preservim/nerdcommenter'

" Other visual enhancement
Plug 'ryanoasis/vim-devicons'
Plug 'godlygeek/tabular'


call plug#end()


" ==============================================================
" Piug conf

" ===== colorscheme config =====
let g:forest_night_enable_italic = 1
let g:forest_night_disable_italic_comment = 1
let g:forest_night_transparent_background = 1
colorscheme forest-night


" ====
" nerdcommenter
" ====
let g:NERDSpaceDelims = 1

" ===
" === tabular
" ===
vmap ga :Tabularize /

" ===
" === vim-table-mode
" ===
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'

" ===
" === Bullets.vim
" ===
" let g:bullets_set_mappings = 0
let g:bullets_enabled_file_types = [
			\ 'markdown',
			\ 'text',
			\ 'gitcommit',
			\ 'scratch'
			\]

" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
			\ 'mkit': {},
			\ 'katex': {},
			\ 'uml': {},
			\ 'maid': {},
			\ 'disable_sync_scroll': 0,
			\ 'sync_scroll_type': 'middle',
			\ 'hide_yaml_meta': 1
			\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" ====
" ==== lightline config ====
" ====
let g:lightline = {
    \ 'colorscheme': 'forest_night',
    \ 'active': {
    \ 'left': [ ['mode'], ['filename'] ],
    \ 'right': [ ['filetype'] ]},
    \ 'inactive': {
    \ 'left': [ ['filename'] ],
    \ 'right': [] }
    \ }
let g:lightline.tab = {
 \ 'active' : [ 'filename', 'modified' ],
 \ 'inactive' : [ 'filename', 'modified' ] }

" ====
" ==Vimtex
" ====
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

" ====
" coc.nvim
" ====
let g:coc_global_extensions = ['coc-json', 'coc-vimlsp', 'coc-css', 'coc-html', 'coc-python', 'coc-tsserver', 'coc-emmet', 'coc-snippets', 'coc-snippets']

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <LEADER>h :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

