return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require("neogit").setup({
        kind = "floating",
        integrations = {
          telescope = true,
          diffview = true,
        },
      })
      dofile(vim.g.base46_cache .. "git")
      dofile(vim.g.base46_cache .. "neogit")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, conf)
      conf.current_line_blame = true
      conf.on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Git Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Git Prev hunk" })

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git Stage Hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git Discard Hunk" })

        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git Stage Selection" })

        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git Discard Selection" })

        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git Stage Buffer" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git Discard Buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git Preview hunk" })
        map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Git Preview Hunk Inline" })

        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "Git Blame Line" })

        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git Diff This" })

        -- I don't know what these do so I'm commenting them out.
        -- map("n", "<leader>hD", function()
        --   gitsigns.diffthis("~")
        -- end)
        --
        -- map("n", "<leader>hQ", function()
        --   gitsigns.setqflist("all")
        -- end)
        -- map("n", "<leader>hq", gitsigns.setqflist)

        -- Toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Git Toggle Line Blame" })
        map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Git Toggle Deleted" })
        map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Git Toggle Word Diff" })

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk)
      end

      return conf
    end,
  },
}
