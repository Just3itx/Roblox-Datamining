-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local useSelector = require(VirtualEvents.Parent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization

local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local EmptyState = UIBlox.App.Indicator.EmptyState

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

local function EventNotFoundModal(tbl1)
    local var1 = useSelector(selectScreenSize)

    local var2 = useLocalization({ notFound = "Feature.VirtualEvents.EventNotFound" })

    return React.createElement(PartialPageModal, {
        position = UDim2.fromScale(0.5, 0.5),
        anchorPoint = Vector2.new(0.5, 0.5),
        screenSize = var1 - Vector2.new(40, 0),
        contentPadding = UDim.new(0, 24),
        onCloseClicked = tbl1.onClose
    }, {
        Wrapper = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            },
            {
                Padding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 80), PaddingBottom = UDim.new(0, 20) }),
                EventNotFound = React.createElement(EmptyState, { text = var2.notFound })
            }
        )
    })
end

return EventNotFoundModal
