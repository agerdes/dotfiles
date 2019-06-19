set nocompatible  " be iMproved
set modelines=0   " prevent modelines exploits
set nomodeline


" Old settings, now covered by tpope/vim-sensible
" https://gist.github.com/agerdes/fd9d689275078232033282611296c203
set nowrap             " Make long lines inconvenient
set nobackup           " Don't use ancient backup files
set noswapfile         " .. or swap files"
set ttyfast            " Redraw faster
set hidden             " Keep hidden buffers loaded
set clipboard=unnamed  " Share clipboard with OS X
                       " .. https://stackoverflow.com/questions/677986
set wildmenu           " Visual autocomplete for command menu
set path+=**           " Search in subfolders with :find
" Ignore directories when searching
let g:netrw_list_hide= '.*\.DS_Store$'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/dist/*,*.DS_Store
set wildmode=full
set grepprg=rg\ --vimgrep " Use ripgrep for grep


" Search
set ignorecase  " Search matches upper and lowercase
set smartcase   " Override ignorecase if search contains uppercase characters
set showmatch   " highlight matching [{()}]
set hlsearch    " highlight search matches


" Whitespace
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set cindent
" https://github.com/sabarasaba/dotfiles/blob/ed1339ccf376b68e12d477a22477fa399cba67ea/.vimrc#L117
set list                   " Show invisible characters
set listchars=""           " Reset the listchars
set listchars=tab:\ \      " A tab displays as "  ", trailing whitespace as "."
set listchars+=trail:.     " Show trailing spaces as dots
set listchars+=extends:>   " Last character on line that runs off screen
set listchars+=precedes:<  " First character when scrolled to the right


" Display
set number
set showcmd
set fillchars+=vert:\  " Vertical split is a blank character
set noerrorbells       " don't beep
set noshowmode         " save mode for the status bar
set splitbelow         " open vert splits below
set splitright         " .. and horizontal splits to the right
set signcolumn="yes"   " Always show sign column
set termguicolors
colorscheme gruvbox


" cursorline on active split
augroup CursorLine
  " No Cursorline except on current buffer
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END


" KEEP SELECTED TEXT SELECTED WHEN FIXING INDENTATION
vnoremap < <gv
vnoremap > >gv


" Keybindings
let mapleader="\<Space>"
inoremap <C-l> <Esc>
nnoremap <leader>w <C-W>w           " Rotate between splits
nnoremap <leader>t :Files<CR>       " Open file with fzf
nnoremap <leader>b :Buffers<CR>     " Search buffers with fzf
nnoremap <leader>f :Find<CR>        " Search in project with fzf
nnoremap <BS> <C-^>                 " Backspace for alternate file


" Pairs
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" Statusline
function! GitStatus()
  let output = ''
  if !empty(fugitive#head())
    let output = ' ' . fugitive#head() . ' '
  endif
  return output
endfunction

set laststatus=2                " Always show
set statusline=\ %f             " filename
set statusline+=\:%l\/%L,%c\    " :line/Lines,col
set statusline+=%m              " Modified
set statusline+=%=              " To the right
set statusline+=%y\             " Filetype
set statusline+=%{GitStatus()}


" Spellcheck and word wrap for gitcommits
au Filetype gitcommit setlocal nolist linebreak wrap tw=72 colorcolumn=72


" Prose Mode for text and markdown files
function! Prose()
  setlocal fo+=t
  setlocal fo-=l
  setlocal tw=0
  setlocal wrap linebreak nolist spell
  setlocal signcolumn="no" 
  setlocal colorcolumn=0
endfunction
au Filetype text call Prose()
au Filetype markdown call Prose()


