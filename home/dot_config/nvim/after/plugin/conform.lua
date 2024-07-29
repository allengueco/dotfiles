require('conform').setup {
    formatters_by_ft = {
        markdown = { 'prettier' }
    },
    format_on_save = {
        async = false
    }
}
