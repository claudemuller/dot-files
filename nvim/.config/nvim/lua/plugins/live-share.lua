return {
  "azratul/live-share.nvim",
  dependencies = {
    {
      "vhyrro/luarocks.nvim",
      lazy = false, -- must load before everything else
      priority = 1000,
      config = true,
      opts = { rocks = { "punch >= 0.3.2" } },
    },
  },
  opts = {},
  config = function()
    -- {
    --   "openPair.service": "bore",
    --   "openPair.boreArgs": [
    --   "--to", "192.168.1.52"
    --   ],
    --   "open-pair.borePort": 7835
    -- }

    local HOST_IP = "192.168.1.52"

    require("live-share.provider").register("bore", {
      command = function(_, port, service_url)
        return string.format("bore local %d --to %s > %s 2>&1", port, HOST_IP, service_url)
      end,
      pattern = "listening at (" .. HOST_IP:gsub("%.", "%%.") .. ":%d+)",
    })

    require("live-share").setup({
      username = "lukefilewalker",
      service = "bore",
      transport = "punch",
    })
  end,
}
