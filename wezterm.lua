-- The art of doing more with less
-- Ke Meng, 2024, wezterm

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Set the color scheme depending on the system setting
config.color_scheme = 'Oxocarbon Dark (Gogh)'
-- config.color_scheme = 'Overnight Slumber'

-- Remove all padding
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- Multiplexing
config.unix_domains = {
  {
    name = 'unix',
  }
}

local act = wezterm.action
config.leader = { key = 'b', mods = 'CTRL' }
config.keys = {
  -- The session functionality of wezterm does too much than I expect.
  -- {
  --   -- attach to the unix domain
  --   mods = "LEADER",
  --   key = 'a',
  --   action = act.AttachDomain 'unix',
  -- },
  -- {
  --   -- detach from the unix domain
  --   mods = "LEADER",
  --   key = 'd',
  --   action = act.DetachDomain { DomainName = 'unix' },
  -- },
  -- {
  --   -- rename the current session
  --   mods = 'LEADER|SHIFT',
  --   key = '$',
  --   action = act.PromptInputLine {
  --     description = 'Enter new name for session',
  --     action = wezterm.action_callback(
  --       function(window, pane, line)
  --         if line then
  --           wezterm.mux.rename_workspace(
  --             wezterm.mux.get_active_workspace(),
  --             line
  --           )
  --         end
  --       end
  --     ),
  --   },
  -- },
  -- {
  --   -- show the launcher with the WORKSPACES
  --   key = 's',
  --   mods = 'LEADER',
  --   action = act.ShowLauncherArgs { flags = 'WORKSPACES' },
  -- },
  {
    mods = "LEADER",
    key = "%",
    action = act.SplitVertical { domain = 'CurrentPaneDomain' }
  },
  {
    mods = "LEADER",
    key = "\"",
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = act.ShowTabNavigator,
  },
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
      ),
    },
  },
  {
    -- Send ctrl+b to tmux if needed
    mods = "LEADER",
    key = "b",
    action = act.SendKey {
      key = 'b',
      mods = 'CTRL',
    },
  }
}

-- URLs in Markdown files are not handled properly by default
-- Source: https://github.com/wez/wezterm/issues/3803#issuecomment-1608954312
config.hyperlink_rules = {
  -- Matches: a URL in parens: (URL)
  {
    regex = '\\((\\w+://\\S+)\\)',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in brackets: [URL]
  {
    regex = '\\[(\\w+://\\S+)\\]',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in curly braces: {URL}
  {
    regex = '\\{(\\w+://\\S+)\\}',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in angle brackets: <URL>
  {
    regex = '<(\\w+://\\S+)>',
    format = '$1',
    highlight = 1,
  },
  -- Then handle URLs not wrapped in brackets
  {
    -- Before
    --regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
    --format = '$0',
    -- After
    regex = '[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)',
    format = '$1',
    highlight = 1,
  },
  -- implicit mailto link
  {
    regex = '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
    format = 'mailto:$0',
  },
}

-- Font configuration
-- config.font = wezterm.font( 'JetBrains Mono', { weight = "Bold" })
-- config.font = wezterm.font( 'PT Mono', { weight = "Bold" })
config.font = wezterm.font('Monaco', { weight = "Bold" })
config.font_size = 18
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'

-- Remove the title bar from the window
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.use_fancy_tab_bar = true
config.tab_max_width = 32
config.switch_to_last_active_tab_when_closing_tab = true

-- Use zsh by default
config.default_prog = { 'fish' }

-- Don't hide cursor when typing
config.hide_mouse_cursor_when_typing = false

-- Return the configuration to wezterm
return config
