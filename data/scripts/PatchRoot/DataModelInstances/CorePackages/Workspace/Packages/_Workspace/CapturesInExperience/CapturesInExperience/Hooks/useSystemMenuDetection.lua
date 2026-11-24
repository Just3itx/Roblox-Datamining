-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)
local useEventConnection = require(scriptParentParentParent.ReactUtils).useEventConnection
local useState = React.useState

local function useSystemMenuDetection()
    local var1, var2 = useState(false)

    useEventConnection(GuiService.MenuOpened, function()
        var2(true)
    end)

    useEventConnection(GuiService.MenuClosed, function()
        var2(false)
    end)

    return var1
end

return useSystemMenuDetection
