-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)
local View = require(scriptParentParentParentParent.Foundation).View

local FFlagAddNewPlayerListFocusNav = require(scriptParentParentParent.Flags.FFlagAddNewPlayerListFocusNav)
local FFlagRemoveNewPlayerListOverlay = require(scriptParentParentParent.Flags.FFlagRemoveNewPlayerListOverlay)

local function EntryFrameView(tbl1)
    return React.createElement(
        View,
        {
            Size = tbl1.size,
            BackgroundTransparency = if FFlagRemoveNewPlayerListOverlay then nil else 1,
            AutoButtonColor = if FFlagRemoveNewPlayerListOverlay then nil else false,
            backgroundStyle = FFlagRemoveNewPlayerListOverlay
                and {
                    Color3 = tbl1.backgroundStyle.Color,
                    Transparency = tbl1.backgroundStyle.Transparency
                }
                or nil,
            Text = if FFlagRemoveNewPlayerListOverlay then nil else "",
            AutoLocalize = if FFlagRemoveNewPlayerListOverlay then nil else false,
            Selectable = not tbl1.isTeamFrame,
            Active = if FFlagRemoveNewPlayerListOverlay then nil else not tbl1.isTeamFrame,
            onActivated = tbl1.onActivated,
            onStateChanged = tbl1.onStateChanged,
            ref = if FFlagAddNewPlayerListFocusNav then tbl1.forwardRef else tbl1.firstPlayerRef
        },
        not FFlagRemoveNewPlayerListOverlay
            and {
                BackgroundFrame = React.createElement("Frame", {
                    ZIndex = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = tbl1.backgroundStyle.Transparency,
                    BackgroundColor3 = tbl1.backgroundStyle.Color,
                    BorderSizePixel = 0
                }),
                DoubleOverLay = React.createElement("Frame", {
                    ZIndex = 1,
                    Visible = tbl1.doubleOverlay,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = tbl1.overlayStyle and tbl1.overlayStyle.Transparency,
                    BackgroundColor3 = tbl1.overlayStyle and tbl1.overlayStyle.Color,
                    BorderSizePixel = 0
                }),
                OverlayFrame = React.createElement("Frame", {
                    ZIndex = 2,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = tbl1.overlayStyle and tbl1.overlayStyle.Transparency,
                    BackgroundColor3 = tbl1.overlayStyle and tbl1.overlayStyle.Color,
                    BorderSizePixel = 0
                }, tbl1.children)
            }
            or tbl1.children
    )
end

if not FFlagAddNewPlayerListFocusNav then
    return React.memo(EntryFrameView)
end

local var1 = React.forwardRef(function(arg1, forwardRef)
    return React.createElement(EntryFrameView, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)

return React.memo(var1)
