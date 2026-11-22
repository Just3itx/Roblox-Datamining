-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)
local Style = require(scriptParentParentParent.Style)
local UIBlox = require(scriptParentParentParent.UIBlox)
local useDesignTokens = Style.useDesignTokens
local PlayerName = UIBlox.App.Indicator.PlayerName
local PlayerContext = UIBlox.App.Indicator.PlayerContext
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType

return function(arg1)
    local var1 = useDesignTokens(function(arg2)
        return {
            contextTextSpacing = arg2.Size.Size_150,
            joinEventSpacing = arg2.Size.Size_300,
            padding = arg2.Size.Size_400,
            joinEventButtonHeight = arg2.Size.Size_1200
        }
    end)

    local function func1()
        if not (arg1.renderJoinEventButton or arg1.joinEventText) then
            return nil
        end

        return React.createElement(
            "Frame",
            {
                LayoutOrder = 5,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            },
            {
                UIListLayout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left
                }),
                JoinEventSpacing = React.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        LayoutOrder = 4,
                        Size = UDim2.new(1, 0, 0, var1.joinEventSpacing)
                    }
                ),
                JoinButton = if arg1.renderJoinEventButton then arg1.renderJoinEventButton() else React.createElement(Button, {
                    buttonType = ButtonType.PrimaryContextual,
                    onActivated = arg1.joinEventOnActivated,
                    isLoading = false,
                    size = UDim2.new(1, 0, 0, var1.joinEventButtonHeight),
                    text = arg1.joinEventText,
                    layoutOrder = 5
                })
            }
        )
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1
    }

    tbl1[React.Change.AbsoluteSize] = function(arg2)
        arg1.onHeaderHeightChanged(arg2.AbsoluteSize.Y)
    end

    return createElement(str1, tbl1, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left
        }),
        UIPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var1.padding),
            PaddingBottom = UDim.new(0, var1.padding),
            PaddingLeft = UDim.new(0, var1.padding),
            PaddingRight = UDim.new(0, var1.padding)
        }),
        PlayerName = React.createElement(PlayerName, {
            automaticSize = Enum.AutomaticSize.XY,
            displayNameItem = arg1.displayNameItem,
            layoutOrder = 1,
            userNameItem = arg1.userNameItem,
            vendorNameItem = arg1.vendorNameItem
        }),
        ContextTextSpacing = if arg1.contextText then React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, var1.contextTextSpacing)
            }
        ) else nil,
        PlayerContext = if arg1.contextText then React.createElement(PlayerContext, {
            icon = arg1.contextIcon,
            iconColor = arg1.contextIconColor,
            iconTransparency = arg1.contextIconTransparency,
            text = arg1.contextText,
            layoutOrder = 3,
            Selectable = false
        }) else nil,
        JoinButton = func1()
    })
end
