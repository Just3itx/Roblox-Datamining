-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Signals = require(MomentsCreationParent.Signals)

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local GetFFlagMomentsCreationAccurateDirtyTracking = require(MomentsCreation.Flags.GetFFlagMomentsCreationAccurateDirtyTracking)

local createSignal = Signals.createSignal

local function draftsEqual(arg1, arg2)
    if arg1 == arg2 then
        return true
    end
    if type(arg1) ~= "table" or type(arg2) ~= "table" then
        return false
    end
    for value, value2 in arg1 do
        if arg2[value] ~= value2 then
            return false
        end
    end
    for value, value2 in arg2 do
        if arg1[value] ~= value2 then
            return false
        end
    end
    return true
end

local function createEditSession()
    local getDraft, var2 = createSignal(nil)
    local getIsDirty, var4 = createSignal(false)
    local var5 = nil

    return {
        getDraft = getDraft,
        getIsDirty = getIsDirty,
        begin = function(arg1)
            var5 = arg1
            var2(arg1)
            var4(false)
        end,
        update = function(arg1)
            var2(arg1)
            if GetFFlagMomentsCreationAccurateDirtyTracking then
                var4(not draftsEqual(arg1, var5))
                return
            end
            var4(true)
        end,
        commit = function()
            local var6 = getDraft(false)
            var5 = var6
            var4(false)
            return var6
        end,
        discard = function()
            var2(var5)
            var4(false)
        end
    }
end
return createEditSession
