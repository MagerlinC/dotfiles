return {
  'SCJangra/table-nvim',
  ft = 'markdown',
  opts = {
    mappings = {                          -- next and prev work in Normal and Insert mode. All other mappings work in Normal mode.
      next = '<TAB>',                     -- Go to next cell.
      prev = '<S-TAB>',                   -- Go to previous cell.
      insert_row_up = '<leader>ik',       -- Insert a row above the current row.
      insert_row_down = '<leader>ij',     -- Insert a row below the current row.
      insert_column_left = '<leader>ih',  -- Insert a column to the left of current column.
      insert_column_right = '<leader>il', -- Insert a column to the right of current column.
      insert_table = '<leader>it',        -- Insert a new table.
      insert_table_alt = '<A-S-t>',       -- Insert a new table that is not surrounded by pipes.
      delete_column = '<A-d>',            -- Delete the column under cursor.
    }
  },
}
