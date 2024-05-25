return {
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.keymap.set({ "n", "v" }, "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "[m]arkdown [p]review" })
    end,
    ft = "markdown",
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
  {
    -- "preservim/vim-markdown",
    "ixru/nvim-markdown",
    config = function()
      vim.cmd([[set conceallevel=2
      " let g:vim_markdown_conceal = 2
      " let g:vim_markdown_math = 1
      map <Plug> <Plug>Markdown_Fold
      nmap zc <Plug>Markdown_Fold
      " let g:vim_markdown_fenced_languages = ['julia=jl']
      ]])
    end,
    enabled = true,
    ft = "markdown",
    keys = {
      { "[[", "<Plug>Markdown_MoveToPreviousHeader<CR>", desc = "Previous [H]eader"},
      { "]]", "<Plug>Markdown_MoveToNextHeader<CR>", desc = "Next [H]eader"},
      { "<leader>ih", "<cmd>'<,'>HeaderDecrease<cr>", mode = "v" , desc = "[I]ncrease [H]eader"},
      { "<leader>lh", "<cmd>'<,'>HeaderIncrease<cr>", mode = "v" , desc = "[L]ower [H]eader"},
    },
    -- event="BufEnter *.md"
  },
  {
    "epwalsh/obsidian.nvim",
    enabled = true,
    lazy = true,
    event = "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**.md",
    cmd = { "ObsidianOpen", "ObsidianQuickSwitch", "ObsidianSearch" },
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
    -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- Optional, for completion.
      "hrsh7th/nvim-cmp",

      -- Optional, for search and quick-switch functionality.
      "nvim-telescope/telescope.nvim",

      -- Optional, alternative to nvim-treesitter for syntax highlighting.
      "godlygeek/tabular",
      -- "preservim/vim-markdown",
      "ixru/nvim-markdown",
    },
    opts = {
      dir = "~/Obsidian/myVault/", -- no need to call 'vim.fn.expand' here

      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = "Zettelkasten/",
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Temporal/Daily Notes/",
        -- Optional, if you want to change the date format for daily notes.
        date_format = "%Y-%m-%d",
      },

      -- Optional, completion.
      completion = {
        nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
      },

      -- -- Optional, customize how names/IDs for new notes are created.
      note_id_func = function(title)
        return title
      end,
      --
      -- Optional, set to true if you don't want Obsidian to manage frontmatter.
      disable_frontmatter = true,

      -- Optional, alternatively you can customize the frontmatter data.
      note_frontmatter_func = function(note)
        -- This is equivalent to the default frontmatter function.
        -- local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        local out = {}
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,

      -- -- Optional, for templates (see below).
      -- templates = {
      --   subdir = "templates",
      --   date_format = "%Y-%m-%d-%a",
      --   time_format = "%H:%M",
      -- },
      --
      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({ "open", url }) -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,

      -- Optional, set to true if you use the Obsidian Advanced URI plugin.
      -- https://github.com/Vinzent03/obsidian-advanced-uri
      use_advanced_uri = true,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = true,

      -- Optional, by default commands like `:ObsidianSearch` will attempt to use
      -- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
      -- first one they find. By setting this option to your preferred
      -- finder you can attempt it first. Note that if the specified finder
      -- is not installed, or if it the command does not support it, the
      -- remaining finders will be attempted in the original order.
      finder = "telescope.nvim",
    },
    config = function(_, opts)
      require("setup.export_obsidian") -- load personal export function.
      require("obsidian").setup(opts)

      -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
      -- see also: 'follow_url_func' config option above.
      vim.keymap.set("n", "gf", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          return "gf"
        end
      end, { noremap = false, expr = true })
    end,
    keys = {
      { "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", desc = "Open Obsidian File" },
      { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open Note in Obsidian" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Open Backlinks" },
    },
  },
}
