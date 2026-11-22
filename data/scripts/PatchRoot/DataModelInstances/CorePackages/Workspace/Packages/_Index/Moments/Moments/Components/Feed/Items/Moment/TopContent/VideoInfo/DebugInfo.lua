-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local MomentContext = require(script.Parent.Parent.Parent.MomentContext)
local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)

local TextInput = Foundation.TextInput
local View = Foundation.View
local InputSize = Foundation.Enums.InputSize

local useSignalState = SignalsReact.useSignalState

local function noop() end

return React.memo(function(tbl1) -- name: DebugInfo
    local momentsPreferencesStore = GetMomentsPreferencesStore(false)
    local var1 = useSignalState(momentsPreferencesStore.getDebugModeEnabled)
    local var2 = MomentContext.useMoment()

    if not var1 then
        return nil
    end

    local feedItemId = var2.store.getData(false).feedItemId or ""

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "col align-x-left gap-small size-full-0 auto-y"
        },
        {
            DebugMomentId = React.createElement(TextInput, {
                label = "momentId",
                LayoutOrder = 1,
                onChanged = noop,
                size = InputSize.Medium,
                text = var2.momentId,
                width = UDim.new(1, 0)
            }),
            DebugFeedItemId = React.createElement(TextInput, {
                label = "feedItemId",
                LayoutOrder = 2,
                onChanged = noop,
                size = InputSize.Medium,
                text = feedItemId,
                width = UDim.new(1, 0)
            })
        }
    )
end)
