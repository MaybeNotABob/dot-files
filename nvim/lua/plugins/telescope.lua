  -- telescope requires the following tools to be installed for full
  -- functionality:
  --  
  -- BurntSushi/ripgrep     -- https://github.com/BurntSushi/ripgrep
  -- sharkdp/fd             -- https://github.com/sharkdp/fd


local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    event = { "InsertEnter","BufReadPre", "BufNewFile", "BufEnter" },
}


function M.config ()

    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then
        return
    end

    local actions = require "telescope.actions"

    telescope.setup {
        defaults = {

            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },

            -- Layout configuration:
            -- - Preview
            -- - Results
            -- - Prompt
            sorting_strategy = "ascending",
            layout_strategy = "vertical",
            layout_config = {
                -- Anchor the layout to the bottom (South)
                anchor = "S",               

                -- Force Telescope to strictly use 100% of the screen width, 
                -- ignoring default margins
                width = function(_, max_columns, _)
                    return max_columns
                end,

                -- Take up percentage% of the screen height. 0.5 = 50%
                height = 0.5,               
                -- Place the prompt at the very bottom
                prompt_position = "bottom",
                -- Ensure the previewer is never hidden
                preview_cutoff = 1,         
            },

            border = true,
            borderchars = {
                -- prompt  = { "", "", "", "", "", "", "", "" },
                prompt  = { "─", " ", " ", " ", "─", "─", " ", " " },
                results = { "─", " ", " ", " ", "─", "─", " ", " " },
                preview = { "─", " ", " ", " ", "─", "─", " ", " " },
            },

            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob=!.git/",
            },

            mappings = {
                i = {
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,

                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,

                    ["<C-c>"] = actions.close,

                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,

                    ["<CR>"] = actions.select_default,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,

                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,

                    ["<PageUp>"] = actions.results_scrolling_up,
                    ["<PageDown>"] = actions.results_scrolling_down,

                    ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-l>"] = actions.complete_tag,
                    ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
                },

                n = {
                    ["<esc>"] = actions.close,
                    ["bd"] = actions.delete_buffer,

                    ["<CR>"] = actions.select_default,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,

                    ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["H"] = actions.move_to_top,
                    ["M"] = actions.move_to_middle,
                    ["L"] = actions.move_to_bottom,

                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,
                    ["gg"] = actions.move_to_top,
                    ["G"] = actions.move_to_bottom,

                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,

                    ["<PageUp>"] = actions.results_scrolling_up,
                    ["<PageDown>"] = actions.results_scrolling_down,

                    ["?"] = actions.which_key,
                },
            },
        },

        pickers = {
            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
         
            diagnostics = {
                severity_sort = true, 
                initial_mode = "normal",
            },

            buffers = {
                sort_mru = true,
                sort_lastused = true,
                initial_mode = "normal",
            },

            lsp_definitions = {
                initial_mode = "normal",
            },

            lsp_declarations = {
                initial_mode = "normal",
            },

            lsp_document_symbols = {
                initial_mode = "normal",
            },

            lsp_workspace_symbols = {
                initial_mode = "normal",
            },

            lsp_dynamic_workspace_symbols = {
                initial_mode = "normal",
            },

            find_files = {
                initial_mode = "insert",
            },

            live_grep = {
                initial_mode = "insert",
            }
        }, 

    }
end


return M
