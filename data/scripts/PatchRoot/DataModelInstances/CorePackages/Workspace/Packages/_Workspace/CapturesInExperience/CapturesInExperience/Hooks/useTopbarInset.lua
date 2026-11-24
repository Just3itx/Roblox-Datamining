-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local ReactUtils = require(scriptParentParentParent.ReactUtils)

local GuiService = game:GetService("GuiService")

local React = require(scriptParentParentParent.React)

local useEventConnection = ReactUtils.useEventConnection

return function()
    local var1, var2 = React.useState(GuiService.TopbarInset)

    useEventConnection(GuiService:GetPropertyChangedSignal("TopbarInset"), function()
        var2(GuiService.TopbarInset)
    end)

    return var1
end
