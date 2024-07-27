require('dashboard').setup {
    theme = 'hyper',
    config = {
        shortcut = {
            -- { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
            -- {
                --     icon = ' ',
                --     icon_hl = '@variable',
                --     desc = 'Files',
                --     group = 'Label',
                --     action = 'Telescope find_files',
                --     key = 'f',
                -- },
                {
                    desc = ' Apps',
                    group = 'DiagnosticHint',
                    action = 'Telescope app',
                    key = 'a',
                },
                {
                    desc = ' Chezmoi',
                    group = 'DiagnosticHint',
                    action = 'Telescope chezmoi',
                    key = 'c',
                },
                {
                    desc = ' dotfiles',
                    group = 'Number',
                    action = 'Telescope dotfiles',
                    key = 'd',
                },
            },
        }
    }
