-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Signals = require(AppChatParent.Signals)

local tbl1 = {
    overlayType = nil,
    overlayProps = {}
}

local function createOverlayStore()
    local getCurrentOverlay, var2 = Signals.createSignal(table.clone(tbl1))
    local getOverlayDefaultProps, setOverlayDefaultProps = Signals.createSignal({})

    return {
        getCurrentOverlay = getCurrentOverlay,
        showOverlay = function(overlayType: string, overlayProps)
            var2({ overlayType = overlayType, overlayProps = overlayProps })
        end,
        dismissOverlay = function()
            var2(table.clone(tbl1))
        end,
        getOverlayDefaultProps = getOverlayDefaultProps,
        setOverlayDefaultProps = setOverlayDefaultProps
    }
end

return createOverlayStore
