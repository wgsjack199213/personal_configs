"设置为不兼容模式
set nocp
set backspace=indent,eol,start

"行号
set number
"在编辑过程中，在右下角显示光标位置的状态行
set ruler

"缩进设置
set shiftwidth=4
set tabstop=4
"set softtabstop=4
set expandtab
"set autoindent

"colorscheme torte
"colorscheme solarized8_high
colorscheme escuro

syntax on

"用浅色高亮当前行
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul

"高亮显示对应的括号
set showmatch
"对应括号高亮的时间（单位是十分之一秒）
set matchtime=5

"智能对齐
"set smartindent
"自动对齐
"set autoindent

"在处理未保存或只读文件的时候，弹出确认
set confirm

"历史纪录数
set history=50

"搜索逐字符高亮
set hlsearch
set incsearch

"光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3

"http://www.xuebuyuan.com/2146500.html
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1


" Indent Python in the Google way.

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

