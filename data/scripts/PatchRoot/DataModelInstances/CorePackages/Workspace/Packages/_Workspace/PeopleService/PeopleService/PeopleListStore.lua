-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Cryo = require(scriptParentParent.Cryo)
local Signals = require(scriptParentParent.Signals)

local createSignalMap = require(scriptParentParent.CoreScriptsRoactCommon).Utilities.createSignalMap

local createPersonStore = require(scriptParent.createPersonStore)
local PeopleUtility = require(scriptParent.PeopleUtility)

local GetFFlagPeoplePageEnablePersonSignalStore = require(scriptParent.Flags).GetFFlagPeoplePageEnablePersonSignalStore

local function createPeopleListStore(arg1)
    local var1 = arg1 or game:GetService("Players")

    local players = var1:GetPlayers()

    local var2 = GetFFlagPeoplePageEnablePersonSignalStore() and {} or nil
    local signalMap = if GetFFlagPeoplePageEnablePersonSignalStore() then createSignalMap() else nil
    local var3 = PeopleUtility.sortPeople(players)

    local people, var5 = Signals.createSignal(var3)
    local peopleProfiles, var7 = Signals.createSignal({})

    local tbl1 = ({})
    local tbl2 = ({})

    local var8 = Cryo.List.map(var3, function(arg2)
        return arg2.UserId
    end)

    local function fetchProfiles(tbl3)
        local tbl4 = {}

        for _, value in tbl3 do
            local str1 = tostring(value)
            if not tbl1[str1] then
                table.insert(tbl4, str1)
            end
        end

        if #tbl4 > 0 then
            local inExperienceCombinedName = PeopleUtility.getInExperienceCombinedName(tbl4)

            tbl1 = Cryo.Dictionary.join(tbl1, inExperienceCombinedName)

            var7(tbl1)
        end
    end

    local function fetchPlatformData(tbl3)
        local tbl4 = {}

        for _, value in tbl3 do
            local str1 = tostring(value)
            if not tbl2[str1] then
                table.insert(tbl4, str1)
            end
        end

        if #tbl4 > 0 then
            local platformData = PeopleUtility.getPlatformData(tbl4)

            tbl2 = Cryo.Dictionary.join(tbl2, platformData)
        end
    end

    local var9 = GetFFlagPeoplePageEnablePersonSignalStore() and function(arg2)
        if var2[arg2.UserId] then
            return
        end

        local personStore = createPersonStore(arg2)
        var2[arg2.UserId] = personStore

        signalMap.setData(arg2.UserId, { getPerson = personStore.getPerson, getOrder = personStore.getOrder }, false)

        PeopleUtility.sortPersonStores(var2)
    end or nil

    local function addPerson(player: Player)
        if GetFFlagPeoplePageEnablePersonSignalStore() then
            var9(player)
        end

        local num1 = 1
        for value, value2 in var3 do
            if PeopleUtility.comparePeople(player, value2) then
                num1 = value
                break
            end

            num1 = value + 1
        end

        local var10

        if #var3 < num1 then
            var10 = Cryo.List.join(var3, { player })
        elseif GetFFlagPeoplePageEnablePersonSignalStore() and num1 == 1 then
            var10 = Cryo.List.join({ player }, var3)
        else
            var10 = Cryo.List.join(Cryo.List.getRange(var3, 1, num1 - 1), { player }, Cryo.List.getRange(var3, num1, #var3))
        end

        var3 = var10
        var5(var3)

        var8 = Cryo.List.join(var8, { player.UserId })

        fetchProfiles({ player.UserId })
        fetchPlatformData({ player.UserId })
    end

    local function removePerson(player: Player)
        if GetFFlagPeoplePageEnablePersonSignalStore() and var2[player.UserId] then
            var2[player.UserId] = nil
            signalMap.removeData(player.UserId, false)
        end

        local var10 = Cryo.List.filter(var3, function(arg2): boolean
            return arg2 ~= player
        end)

        if #var10 == #var3 then
            return
        end

        var3 = var10
        var5(var3)

        local userId = player.UserId
        var8 = Cryo.List.filter(var8, function(num1: number): boolean
            return num1 ~= userId
        end)

        local str1 = tostring(userId)
        tbl1[str1] = nil
        tbl2[str1] = nil
        var7(tbl1)
    end

    local function getProfile(num1: number)
        local str1 = tostring(num1)

        if not tbl1[str1] then
            fetchProfiles({ num1 })
        end

        return tbl1[str1]
    end

    local function getPlatformName(num1: number)
        local str1 = tostring(num1)

        if not tbl2[str1] then
            fetchPlatformData({ num1 })
        end

        return tbl2[str1].platformName
    end

    local function getPlatformProfileId(num1: number)
        local str1 = tostring(num1)
        if not tbl2[str1] then
            fetchPlatformData({ num1 })
        end

        return tbl2[str1].platformProfileId
    end

    fetchProfiles(var8)
    fetchPlatformData(var8)

    var1.PlayerAdded:Connect(addPerson)
    var1.PlayerRemoving:Connect(removePerson)

    if GetFFlagPeoplePageEnablePersonSignalStore() then
        for _, player in var1:GetPlayers() do
            var9(player)
        end
    end

    return {
        people = people,
        peopleSignalMap = if GetFFlagPeoplePageEnablePersonSignalStore() then signalMap else nil,
        peopleProfiles = peopleProfiles,
        getProfile = getProfile,
        getPlatformName = getPlatformName,
        getPlatformProfileId = getPlatformProfileId
    }
end

if GetFFlagPeoplePageEnablePersonSignalStore() then
    return createPeopleListStore
end
return (createPeopleListStore())
