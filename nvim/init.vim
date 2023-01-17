" Directorio de plugins
call plug#begin('~/.local/share/nvim/plugged')

" Aquí irán los plugins a instalar

call plug#end()

set number relativenumber
set autoindent
set noshowmode
set tabstop=4
set softtabstop=4
set shiftwidth=4
set termguicolors

source $HOME/.config/nvim/vim-plug/plugins.vim

" colorscheme japanesque
" let g:gruvbox_contrast_dark = 'hard' 
" colorscheme gruvbox

augroup user_colors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END

colorscheme xresources

lua require'colorizer'.setup()

" Tema de la barra de status
let g:lightline = {
	\'colorscheme': 'ayu_mirage',
	\}

" Detectar config de i3 para plugin
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

nnoremap <leader>u YpVr

" Restore cursor shape to beam on exit
augroup restore_cursor_shape
  autocmd!
  au VimLeave * set guicursor=a:ver10-blinkoff0
augroup END

highlight Normal ctermbg=none
highlight NonText ctermbg=none



