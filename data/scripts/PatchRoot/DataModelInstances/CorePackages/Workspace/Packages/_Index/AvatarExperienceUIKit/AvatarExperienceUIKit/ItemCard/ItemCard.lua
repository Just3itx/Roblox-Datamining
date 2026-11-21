-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKit = script:FindFirstAncestor("AvatarExperienceUIKit")
local AvatarExperienceUIKitParent = AvatarExperienceUIKit.Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local UIBlox = require(AvatarExperienceUIKitParent.UIBlox)
local useSelectionCursor = UIBlox.App.SelectionImage.useSelectionCursor
local CursorKind = UIBlox.App.SelectionImage.CursorKind
local _BackgroundLayers = require(AvatarExperienceUIKit.BackgroundLayers.BackgroundLayers)
local ItemCardBackgroundsWrapper = require(script.Parent.ItemCardBackgroundsWrapper)

return (React.forwardRef(function(tbl1, ref)
    local selectionImageObject = useSelectionCursor(CursorKind.RoundedRect)
    local var2 = useTokens()
    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl2 = {
        Selectable = tbl1.Selectable,
        SelectionImageObject = selectionImageObject,
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        [React.Event.Activated] = if tbl1.isDisabled then nil else tbl1.onActivated,
        ref = ref,
        Size = tbl1.Size,
        AutomaticSize = tbl1.AutomaticSize,
        LayoutOrder = tbl1.LayoutOrder,
        SelectionGroup = true,
        [React.Change.AbsoluteSize] = tbl1.onAbsoluteSizeChanged,
        [React.Tag] = tbl1.tag
    }
    local tbl3

    if tbl1.backgroundLayers ~= nil and #tbl1.backgroundLayers > 0 then
        tbl3 = {
            BackgroundsWrapper = React.createElement(ItemCardBackgroundsWrapper, {
                backgroundLayers = tbl1.backgroundLayers,
                imageScaleType = tbl1.imageScaleType,
                headerSlot = tbl1.headerSlot,
                footerSlot = tbl1.footerSlot
            }),
            SelectedBorder = if tbl1.showSelectionBorderWithBackground then React.createElement(
                View,
                {
                    tag = "size-full stroke-standard stroke-system-contrast radius-medium",
                    testId = "card-selection-stroke",
                    ZIndex = 2
                }
            ) else nil
        }
    else
        tbl3 = {
            ItemCardListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Padding = UDim.new(0, var2.Gap.Small)
            }),
            ItemCardHeaderSlot = tbl1.headerSlot,
            ItemCardFooterSlot = tbl1.footerSlot
        }
    end

    return createElement(str1, tbl2, tbl3)
end))
