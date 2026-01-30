return {
  'ThePrimeagen/99',
  config = function()
    local _99 = require '99'
    local cwd = vim.uv.cwd()
    local basename = vim.fs.basename(cwd)
    _99.setup {
      completion = {
        --- Defaults to .cursor/rules
        -- I am going to disable these until i understand the
        -- problem better.  Inside of cursor rules there is also
        -- application rules, which means i need to apply these
        -- differently
        -- cursor_rules = "<custom path to cursor rules>"

        --- A list of folders where you have your own SKILL.md
        --- Expected format:
        --- /path/to/dir/<skill_name>/SKILL.md
        ---
        --- Example:
        --- Input Path:
        --- "scratch/custom_rules/"
        ---
        --- Output Rules:
        --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
        --- ... the other rules in that dir ...
        ---
        custom_rules = {
          'scratch/custom_rules/',
        },
        -- source = 'cmp',
      },

      md_files = {
        'AGENT.md',
        'README.md',
      },
    }

    -- Create your own short cuts for the different types of actions
    -- vim.keymap.set('n', '<leader>9f', function()
    --   _99.fill_in_function()
    -- end)
    -- take extra note that i have visual selection only in v mode
    -- technically whatever your last visual selection is, will be used
    -- so i have this set to visual mode so i dont screw up and use an
    -- old visual selection
    --
    -- likely ill add a mode check and assert on required visual mode
    -- so just prepare for it now
    vim.keymap.set('v', '<leader>fv', function()
      _99.visual()
    end)

    --- if you have a request you dont want to make any changes, just cancel it
    vim.keymap.set('v', '<leader>fs', function()
      _99.stop_all_requests()
    end)

    --- Example: Using rules + actions for custom behaviors
    --- Create a rule file like ~/.rules/debug.md that defines custom behavior.
    --- For instance, a "debug" rule could automatically add printf statements
    --- throughout a function to help debug its execution flow.
    vim.keymap.set('v', '<leader>fp', function()
      _99.visual_prompt()
    end)
  end,
}
