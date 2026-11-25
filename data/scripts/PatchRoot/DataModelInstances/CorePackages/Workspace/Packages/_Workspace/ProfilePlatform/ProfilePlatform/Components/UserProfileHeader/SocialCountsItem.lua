-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent
local React = require(ProfilePlatformParent.React)

local Interactable = require(ProfilePlatformParent.UIBlox).Core.Control.Interactable
local Foundation = require(ProfilePlatformParent.Foundation)
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local function NOOP() end

local function SocialCountsItem(tbl1)
    local var1 = useTokens()
    local active = not tbl1.isDisabled and tbl1.count ~= "0"

    local textStyle = active and var1.Color.Content.Emphasis or var1.Color.Content.Muted

    return React.createElement(Interactable, {
        Size = UDim2.fromScale(0.25, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        [React.Event.Activated] = if active then tbl1.onActivated else NOOP,
        onStateChanged = NOOP,
        LayoutOrder = tbl1.layoutOrder,
        Active = active
    }, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Count = React.createElement(FoundationText, {
            Text = tbl1.count,
            tag = "text-align-y-bottom auto-xy",
            fontStyle = var1.Typography.HeadingSmall,
            textStyle = textStyle,
            LayoutOrder = 1
        }),
        Text = React.createElement(FoundationText, {
            Text = tbl1.text,
            tag = "text-align-y-top auto-xy",
            fontStyle = var1.Typography.CaptionMedium,
            textStyle = textStyle,
            LayoutOrder = 2
        })
    })
end

return SocialCountsItem
