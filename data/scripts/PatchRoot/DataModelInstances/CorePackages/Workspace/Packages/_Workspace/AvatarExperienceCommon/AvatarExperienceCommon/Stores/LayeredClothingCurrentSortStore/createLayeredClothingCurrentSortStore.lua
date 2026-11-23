-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local Cryo = require(AvatarExperienceCommonParent.Cryo)
local _Signals = require(AvatarExperienceCommonParent.Signals)
local SignalsExperimental = require(AvatarExperienceCommonParent.SignalsExperimental)
local createSessionScopedSignal = require(AvatarExperienceCommonParent.SignalsUtils).createSessionScopedSignal

local function createEmptyOrderedList() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {}
end

local function createEmptyRemovedList() -- Luacid: Inlined by compiler; 3 call sites recovered
    return {}
end

local function alwaysNotifyEquals(_, _): boolean
    return false
end

local function createLayeredClothingCurrentSortStore()
    local getOrderedList, var2 = createSessionScopedSignal(createEmptyOrderedList, alwaysNotifyEquals)
    local getRemovedList, var4 = createSessionScopedSignal(createEmptyRemovedList)

    return {
        getOrderedList = getOrderedList,
        getRemovedList = getRemovedList,
        setCurrentSort = function(tbl1)
            if tbl1 == nil then
                return
            end
            var2(tbl1)
        end,
        clearCurrentSort = function()
            SignalsExperimental.batch(function()
                local emptyOrderedList = createEmptyOrderedList()
                var2(emptyOrderedList)
                local emptyRemovedList = createEmptyRemovedList()
                var4(emptyRemovedList)
            end)
        end,
        addRemovedItem = function(str1: string, str2: string?)
            local var5 = getRemovedList(false) or {}
            var4(Cryo.Dictionary.join(var5, { [str1] = str2 }))
        end,
        clearRemovedItems = function()
            local emptyRemovedList = createEmptyRemovedList()
            var4(emptyRemovedList)
        end,
        reset = function()
            SignalsExperimental.batch(function()
                local emptyOrderedList = createEmptyOrderedList()
                var2(emptyOrderedList)
                local emptyRemovedList = createEmptyRemovedList()
                var4(emptyRemovedList)
            end)
        end
    }
end

return createLayeredClothingCurrentSortStore
