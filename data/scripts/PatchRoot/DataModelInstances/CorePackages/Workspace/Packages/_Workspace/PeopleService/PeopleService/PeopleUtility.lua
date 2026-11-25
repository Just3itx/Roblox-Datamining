-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local UserProfiles = require(scriptParentParent.UserProfiles)

local sortTableByValue = require(scriptParentParent.CoreScriptsRoactCommon).Utilities.sortTableByValue

local _createPersonStore = require(scriptParent.createPersonStore)

local GetFFlagPeoplePageEnablePersonSignalStore = require(scriptParent.Flags).GetFFlagPeoplePageEnablePersonSignalStore
local FFlagUserProfilePlatformProfile = require(scriptParentParent.SharedFlags).FFlagUserProfilePlatformProfile

local _success, result = pcall(function(): PlatformFriendsService
    return game:GetService("PlatformFriendsService")
end)

local UserProfileStore = UserProfiles.Stores.UserProfileStore

local function canShowPlatformProfile(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetEngineFeature("PlatformFriendsService")
        and game:GetEngineFeature("PlatformFriendsProfile")
        and result
        and result:IsProfileEnabled()
        and str1
        and str1 ~= ""
end

local function comparePeople(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local localPlayer = Players.LocalPlayer

    local var1 = arg1.Name:lower()
    local var2 = arg2.Name:lower()

    return (if arg1 == localPlayer then " " else var1) < (if arg2 == localPlayer then " " else var2)
end

local var1 = GetFFlagPeoplePageEnablePersonSignalStore() and function(tbl1)
    for value, value2 in (sortTableByValue(tbl1, function(arg1, arg2): boolean
        return (comparePeople(arg1.value.getPerson(), (arg2.value.getPerson())))
    end)) do
        local var1 = tbl1[value2.key]
        if var1 then
            var1.setOrder(value)
        end
    end
end or nil

local function showPersonButtons(arg1, num1: number?): boolean
    local localPlayer = Players.LocalPlayer
    return not (arg1 == nil or localPlayer == nil or arg1 == localPlayer or not (num1 > 0)) and localPlayer.UserId > 0
end

local tbl1 = {
    getInExperienceCombinedName = function(tbl1)
        local inExperienceCombinedName = {}

        for value, value2 in UserProfileStore.get().fetchNamesByUserIds(tbl1)(false).data do
            inExperienceCombinedName[tbl1[value]] = value2.names.getInExperienceCombinedName
        end

        return inExperienceCombinedName
    end,
    getPlatformData = function(tbl1)
        local platformData = ({})

        for value, value2 in UserProfileStore.get().fetchNamesByUserIds(tbl1, nil, FFlagUserProfilePlatformProfile)(false).data do
            local var2 = tbl1[value]
            platformData[var2] = {
                platformName = value2.names.getPlatformName,
                platformProfileId = value2.getPlatformProfileId
            }
        end

        return platformData
    end,
    canShowPlatformProfile = canShowPlatformProfile,
    showPlatformProfile = function(str1: string)
        if canShowPlatformProfile(str1) then
            result:ShowProfile(str1)
        end
    end,
    comparePeople = comparePeople,
    sortPeople = function<T>(tbl1): {T}
        table.sort(tbl1, comparePeople)
        return tbl1
    end,
    sortPersonStores = 0,
    showPersonButtons = 0
}

if not GetFFlagPeoplePageEnablePersonSignalStore() then
    var1 = nil
end

tbl1.sortPersonStores = var1
tbl1.showPersonButtons = showPersonButtons
return tbl1
