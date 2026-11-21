-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent
local Foundation = require(GameFiltersParent.Foundation)
local React = require(GameFiltersParent.React)
local UIBlox = require(GameFiltersParent.UIBlox)
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local useLocalization = require(GameFiltersParent.Localization).Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens

local function FilterMenuActionBar(tbl1)
    local var1 = useTokens()

    local surface100 = var1.Color.Surface.Surface_100

    local var2 = useLocalization({ apply = "CommonUI.Messages.Action.Apply" })

    return React.createElement("Frame", {
        LayoutOrder = tbl1.LayoutOrder,
        BackgroundTransparency = surface100.Transparency,
        BackgroundColor3 = surface100.Color3,
        BorderSizePixel = 0,
        Size = tbl1.Size
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) }),
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var1.Padding.XXLarge),
            PaddingBottom = UDim.new(0, var1.Padding.XXLarge),
            PaddingLeft = UDim.new(0, var1.Padding.XXLarge),
            PaddingRight = UDim.new(0, var1.Padding.XXLarge)
        }),
        ApplyButton = React.createElement(Button, {
            buttonType = ButtonType.PrimaryContextual,
            size = UDim2.fromScale(1, 1),
            text = var2.apply,
            isDisabled = not tbl1.applyEnabled,
            onActivated = tbl1.onApply
        })
    })
end

return FilterMenuActionBar
