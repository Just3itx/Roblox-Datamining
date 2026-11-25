-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent
local React = require(VirtualEventsParent.React)

local PushUpsellPromptView = require(script.Parent.PushUpsellPromptView)
local usePushUpsellPromptViewModel = require(script.Parent.usePushUpsellPromptViewModel)

local function PushUpsellPromptContainer(arg1)
    local var1 = usePushUpsellPromptViewModel(arg1)
    return React.createElement(PushUpsellPromptView, var1)
end

return PushUpsellPromptContainer
