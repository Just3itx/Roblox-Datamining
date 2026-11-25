-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")

local SocialUpsellParent = SocialUpsell.Parent

local Signals = require(SocialUpsellParent.Signals)

local _Types = require(SocialUpsell.Types)

local tbl1 = {
    overlayType = nil,
    overlayProps = {}
}

return function()
    local getCurrentOverlay, var2 = Signals.createSignal(table.clone(tbl1))
    return {
        getCurrentOverlay = getCurrentOverlay,
        setCurrentOverlay = function(overlayType, overlayProps)
            var2({ overlayType = overlayType, overlayProps = overlayProps })
        end,
        getCurrentOverlayType = Signals.createComputed(function(arg1)
            return getCurrentOverlay(arg1).overlayType
        end),
        dismissCurrentOverlay = function()
            var2(table.clone(tbl1))
        end
    }
end
