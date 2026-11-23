-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local React = require(AvatarWorkshopParent.React)
local useTokens = require(AvatarWorkshopParent.Foundation).Hooks.useTokens
local RoactNavigation = require(AvatarWorkshopParent.RoactNavigation)

local WorkshopWindowContext = require(AvatarWorkshop.Contexts.WorkshopWindowContext)
local WorkshopNavigator = require(AvatarWorkshop.Navigation.Navigators.WorkshopNavigator)

local appContainer = RoactNavigation.createAppContainer(WorkshopNavigator)

local function AvatarWorkshopWindow(tbl1)
    local var1 = useTokens()

    local value = React.useMemo(function()
        return {
            verticalLayout = tbl1.verticalLayout,
            onClose = tbl1.onClose
        }
    end, { tbl1.verticalLayout, tbl1.onClose })

    return React.createElement("Frame", {
        Active = true,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = var1.Color.Surface.Surface_100.Color3,
        BackgroundTransparency = var1.Color.Surface.Surface_100.Transparency
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) }),
        Navigation = React.createElement(WorkshopWindowContext.Provider, { value = value }, React.createElement(appContainer))
    })
end

return AvatarWorkshopWindow
