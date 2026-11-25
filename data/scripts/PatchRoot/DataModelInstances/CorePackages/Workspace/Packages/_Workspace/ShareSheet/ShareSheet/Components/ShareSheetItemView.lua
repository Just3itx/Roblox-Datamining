-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local Foundation = require(ShareSheetParent.Foundation)
local Motion = require(ShareSheetParent.Motion)
local React = require(ShareSheetParent.React)
local UserTile = require(ShareSheetParent.UserTile)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant
local usePreferences = Foundation.Hooks.usePreferences
local useTokens = Foundation.Hooks.useTokens
local UserTile2 = UserTile.UserTile
local LayoutMode = UserTile.LayoutMode

local FFlagShareSheetDesktopReadiness = require(ShareSheet.Flags.FFlagShareSheetDesktopReadiness)

local function AnimatedIcon(tbl1)
    local var1 = useTokens()
    local reducedMotion = usePreferences().reducedMotion
    local var2 = React.useMemo(function()
        return {
            compressed = Motion.createState({ scale = 0.75 }, { default = Motion.transition({ duration = 0 }) }),
            rest = Motion.createState({ scale = 1 }, {
                default = Motion.transition({ duration = if reducedMotion then 0 else var1.Time.Time_300, easingStyle = var1.Ease.ExpressiveOut })
            })
        }
    end, { reducedMotion, var1 })
    local var3, var4 = Motion.useMotion(var2.rest)

    React.useEffect(function()
        if not tbl1.shouldAnimate then
            return
        end

        var4(var2.compressed, {
            onAnimationComplete = function(arg1)
                if arg1 == true then
                    var4(var2.rest)
                end
            end
        })
    end, { var4, tbl1.shouldAnimate, var2 })

    return React.createElement(
        View,
        {
            scale = var3.scale,
            tag = "auto-xy"
        },
        {
            Icon = React.createElement(Icon, { name = tbl1.icon, size = IconSize.Large })
        }
    )
end

local function ShareSheetItemView(tbl1)
    local var1 = useTokens()
    local offset = if FFlagShareSheetDesktopReadiness then UDim2.fromOffset(tbl1.width, tbl1.width) else nil
    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        tag = {
            ["col align-x-center gap-small auto-y"] = true,
            ["size-1700-0"] = not FFlagShareSheetDesktopReadiness
        },
        Size = if FFlagShareSheetDesktopReadiness then UDim2.fromOffset(tbl1.width, 0) else nil,
        LayoutOrder = tbl1.LayoutOrder,
        testId = "share-sheet-item-view"
    }
    local tbl3 = { Content = 0, Label = 0 }
    local element

    if tbl1.primaryUserId then
        local createElement2 = React.createElement
        local var3 = View
        local tbl4 = {
            tag = {
                ["size-full-1700"] = not FFlagShareSheetDesktopReadiness
            },
            Size = offset,
            LayoutOrder = 1,
            testId = if tbl1.secondUserId then "share-sheet-item-avatar-pile" else "share-sheet-item-avatar"
        }
        local tbl5 = {
            Tile = React.createElement(UserTile2, {
                userId = tbl1.primaryUserId,
                facePileSecondUserId = tbl1.secondUserId,
                layoutMode = LayoutMode.compact,
                userPresenceType = tbl1.userPresence,
                onActivated = tbl1.onActivated,
                selectable = true
            }),
            SelectionIndicator = 0
        }
        local element2

        if tbl1.isSelected then
            element2 = React.createElement(Icon, {
                name = IconName.CircleCheck,
                size = IconSize.Small,
                variant = IconVariant.Filled,
                style = var1.Color.System.Contrast,
                Position = UDim2.fromScale(0.8536, 0.1464),
                AnchorPoint = Vector2.new(0.5, 0.5),
                ZIndex = 4,
                testId = "share-sheet-item-selection-indicator"
            })
        else
            element2 = nil
        end

        tbl5.SelectionIndicator = element2
        element = createElement2(var3, tbl4, tbl5)
    else
        element = React.createElement(
            View,
            {
                tag = {
                    ["align-x-center align-y-center radius-circle bg-shift-300"] = true,
                    ["size-full-1700"] = not FFlagShareSheetDesktopReadiness
                },
                Size = offset,
                LayoutOrder = 1,
                testId = "share-sheet-item",
                onActivated = tbl1.onActivated,
                selection = { Selectable = true }
            },
            {
                IconContent = React.createElement(AnimatedIcon, { icon = tbl1.icon, shouldAnimate = tbl1.shouldAnimate })
            }
        )
    end

    tbl3.Content = element

    tbl3.Label = React.createElement(FoundationText, {
        tag = "size-full-0 auto-y text-body-small text-align-x-center content-default",
        Text = tbl1.label,
        TextTruncate = Enum.TextTruncate.AtEnd,
        LayoutOrder = 2
    })
    return createElement(var2, tbl2, tbl3)
end

return ShareSheetItemView
