" Set leader key
let maplocalleader = ","

" For a useful :find
set path=.,**

" Remap keys
" Use Esc to exit terminal state (used by vim-jack-in)
:tnoremap <Esc> <C-\><C-n>

" Use fd as escape, Spacemacs style
:inoremap fd <esc>

" Current line number and Relative line numbers
set number
set relativenumber

" Full color theme support for neovim
set termguicolors

" Configure vim completion
set wildmode=list:longest,full

" In netrw set tree view as the default view
let g:netrw_liststyle=3
" No history for netrw
let g:netrw_dirhistmax = 0

"""""""""""""""""""""""""""""""""""""""""
" vim-plug - manage plugins
"""""""""""""""""""""""""""""""""""""""""
" Saves plugins to ~/.local/share/nvim/plugged
call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'

"" Version control plugins
" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'

" Searching in projects - ripgrep
Plug 'liuchengxu/vim-clap'

" Conjure
Plug 'Olical/conjure', {'tag': 'v4.3.1'}


"""""""""
" Conjure support - jack-in with nrepl dependencies

" Start a REPL from within Vim
Plug 'tpope/vim-dispatch'
Plug 'clojure-vim/vim-jack-in'
Plug 'radenling/vim-dispatch-neovim'

" Structural editing for lisp languages
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Auto-close parens
Plug 'jiangmiao/auto-pairs', { 'tag': 'v2.0.0' }

" Completion support
Plug 'Shougo/deoplete.nvim'
Plug 'ncm2/float-preview.nvim'

" Linting with clj-kondo
Plug 'w0rp/ale'

"""""""""
" Themes

" Gruvbox theme
" https://github.com/morhetz/gruvbox/
Plug 'morhetz/gruvbox'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""
" The end of plugins for vim-plug
"""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""

" Search in project configuration
let g:clap_provider_grep_delay = 50
let g:clap_provider_grep_opts = '-H --no-heading --vimgrep --smart-case --hidden -g "!.git/"'

nnoremap <leader>*  :Clap grep ++query=<cword><cr>
nnoremap <leader>fg :Clap grep<cr>
nnoremap <leader>ff :Clap files --hidden<cr>
nnoremap <leader>fb :Clap buffers<cr>
nnoremap <leader>fw :Clap windows<cr>
nnoremap <leader>fr :Clap history<cr>
nnoremap <leader>fh :Clap command_history<cr>
nnoremap <leader>fj :Clap jumps<cr>
nnoremap <leader>fl :Clap blines<cr>
nnoremap <leader>fL :Clap lines<cr>
nnoremap <leader>ft :Clap filetypes<cr>
nnoremap <leader>fm :Clap marks<cr>


" Completion configuration
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})
set completeopt-=preview

let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#max_height = 40

" Lint configuration - clj-kondo
" clj-kondo should be installed on operating system path
let g:ale_linters = {
      \ 'clojure': ['clj-kondo']
      \}


" Set Gruvbox theme
set background=light
autocmd vimenter * colorscheme gruvbox

