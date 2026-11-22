-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local _MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)

local MomentContext = require(script.Parent.Parent.Parent.Parent.MomentContext)
local useReactionCommit = require(script.Parent.Parent.Parent.Parent.Reactions.useReactionCommit)
local PickerItem = require(script.Parent.PickerItem)
local usePickerReactions = require(script.Parent.usePickerReactions)

local View = Foundation.View

return React.memo(function() -- name: ReactionPicker
    local store = MomentContext.useMoment().store

    local var1 = useReactionCommit()
    local var2 = usePickerReactions()

    local onSelect = React.useCallback(function(arg1, vector2: Vector2?)
        var1("pickerSelect", vector2, arg1)
        store.setReactionPickerOpen(false)
    end, { store.setReactionPickerOpen, var1 })

    local tbl1 = {}
    for index, reaction in var2 do
        tbl1[`reaction_{reaction}`] = React.createElement(PickerItem, { reaction = reaction, index = index, onSelect = onSelect })
    end

    return React.createElement(
        View,
        { tag = "row align-x-center align-y-center gap-medium size-0-1400 auto-x padding-x-large" },
        tbl1
    )
end)
