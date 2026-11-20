-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local OverlayContext = require(script.Parent.OverlayContext)

local function useScreen()
    local var1 = React.useContext(OverlayContext)

    React.useLayoutEffect(function()
        var1.requestOverlay()
    end, { var1.requestOverlay })

    return var1.screen
end

return useScreen
