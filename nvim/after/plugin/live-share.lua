local ls = require("live-share")
ls.setup {
    username       = "ezntek",              -- displayed to other participants
    port_internal  = 6969,                  -- local TCP port for the collab server
    port           = 80,                    -- external tunnel port
    max_attempts   = 40,                    -- URL polling retries (× 250 ms = 10 s)
    service_url    = "/tmp/service.url",    -- temp file where the tunnel writes its URL
    service        = "nokey@localhost.run", -- tunnel provider (see below)
    workspace_root = nil,                   -- defaults to cwd
    debug          = false,                 -- enable verbose logging
}
