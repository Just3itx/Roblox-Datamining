-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent

local Signal = require(AmpUpsellParent.AppCommonLib).Signal
local _Types = require(script.Parent.Types)

local signal = Signal.new()

return {
    requestOpen = function(params): boolean
        local tbl1 = { params = params, handled = false }

        signal:fire(tbl1)
        return tbl1.handled
    end,
    subscribe = function(callback: (...any) -> (...any))
        return signal:connect(function(tbl1)
            if tbl1.handled then
                return
            end
            tbl1.handled = true
            callback(tbl1.params)
        end)
    end
}
