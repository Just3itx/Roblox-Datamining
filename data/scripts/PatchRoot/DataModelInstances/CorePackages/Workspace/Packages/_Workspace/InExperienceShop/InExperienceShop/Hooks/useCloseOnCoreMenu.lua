-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)

local GuiService = game:GetService("GuiService")

local function useCloseOnCoreMenu(func1: (...any) -> (...any))
    React.useEffect(function()
        local connection = GuiService.MenuOpened:Connect(func1)
        return function()
            connection:Disconnect()
        end
    end, { func1 })
end

return useCloseOnCoreMenu
