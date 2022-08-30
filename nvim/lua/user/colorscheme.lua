-- colorscheme

vim.g.tokyonight_style =  "night"
-- "night" "storm" and "day"

vim.g.material_style = "darker"
-- "deep ocean" ,"darker", "oceanic" , "palenight" and "lighter"

-- vim.g.edge_style = "dark"
-- "dark", "aura" , "neon", "light" and  "aura dim"

vim.cmd [[
try
  colorscheme onedark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

