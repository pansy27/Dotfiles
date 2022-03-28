local colors = {
  black        = '#6F5987',
  white        = '#ebdbb2',
  red          = '#f8928a',
  green        = '#dfc4e0',
  blue         = '#a0abcf',
  yellow       = '#b5adca',
  gray         = '#d1beef',
  darkgray     = '#d1beefff',
  lightgray    = '#504945ff',
  inactivegray = '#7c6f64ff',
}
return {
  normal = {
    a = {bg = colors.gray, fg = colors.black, gui = 'bold'},
    b = {bg = colors.lightgray, fg = colors.black},
    c = {bg = colors.darkgray, fg = colors.black}
  },
  insert = {
    a = {bg = colors.blue, fg = colors.black, gui = 'bold'},
    b = {bg = colors.lightgray, fg = colors.black},
    c = {bg = colors.lightgray, fg = colors.black}
  },
  visual = {
    a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
    b = {bg = colors.lightgray, fg = colors.black},
    c = {bg = colors.inactivegray, fg = colors.black}
  },
  replace = {
    a = {bg = colors.red, fg = colors.black, gui = 'bold'},
    b = {bg = colors.lightgray, fg = colors.black},
    c = {bg = colors.lightgray, fg = colors.black}
  },
  command = {
    a = {bg = colors.green, fg = colors.black, gui = 'bold'},
    b = {bg = colors.lightgray, fg = colors.black},
    c = {bg = colors.inactivegray, fg = colors.black}
  },
 }
