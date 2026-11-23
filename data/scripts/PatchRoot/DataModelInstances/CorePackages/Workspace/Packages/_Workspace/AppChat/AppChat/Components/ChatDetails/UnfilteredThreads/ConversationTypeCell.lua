-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local UIBlox = require(AppChatParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize

local BaseCell = require(AppChat.Components.Cells.BaseCell)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)

local Foundation = require(AppChatParent.Foundation)
local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    bodyText = "Placeholder body",
    iconImage = nil,
    iconSize = IconSize.Small,
    iconCellWidth = 30,
    shouldShowIcon = true,
    cellHeight = 28,
    onIconActivated = function() end
}

local function ConversationTypeCell(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local var3 = var1.style or var2
    local theme = var3.Theme
    local size300 = var3.Tokens.Size.Size_300
    local var4 = useTokens()
    local var5 = useIsInExperience()
    local var6, var7 = React.useBinding(0)
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var7(arg1.AbsoluteSize.X)
    end, {})

    local createElement = React.createElement
    local var9 = BaseCell
    local tbl3 = {
        Size = UDim2.new(1, 0, 0, var1.cellHeight),
        BackgroundColor3 = if var5 then var4.Color.None.Color3 else theme.BackgroundDefault.Color,
        BackgroundTransparency = if var5 then var4.Color.None.Transparency else var3.Theme.BackgroundDefault.Transparency,
        LayoutOrder = var1.layoutOrder,
        Selectable = false,
        dividerColor3 = theme.Divider.Color,
        dividerTransparency = theme.Divider.Transparency,
        isDisabled = true,
        showDivider = false
    }

    local tbl4 = {
        UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, size300), PaddingRight = UDim.new(0, size300) }),
        Content = 0
    }
    local createElement2 = React.createElement
    local view = Foundation.View
    local tbl5 = {
        tag = "row size-full align-y-center",
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }

    local tbl6 = {
        Text = React.createElement(Foundation.Text, {
            LayoutOrder = 1,
            Text = var1.bodyText,
            sizeConstraint = {
                MaxSize = var6:map(function(num1: number): Vector2
                    local var10 = num1 - (if var1.shouldShowIcon then var1.iconCellWidth else 0)
                    return Vector2.new(not (var10 > 0) and math.huge or var10, math.huge)
                end)
            },
            tag = "size-0-full auto-x content-emphasis text-align-x-left text-title-large text-truncate-end"
        }),
        InfoIcon = 0
    }

    local element

    if var1.shouldShowIcon then
        element = React.createElement(IconButton, {
            backgroundTransparency = 1,
            icon = var1.iconImage,
            iconColor3 = theme.IconDefault.Color,
            iconSize = var1.iconSize,
            iconTransparency = theme.IconDefault.Transparency,
            layoutOrder = 2,
            size = UDim2.fromOffset(var1.iconCellWidth, var1.iconCellWidth),
            onActivated = var1.onIconActivated
        })
    else
        element = nil
    end

    tbl6.InfoIcon = element
    tbl4.Content = createElement2(view, tbl5, tbl6)
    return createElement(var9, tbl3, tbl4)
end

return ConversationTypeCell
