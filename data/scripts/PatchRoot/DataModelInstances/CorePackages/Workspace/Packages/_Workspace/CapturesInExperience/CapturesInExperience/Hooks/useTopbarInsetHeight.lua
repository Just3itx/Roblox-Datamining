-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local GuiService = game:GetService("GuiService")

local React = require(scriptParentParentParent.React)

return function()
    local var1, var2 = React.useState(GuiService.TopbarInset.Height)

    React.useEffect(function()
        local connection = GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function()
            var2(GuiService.TopbarInset.Height)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end
