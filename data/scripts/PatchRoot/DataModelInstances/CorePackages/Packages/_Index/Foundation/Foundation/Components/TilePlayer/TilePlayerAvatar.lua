-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Avatar = require(Foundation.Components.Avatar)
local AvatarSize = require(Foundation.Enums.AvatarSize)
local _ControlState = require(Foundation.Enums.ControlState)
local _Types = require(Foundation.Components.Types)
local UserPresence = require(Foundation.Enums.UserPresence)
local View = require(Foundation.Components.View)
local getStateLayerStyle = require(Foundation.Components.Interactable.getStateLayerStyle)
local useTokens = require(Foundation.Providers.Style.useTokens)

return React.memo(function(tbl1) -- name: TilePlayerAvatar
    local var1 = useTokens()
    local size2400 = var1.Size.Size_2400

    local var2, var3 = React.useBinding(0)
    local var4, var5 = React.useBinding(1)
    local var6 = React.useMemo(function()
        return React.joinBindings({ var2, var4 }):map(function(tbl2)
            return tbl2[1] / tbl2[2]
        end)
    end, {})
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize.X)
    end, {})
    local var7 = React.useCallback(function(arg1)
        if arg1.AbsoluteSize.X > 0 then
            var5(arg1.AbsoluteSize.X / 100)
        end
    end, {})

    local offset = if tbl1.userPresence ~= UserPresence.InExperience then 0 else var1.Stroke.Thicker + var1.Stroke.Standard

    local var9 = size2400 + offset * 2

    return React.createElement(View, {
        Size = UDim2.fromScale(1, 1),
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }, {
        Reference = React.createElement(View, { Size = UDim2.fromOffset(100, 0), onAbsoluteSizeChanged = var7 }),
        AvatarContainer = React.createElement(View, {
            Size = UDim2.fromOffset(var9, var9),
            padding = UDim.new(0, offset)
        }, {
            Scale = React.createElement("UIScale", {
                Scale = var6:map(function(num1: number)
                    return num1 / var9
                end)
            }),
            Avatar = React.createElement(Avatar, {
                userId = tbl1.userId,
                userPresence = tbl1.userPresence,
                includeProfileFrame = tbl1.includeProfileFrame,
                size = AvatarSize.Pictogram,
                backgroundStyle = tbl1.backgroundStyle or var1.Color.Shift.Shift_200,
                testId = `{tbl1.testId}--avatar`
            })
        }),
        StateLayer = if tbl1.controlState then React.createElement(View, {
            tag = "size-full-full radius-circle",
            backgroundStyle = tbl1.controlState:map(function(arg1)
                return getStateLayerStyle(var1, nil, arg1)
            end),
            ZIndex = 2,
            testId = `{tbl1.testId}--state-layer`
        }) else nil
    })
end)
