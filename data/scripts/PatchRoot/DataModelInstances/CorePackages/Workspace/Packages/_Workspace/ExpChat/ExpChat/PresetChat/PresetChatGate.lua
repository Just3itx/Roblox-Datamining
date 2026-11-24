-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local React = require(ExpChatParent.React)

local _Constants = require(script.Parent.Constants)
local useLayoutMode = require(script.Parent.useLayoutMode)
local usePresetSurfaceAvailable = require(script.Parent.usePresetSurfaceAvailable)

return React.memo(function(tbl1) -- name: PresetChatGate
    local var1 = usePresetSurfaceAvailable(tbl1.targetTextChannel)
    local var2 = useLayoutMode()
    if not var1 or tbl1.layoutMode ~= nil and var2 ~= tbl1.layoutMode then
        return nil
    end

    return React.createElement(React.Fragment, nil, tbl1.children)
end)
