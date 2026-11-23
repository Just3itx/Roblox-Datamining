-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local useLayerCollector = require(AppChatParent.UIBlox).Core.Layout.LayerCollector.useLayerCollector

local num1 = game:DefineFastInt("AppChatVerticalConstraintThreshold", 300)

return function(): boolean
    return useLayerCollector().absoluteSize.Y <= num1
end
