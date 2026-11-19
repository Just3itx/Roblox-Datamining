-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local Service = require(ChromeShared.Service)

local useChromeWindowItems = require(ChromeShared.Hooks.useChromeWindowItems)
local WindowHost = require(ChromeShared.Unibar.ComponentHosts.WindowHost)

return function(_)
    local result = ({})

    for _, integration in (useChromeWindowItems()) do
        local var1 = "window_" .. integration.integration.id
        result[var1] = React.createElement(
            WindowHost,
            {
                position = Service:windowPosition(integration.integration.id),
                integration = integration
            }
        )
    end
    return result
end
