-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local React = require(CorePackages.Packages.React)

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
