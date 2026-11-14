local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    event = { "VimEnter", "BufReadPre", "BufNewFile" },
}

function M.config()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    local fd = vim.fn.executable("fd") == 1 and "fd"
        or (vim.fn.executable("fdfind") == 1 and "fdfind" or nil)

    local find_command
    if fd then
        find_command = {
            fd,
            "--type",
            "f",
            "--hidden",
            "--follow",
            "--exclude",
            ".git",
        }
    else
        find_command = {
            "find",
            ".",
            "-type",
            "f",
            "-not",
            "-path",
            "./.git/*",
        }

        vim.schedule(function()
            vim.notify(
                "fd is not installed. Telescope will use find as a fallback. Install fd for faster file discovery.",
                vim.log.levels.WARN,
                { title = "Telescope optional dependency" }
            )
        end)
    end

    local rg = vim.fn.executable("rg") == 1
    local vimgrep_arguments

    if rg then
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
        }
    else
        -- grep is a functional fallback for manual :Telescope live_grep use.
        vimgrep_arguments = {
            "grep",
            "-nH",
            "--color=never",
            "-R",
            "-I",
            "--exclude-dir=.git",
        }

        vim.schedule(function()
            vim.notify(
                "ripgrep (rg) is not installed. Telescope live_grep will use grep; install ripgrep for better results and performance.",
                vim.log.levels.WARN,
                { title = "Telescope optional dependency" }
            )
        end)
    end

    telescope.setup({
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },
            sorting_strategy = "ascending",
            layout_strategy = "vertical",
            layout_config = {
                anchor = "S",
                width = function(_, max_columns)
                    return max_columns
                end,
                height = 0.5,
                prompt_position = "bottom",
                preview_cutoff = 1,
            },
            border = true,
            borderchars = {
                prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                results = { "─", " ", " ", " ", "─", "─", " ", " " },
                preview = { "─", " ", " ", " ", "─", "─", " ", " " },
            },
            vimgrep_arguments = vimgrep_arguments,
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
                    ["<C-_>"] = actions.which_key,
                },
                n = {
                    ["<Esc>"] = actions.close,
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
            diagnostics = {
                severity_sort = true,
                initial_mode = "normal",
            },
            buffers = {
                sort_mru = true,
                sort_lastused = true,
                initial_mode = "normal",
            },
            lsp_definitions = { initial_mode = "normal" },
            lsp_declarations = { initial_mode = "normal" },
            lsp_document_symbols = { initial_mode = "normal" },
            lsp_workspace_symbols = { initial_mode = "normal" },
            lsp_dynamic_workspace_symbols = { initial_mode = "normal" },
            find_files = {
                initial_mode = "insert",
                find_command = find_command,
            },
            live_grep = { initial_mode = "insert" },
        },
    })
end

return M
