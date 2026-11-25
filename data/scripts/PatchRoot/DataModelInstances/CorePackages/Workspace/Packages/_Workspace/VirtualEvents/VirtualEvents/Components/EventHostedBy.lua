-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local Cryo = require(VirtualEvents.Parent.Cryo)
local React = require(VirtualEvents.Parent.React)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization
local EventHostName = require(VirtualEvents.Components.EventHostName)
local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)
local Foundation = require(VirtualEvents.Parent.Foundation)
local useCursor = Foundation.Hooks.useCursor

local Cell = UIBlox.App.Table.Cell
local CellHeadDetail = UIBlox.App.Table.CellHeadDetail
local CellTailDescription = UIBlox.App.Table.CellTailDescription
local useStyle = UIBlox.Core.Style.useStyle

local tbl1 = {
    size = UDim2.new(1, 0, 0, 52)
}

local function EventHostedBy(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2 = useStyle()
    local var3 = useLocalization({ hostedBy = "Feature.VirtualEvents.HostedByLabel" })

    local selectionCursor = useCursor(Foundation.Enums.CursorType.RoundedRect)

    local onActivated = React.useCallback(function()
        if var1.onActivated then
            var1.onActivated(var1.host)
        end
    end, { var1 })

    return React.createElement(Cell, {
        selectionCursor = selectionCursor,
        size = var1.size,
        userInteractionEnabled = true,
        horizontalPadding = 0,
        onActivated = onActivated,
        head = React.createElement(
            CellHeadDetail,
            {
                labelText = var3.hostedBy,
                labelTextColor = var2.Theme.TextDefault,
                labelTextFont = var2.Font.Body
            }
        ),
        tail = React.createElement(CellTailDescription, {
            text = "",
            renderTextOverride = function()
                return React.createElement(EventHostName, { host = var1.host })
            end,
            showArrow = true
        }),
        layoutWraps = true
    })
end

return EventHostedBy
