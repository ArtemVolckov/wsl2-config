syntax on
set number
set expandtab
set tabstop=4
set shiftwidth=4
set hlsearch
set incsearch
set clipboard=unnamedplus

" Автоматические двойные фигруные скобки
autocmd FileType * inoremap { {<CR>}<ESC>O

" Сдвиг вправо в визуальном режиме без выхода из него
xnoremap < <gv
xnoremap > >gv

" Сдвиг выделенного текста на один пробел вправо в визуальном режиме
xnoremap <Space> :<C-u>silent! '<,'>normal! I <CR>gv

" Сдвиг выделенного текста на один пробел влево в визуальном режиме
xnoremap <BS> :<C-u>call RemoveIndent()<CR>gv

" Функция для удаления отступов
function! RemoveIndent()
    let l:save_reg = @"
    let l:lines = getline("'<", "'>")
    let l:new_lines = []
    for l:line in l:lines
        if len(l:line) > 0 && l:line[0] == ' '
            " Удаляем один пробел из начала строки
            call add(l:new_lines, l:line[1:])
        else
            call add(l:new_lines, l:line)
        endif
    endfor
    call setline("'<", l:new_lines)
    let @" = l:save_reg
endfunction

" Настройка цвета визуального выделения с менее агрессивным фоном
highlight Visual guibg=#bfbfbf guifg=NONE ctermbg=darkgrey ctermfg=NONE


call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'

call plug#end()

" mappings
map <C-n> :NERDTreeToggle<CR>
"let g:NERDTreeShowHidden=1
"let g:NERDTreeIgnore = ['\(^\|\s\)\.\(?!vimrc\)']

" Настройка для открытия файлов в текущем окне
autocmd FileType nerdtree map <buffer> <CR> :call NERDTreeMapActivateNode("openInCurrentWindow")<CR>

" Автоматически закрывать NERDTree, если это единственное оставшееся окно
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && getbufvar(winbufnr(1), "&buftype") == 'nofile' | quit | endif

colorscheme gruvbox
set background=dark
