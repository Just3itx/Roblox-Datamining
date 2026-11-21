-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local ChatLineReportingParent = ChatLineReporting.Parent

local React = require(ChatLineReportingParent.React)
local ReactOtter = require(ChatLineReportingParent.ReactOtter)
local Foundation = require(ChatLineReportingParent.Foundation)

local normalizeFontFace = Foundation.Utility.normalizeFontFace
local useLocalization = require(ChatLineReportingParent.Localization).Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local Constants = require(ChatLineReporting.Common.Constants)

local tbl1 = {
    stiffness = 400,
    damping = 40,
    mass = 1,
    restingPositionLimit = 0.5,
    restingVelocityLimit = 0.1
}

local function ChatLineReportInfo(tbl2)
    local var1 = useTokens()
    local var2, var3 = React.useState(false)

    local var4 = useLocalization(Constants.ChatLineLocalizationKeys)

    React.useEffect(function()
        var3(tbl2.visible)
    end, { tbl2.visible })

    local var5, var6 = ReactOtter.useAnimatedBinding(1, function() end)

    local var7 = React.useMemo(function(): number
        return if var2 then 0 else 1
    end, { var2 })

    React.useEffect(function()
        var6(ReactOtter.spring(var7, tbl1))
    end, { var7 })

    local createElement = React.createElement

    local tbl3 = {
        Active = var5:map(function(arg1): boolean
            return arg1 == 0
        end),
        AutoButtonColor = false,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Selectable = false,
        Size = UDim2.new(1, 0, 1, 0),
        Text = ""
    }

    tbl3[React.Event.Activated] = function()
        var3(false)
    end
    tbl3.ZIndex = var5:map(function(num1: number): number
        return (1 - num1) * 4
    end)

    return createElement("TextButton", tbl3, {
        InfoTextFrame = React.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Size = var5:map(function(alpha: number): UDim2
                return UDim2.new(1, 0, 0, 60):Lerp(UDim2.new(1, 0, 0, 0), alpha)
            end),
            ClipsDescendants = true,
            ZIndex = 2
        }, {
            InfoTextContainer = React.createElement(
                View,
                {
                    Size = UDim2.new(1, 0, 1, -8),
                    tag = "bg-over-media-0 radius-medium anchor-bottom-left position-bottom-left"
                },
                {
                    InfoText = React.createElement("TextLabel", {
                        BackgroundTransparency = 1,
                        FontFace = normalizeFontFace(var1.Typography.BodySmall.Font),
                        Text = var4.InfoTextKey,
                        TextColor3 = var1.Color.Content.Default.Color3,
                        TextSize = var1.Typography.BodySmall.FontSize,
                        TextWrapped = true,
                        Size = UDim2.new(1, 0, 1, 0)
                    })
                }
            )
        })
    })
end
return ChatLineReportInfo
