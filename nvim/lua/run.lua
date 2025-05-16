local run = {
    buf = nil,
    win = nil,
    jobid = nil,
}

local function set_buf_contents(bufnr, contents)
    vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
    vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
end

vim.api.nvim_create_user_command("Run", function(opts)
    local popts = {}
    for _, arg in ipairs(opts.fargs) do
        if arg == '%' then
            table.insert(popts, vim.fn.expand(arg))
        else
            table.insert(popts, arg)
        end
    end
    table.insert(popts, "2>&1")
    local cmd = table.concat(popts, " ")
    local curwin = vim.api.nvim_get_current_win()
    local curbuf = vim.api.nvim_get_current_buf()

    if not run.buf or not vim.api.nvim_buf_is_valid(run.buf) then
        vim.cmd "belowright 5split"
        run.win = vim.api.nvim_get_current_win()
        run.buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_win_set_buf(run.win, run.buf)

        -- buffer setup
        vim.api.nvim_set_option_value("buftype", "nofile", { buf = run.buf })
        vim.api.nvim_set_option_value("filetype", "text", { buf = run.buf })
        vim.api.nvim_set_option_value("bufhidden", "hide", { buf = run.buf })
        vim.api.nvim_set_option_value("swapfile", false, { buf = run.buf })
        vim.api.nvim_set_option_value("buflisted", false, { buf = run.buf })
        vim.api.nvim_buf_set_name(run.buf, "[Run Output]")
    elseif not run.win or not vim.api.nvim_win_is_valid(run.win) then
        vim.cmd "belowright 5split"
        run.win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(run.win, run.buf)
        set_buf_contents(run.buf, {})
    else
        vim.api.nvim_set_current_win(run.win)
        vim.api.nvim_win_set_buf(run.win, run.buf)
        set_buf_contents(run.buf, {})
    end

    local output = vim.fn.systemlist(cmd)
    local exitcode = vim.v.shell_error
    table.insert(output, "") -- newline
    table.insert(output, string.format("[Program exited with code %d]", exitcode))

    set_buf_contents(run.buf, output)

    vim.api.nvim_win_set_buf(curwin, curbuf)
end, { nargs = "+", desc = "run a command in a terminal buffer", complete = 'shellcmd' })
