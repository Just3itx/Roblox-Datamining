-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local React = require(ShareSheetParent.React)
local Foundation = require(ShareSheetParent.Foundation)

local FFlagShareSheetDesktopReadiness = require(ShareSheet.Flags.FFlagShareSheetDesktopReadiness)
local FFlagShareSheetScrollArrows = require(ShareSheet.Flags.FFlagShareSheetScrollArrows)
local ShareSheetRowWithScrollArrows = require(script.Parent.ShareSheetRowWithScrollArrows)

local ScrollView = Foundation.ScrollView
local Visibility = Foundation.Enums.Visibility
local useTokens = Foundation.Hooks.useTokens

local function ShareSheetRow(tbl1)
    if FFlagShareSheetScrollArrows and not FFlagShareSheetDesktopReadiness then
        return React.createElement(ShareSheetRowWithScrollArrows, tbl1)
    end

    local var1 = useTokens()
    local offset = if FFlagShareSheetDesktopReadiness then tbl1.margin else var1.Padding.XLarge
    return React.createElement(ScrollView, {
        tag = "size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder,
        padding = {
            left = UDim.new(0, offset),
            right = UDim.new(0, offset)
        },
        scroll = {
            AutomaticSize = Enum.AutomaticSize.Y,
            AutomaticCanvasSize = Enum.AutomaticSize.X,
            CanvasSize = UDim2.fromScale(0, 0),
            ScrollingDirection = Enum.ScrollingDirection.X,
            ScrollingEnabled = if FFlagShareSheetDesktopReadiness then tbl1.isScrollingEnabled else nil,
            scrollBarVisibility = Visibility.None
        },
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, if FFlagShareSheetDesktopReadiness then tbl1.gap else var1.Padding.Medium)
        }
    }, tbl1.children)
end

return ShareSheetRow
