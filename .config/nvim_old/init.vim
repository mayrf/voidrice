" ---------- Plugins ----------

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

Plug 'sheerun/vim-polyglot' " synthax highlighting and indentation support
Plug 'tpope/vim-commentary' " comment lines in various languages
Plug 'psliwka/vim-smoothie' " smoother vim scrolling
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'Yggdroot/indentLine' " mark code indented with spaces for each indentation level
Plug 'ghifarit53/tokyonight-vim' " colortheme originally for VS Code
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline' " status bar
Plug 'neoclide/coc.nvim', {'branch': 'release'} " color hexcode and colors
Plug 'ap/vim-css-color'
Plug 'preservim/tagbar'
Plug 'vimwiki/vimwiki'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
" Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
" Plug 'junegunn/goyo.vim'
Plug 'psf/black', { 'branch': 'main' }
Plug 'fisadev/vim-isort'
" Plug 'jreybert/vimagit'

" Jupyter Setup
" https://www.maxwellrules.com/misc/nvim_jupyter.html
Plug 'untitled-ai/jupyter_ascending.vim'
Plug 'hkupty/iron.nvim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'GCBallesteros/vim-textobj-hydrogen'
Plug 'GCBallesteros/jupytext.vim'

call plug#end()

" Jupytext
let g:jupytext_fmt = 'py'
let g:jupytext_style = 'hydrogen'
nmap <space><space>x <Plug>JupyterExecute
nmap <space><space>X <Plug>JupyterExecuteAll

" Send cell to IronRepl and move to next cell.
" Depends on the text object defined in vim-textobj-hydrogen
" You first need to be connected to IronRepl
nmap ]x ctrih/^# %%<CR><CR>

luafile $HOME/.config/nvim/plugins.lua


" ---------- Colorscheme ----------

set termguicolors
colorscheme OceanicNext

" let g:tokyonight_style = 'night' " available: night, storm
" let g:tokyonight_enable_italic = 1

" colorscheme tokyonight
" let g:airline_theme = "tokyonight"

" ---------- Basic Settings ----------
let mapleader =","
set number relativenumber
set expandtab
set mouse=a
set clipboard+=unnamedplus
set scrolloff=4 " keep first and last n lines visable while scrollin while scrolling
set list lcs=tab:\|\ " mark tab indentations with vertical lines
set linebreak "  wrap long lines at a character in 'breakat'
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
  set splitbelow splitright

set title
set ignorecase
set smartcase
set noshowmode
set updatetime=100 " set updatetime of gitgutter update
" no search highlighting
  " set nohlsearch
"

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" ---------- Spell-checks ----------
" add spellfile path to runtimepath (bug fix)
set rtp+=$HOME/.local/share/nvim/site/spell
" English spell-check set to <leader>oe, 'o' for 'orthography':
	map <leader>oe :setlocal spell! spelllang=en_gb<CR>
" German spell-check set to <leader>od, 'o' for 'orthography':
	map <leader>od :setlocal spell! spelllang=de<CR>
" Spanish spell-check set to <leader>os, 'o' for 'orthography':
	map <leader>os :setlocal spell! spelllang=es_es<CR>
" Hungarian spell-check set to <leader>os, 'o' for 'orthography':
	map <leader>oh :setlocal spell! spelllang=hu<CR>


" Installs vim-plug if it does not yet exist
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif


" " source vimrc without leaving nvim
" if (!exists('*SourceConfig'))
"   function SourceConfig() abort
"     " Your path will probably be different
"     for f in split(glob('~/.config/nvim/autoload/*'), '\n')
"       exe 'source' f
"     endfor

"     source $MYVIMRC
"   endfunction
" endif
"
" nnoremap <silent> <Leader><Leader> :call SourceConfig()<cr>

" This triggers all formatting before coc linter is triggered
aug python
    au!
    autocmd BufWritePre *.py Isort
    autocmd BufWritePre *.py Black
aug END

" Future plugins:
"  vim emmet (html boilerplate code)

" ---------- Nerdtree ----------
nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


" ---------- Terminal ----------
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

nmap <F8> :TagbarToggle<CR> " tagbar




let g:vimwiki_list = [{'path': '~/sync/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]


" ---------- vim-closetag ----------

" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" ---------- Visibility ----------

" let g:vim_json_syntax_conceal = 0
" let g:vim_markdown_conceal = 0
" let g:vim_markdown_conceal_code_blocks = 0

" ---------- Vim Telescope ----------

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" ---------- COC Settings ----------
source $HOME/.config/nvim/coc.vim
