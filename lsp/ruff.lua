return {
  on_attach = function(client)
    -- Disable hover in favor of pyright
    client.server_capabilities.hoverProvider = false
  end,
}
