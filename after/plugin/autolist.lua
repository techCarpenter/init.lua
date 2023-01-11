local autolist = require('autolist')
autolist.setup {}

autolist.create_mapping_hook('i', '<CR>', autolist.new)
autolist.create_mapping_hook('i', '<TAB>', autolist.indent)
autolist.create_mapping_hook('i', '<S-TAB>', autolist.indent)
autolist.create_mapping_hook('n', 'dd', autolist.force_recalculate)
autolist.create_mapping_hook('n', 'o', autolist.new)
autolist.create_mapping_hook('n', 'O', autolist.new_before)
autolist.create_mapping_hook('n', '>>', autolist.indent)
autolist.create_mapping_hook('n', '<<', autolist.indent)
autolist.create_mapping_hook('n', '<leader>x', autolist.invert_entry)
