-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local SetPromptState = require(scriptParentParent.Actions.SetPromptState)
local PromptState = require(scriptParentParent.Enums.PromptState)
local PlatformInterface = require(scriptParentParent.Services.PlatformInterface)
local Thunk = require(scriptParentParent.Thunk)

local tbl1 = { PlatformInterface }

local function openRobuxStore()
    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        local var1 = arg2[PlatformInterface]

        arg1:dispatch(SetPromptState(PromptState.UpsellInProgress))
        var1.openRobuxStore()
    end)
end

return openRobuxStore
