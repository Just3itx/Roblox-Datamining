-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ResponsiveParent = script:FindFirstAncestor("Responsive").Parent
local React = require(ResponsiveParent.React)
local RoactServiceTags = require(ResponsiveParent.RoactServiceTags)
local useRoactService = require(ResponsiveParent.RobloxAppHooks).useRoactService

local function useIsInFullScreen()
    local var1 = useRoactService(RoactServiceTags.AppUserGameSettings)
    local var2, var3 = React.useState(var1:InFullScreen())

    React.useEffect(function()
        var3(var1:InFullScreen())
        local connection = var1.FullscreenChanged:Connect(function(isFullscreen: boolean)
            var3(isFullscreen)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    return var2
end

return useIsInFullScreen
