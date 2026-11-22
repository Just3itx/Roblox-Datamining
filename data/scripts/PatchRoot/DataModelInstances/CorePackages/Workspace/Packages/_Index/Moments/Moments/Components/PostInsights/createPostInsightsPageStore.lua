-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _MomentsTypes = require(MomentsParent.MomentsTypes)
local Signals = require(MomentsParent.Signals)

local _createMomentStore = require(Moments.Components.Feed.Items.Moment.createMomentStore)

local createSignal = Signals.createSignal

local function createPostInsightsPageStore()
    local getIsOpen, var2 = createSignal(false)

    local getContext, var4 = createSignal(nil)

    return {
        getIsOpen = getIsOpen,
        getContext = getContext,
        open = function(tbl1)
            var4(tbl1)
            var2(true)
        end,
        close = function()
            var2(false)
        end,
        reset = function()
            var2(false)
            var4(nil)
        end
    }
end
return createPostInsightsPageStore
