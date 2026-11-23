-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local SignalsReact = require(AppChatParent.SignalsReact)
local ViewRecycler = require(AppChatParent.ViewRecycler)

local MessageRow = require(script.Parent.MessageRow)

local MessageRowType = ViewRecycler.createRecyclableView(function(arg1) -- name: RecycledMessageRow
    local var1 = SignalsReact.useSignalState(arg1.itemSignal)
    return React.createElement(MessageRow, { key = var1.stable_key, item = var1 })
end, {
    readiness = ViewRecycler.RecyclableViewReadiness.ReadyOnCommit
})

local itemType = ViewRecycler.createRecyclableView(function() -- name: EndSpacer
    return React.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 10) })
end)
return {
    MessageRowType = MessageRowType,
    EndSpacerItem = ViewRecycler.createPinnedItem({ key = "EndSpacer", value = {}, itemType = itemType })
}
