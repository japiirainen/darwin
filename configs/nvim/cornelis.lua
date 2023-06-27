vim.api.nvim_exec([[


function! AgdaFiletype()
    nnoremap <buffer> <localleader>l :CornelisLoad<CR>
    nnoremap <buffer> <localleader>r :CornelisRefine<CR>
    nnoremap <buffer> <localleader>d :CornelisMakeCase<CR>
    nnoremap <buffer> <localleader>, :CornelisTypeContext<CR>
    nnoremap <buffer> <localleader>. :CornelisTypeContextInfer<CR>
    nnoremap <buffer> <localleader>n :CornelisSolve<CR>
    nnoremap <buffer> <localleader>a :CornelisAuto<CR>
    nnoremap <buffer> gd        :CornelisGoToDefinition<CR>
    nnoremap <buffer> [/        :CornelisPrevGoal<CR>
    nnoremap <buffer> ]/        :CornelisNextGoal<CR>
    nnoremap <buffer> <C-A>     :CornelisInc<CR>
    nnoremap <buffer> <C-X>     :CornelisDec<CR>
endfunction

function! CornelisLoadWrapper()
    if exists(":CornelisLoad") ==# 2
      CornelisLoad
    endif
  endfunction

au BufReadPre *.agda call CornelisLoadWrapper()
au BufReadPre *.lagda* call CornelisLoadWrapper()
au BufRead,BufNewFile *.agda call AgdaFiletype()
au BufRead,BufNewFile *.lagda* call AgdaFiletype()

let g:cornelis_split_location = 'bottom'
let g:cornelis_agda_prefix = "\\"

]], false)

