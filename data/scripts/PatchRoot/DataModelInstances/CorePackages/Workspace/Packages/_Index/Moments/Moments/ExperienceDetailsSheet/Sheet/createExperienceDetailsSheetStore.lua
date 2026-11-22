-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)

local _Types = require(script.Parent.Parent.Types)

local createSignal = Signals.createSignal

local function createExperienceDetailsSheetStore()
    local getIsOpen, var2 = createSignal(false)
    local getContext, var4 = createSignal(nil)

    return {
        getIsOpen = getIsOpen,
        getContext = getContext,
        open = function(arg1)
            var4(arg1)
            var2(true)
        end,
        close = function()
            var2(false)
        end
    }
end
return createExperienceDetailsSheetStore
