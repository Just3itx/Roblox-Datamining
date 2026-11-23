-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Icon = Foundation.Icon
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize

local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    {
        key = "Chat",
        icon = IconName.Nebula
    },
    {
        key = "Select",
        icon = IconName.CursorStars
    },
    {
        key = "Capture",
        icon = IconName.FrameCameraCenter,
        isHighlighted = true
    },
    {
        key = "Publish",
        icon = IconName.ArrowUpRightFromSquare
    }
}

local tbl2 = {
    bottomBar = Vector2.new(124, 220),
    sideRail = Vector2.new(220, 124),
    floating = Vector2.new(240, 170)
}

local function renderButtons()
    local result = ({})
    for layoutOrder, value2 in tbl1 do
        local key = value2.key
        local createElement = React.createElement
        local var1 = View
        local tbl3 = {
            LayoutOrder = layoutOrder,
            tag = {
                ["row align-x-center align-y-center size-600-600 radius-small"] = true,
                ["bg-action-emphasis"] = value2.isHighlighted == true
            },
            testId = `ChatCaptureToolbarIllustration.{value2.key}`
        }
        local tbl4 = {
            Icon = React.createElement(Icon, {
                name = value2.icon,
                size = IconSize.XSmall,
                tag = {
                    ["auto-xy"] = true,
                    ["content-action-emphasis"] = value2.isHighlighted == true,
                    ["content-default"] = value2.isHighlighted ~= true
                }
            })
        }
        result[key] = createElement(var1, tbl3, tbl4)
    end

    return result
end

local function renderEdgeBar(str1: string)
    local bool1 = str1 == "bottomBar"
    local createElement = React.createElement
    local var1 = View
    local tbl3 = {
        tag = {
            ["position-bottom-center anchor-bottom-center size-full-0 auto-y"] = bool1,
            ["position-center-right anchor-center-right size-0-full auto-x"] = not bool1
        },
        testId = if bool1 then "ChatCaptureToolbarIllustration.BottomBar" else "ChatCaptureToolbarIllustration.SideRail"
    }

    local tbl4 = {
        RoundedBackground = React.createElement(View, { tag = "size-full radius-large bg-surface-100" }),
        SquareBackground = React.createElement(View, {
            Size = if bool1 then UDim2.fromScale(1, 0.5) else UDim2.fromScale(0.5, 1),
            tag = "position-top-left anchor-top-left bg-surface-100"
        }),
        Buttons = React.createElement(View, {
            ZIndex = 2,
            tag = {
                ["align-x-center align-y-center gap-xxsmall padding-xsmall"] = true,
                ["row size-full-0 auto-y"] = bool1,
                ["col size-0-full auto-x"] = not bool1
            }
        }, (renderButtons()))
    }
    return createElement(var1, tbl3, tbl4)
end

local function renderToolbar(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 ~= "floating" then
        return renderEdgeBar(str1)
    end
    return React.createElement(View, {
        tag = "col align-x-center gap-xxsmall position-center-right anchor-center-right auto-xy padding-xxsmall radius-small bg-surface-100",
        testId = "ChatCaptureToolbarIllustration.Floating"
    }, (renderButtons()))
end

local function ChatCaptureToolbarIllustration(tbl3)
    local var1 = useTokens()
    local var2 = tbl2[tbl3.layout] * var1.Config.UI.Scale

    local createElement = React.createElement
    local var3 = View
    local tbl4 = {
        LayoutOrder = tbl3.LayoutOrder,
        tag = "row align-x-center size-full-0 auto-y",
        testId = "ChatCaptureToolbarIllustration"
    }

    local tbl5 = { Device = 0 }
    local createElement2 = React.createElement
    local var4 = View
    local tbl6 = {
        Size = UDim2.fromOffset(var2.X, var2.Y),
        tag = "stroke-thick stroke-emphasis radius-large clip bg-shift-200",
        testId = "ChatCaptureToolbarIllustration.Device"
    }

    local tbl7 = { ToolbarArea = 0 }
    local createElement3 = React.createElement
    local var5 = View
    local tbl8 = {
        tag = {
            ["size-full"] = true,
            ["padding-small"] = tbl3.layout == "floating"
        }
    }
    local tbl9 = { Toolbar = 0 }
    local layout = tbl3.layout
    tbl9.Toolbar = if layout ~= "floating" then renderEdgeBar(layout) else renderToolbar("floating")
    tbl7.ToolbarArea = createElement3(var5, tbl8, tbl9)
    tbl5.Device = createElement2(var4, tbl6, tbl7)
    return createElement(var3, tbl4, tbl5)
end

return ChatCaptureToolbarIllustration
