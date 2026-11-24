-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local _createPresetChatStore = require(ExpChat.Stores.GetPresetChatStore.createPresetChatStore)
local Constants = require(ExpChat.PresetChat.Constants)
local whenFirstTrue = require(ExpChat.whenFirstTrue)

local tbl1 = ({})

local function whenPresetAccessKnown(arg1, func1: (...any) -> (...any))
    local var1 = nil
    local bool1 = false
    var1 = whenFirstTrue(function(arg2): boolean
        return not arg1.getIsLoading(arg2)
    end, function()
        bool1 = true
        if var1 then
            tbl1[var1] = nil
        end
        local var2 = arg1.getIsEnabled(false) and arg1.getAccessLevel(false) == Constants.AccessLevel.Enabled

        task.spawn(func1, var2)
    end)
    if not bool1 and var1 then
        tbl1[var1] = true
    end
end

return whenPresetAccessKnown
