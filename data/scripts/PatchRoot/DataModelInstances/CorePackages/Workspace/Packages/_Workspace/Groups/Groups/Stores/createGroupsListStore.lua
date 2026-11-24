-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local Signals = require(GroupsParent.Signals)
local Cryo = require(GroupsParent.Cryo)

local _Types = require(Groups.Common.Types)
local GroupsWebApi = require(Groups.Networking.GroupsWebApi)

local tbl1 = { isLoading = false, loadFailure = false, groupsList = nil, canCreateGroup = true }

local function translateResultToGroup(arg1, str1: string)
    local group = arg1.group or {}
    local role = arg1.role or {}
    local rank = if role.rank then role.rank else 0
    local owner = group.owner
    local tbl2 = {
        id = if group.id then group.id else 0,
        name = group.name,
        memberCount = group.memberCount,
        role = {
            name = role.name,
            rank = rank
        },
        isPrimary = arg1.isPrimaryGroup or false,
        isOwner = if owner and owner.userId then tostring(owner.userId) == str1 else false,
        groupHasVerifiedBadge = group.hasVerifiedBadge or false,
        hasSocialModules = group.hasSocialModules or false,
        thumbnail = group.emblemUrl
    }
    return tbl2
end

local function compareNames(name: string, name2: string): boolean
    local str1 = string.lower(name)
    local str2 = string.lower(name2)

    local str3 = string.sub(str1, 1, 1)
    local str4 = string.sub(str2, 1, 1)
    local bool1 = str3 >= "a" and str3 <= "z"
    local bool2 = str4 >= "a" and str4 <= "z"
    return not (bool1 or not bool2) or not (bool1 and not bool2) and str1 < str2
end

local function sortGroups(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = table.clone(tbl2)
    table.sort(var1, function(arg1, arg2)
        local isOwner = arg1.isOwner or false
        local isOwner2 = arg2.isOwner or false
        local name = arg1.name or ""
        local name2 = arg2.name or ""

        if isOwner and isOwner2 then
            return (compareNames(name, name2))
        elseif isOwner then
            return true
        elseif isOwner2 then
            return false
        end

        return (compareNames(name, name2))
    end)
    return var1
end

local function getVisibleGroups(tbl2, arg1)
    if not (arg1 and arg1.groups) then
        return {}
    end

    local tbl3 = {}
    for _, value in ipairs(tbl2) do
        tbl3[value.id] = value
    end

    local visibleGroups = {}
    for _, group in ipairs(arg1.groups) do
        if not (group and group.canViewGroup and group.groupId) then
            continue
        end

        local var1 = tonumber(group.groupId)
        if var1 and tbl3[var1] then
            table.insert(visibleGroups, tbl3[var1])
        end
    end

    return visibleGroups
end

local function movePrimaryGroupToFront(tbl2)
    local var1 = nil

    for i, value in ipairs(tbl2) do
        if value.isPrimary then
            var1 = i
            break
        end
    end

    if not var1 then
        return tbl2
    end

    local result = {}
    table.insert(result, tbl2[var1])

    for i, value in ipairs(tbl2) do
        if i ~= var1 then
            table.insert(result, value)
        end
    end

    return result
end

local function deriveCanCreateGroup(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if not arg1 then
        return true
    end
    local groupLimit = arg1.groupLimit
    local currentGroupCount = arg1.currentGroupCount
    return not (groupLimit and currentGroupCount) or currentGroupCount < groupLimit
end

local function collectGroupIds(arg1)
    if not arg1 then
        return {}
    end
    local result = {}
    for _, value in ipairs(arg1) do
        if value.group and value.group.id then
            table.insert(result, value.group.id)
        end
    end
    return result
end

local function createGroupsListStore()
    local getState, var2 = Signals.createSignal(tbl1)

    local tbl2 = {}
    local tbl3 = {}

    local function cleanup()
        for _, value in tbl2 do
            value()
        end
        for _, value in tbl3 do
            value()
        end
        tbl2 = {}
        tbl3 = {}
    end

    return {
        getState = getState,
        fetchGroups = function(str1: string)
            cleanup()

            var2({ isLoading = true, loadFailure = false, groupsList = nil, canCreateGroup = true })

            local var3, var4 = GroupsWebApi.GetUserGroupsWithRoles(str1)
            local var5, var6 = GroupsWebApi.GetGroupsMetadata()
            table.insert(tbl3, var4)
            table.insert(tbl3, var6)

            local bool1 = false

            table.insert(tbl2, (Signals.createEffect(function(arg1)
                if bool1 then
                    return
                end

                local var7 = var3(arg1)
                if var7.status == "Loading" then
                    return
                elseif var7.status == "Failed" then
                    bool1 = true
                    var2({ isLoading = false, loadFailure = true, groupsList = nil, canCreateGroup = true })
                    return
                end

                local var8 = not (var7.data and var7.data.data) and {} or var7.data.data

                if #var8 == 0 then
                    bool1 = true
                    var2({ isLoading = false, loadFailure = false, groupsList = {}, canCreateGroup = true })

                    return
                end

                local tbl4 = collectGroupIds(var8)
                local var9, var10 = GroupsWebApi.GetGroupPolicies(tbl4)
                table.insert(tbl3, var10)

                table.insert(tbl2, (Signals.createEffect(function(arg2)
                    if bool1 then
                        return
                    end

                    local var11 = var9(arg2)
                    if var11.status == "Loading" then
                        return
                    end

                    local var12 = var5(arg2)
                    local data = if var12.status == "Success" then var12.data else nil
                    bool1 = true
                    local data2 = if var11.status == "Success" then var11.data else nil

                    local var13 = Cryo.List.map(var8, function(arg3)
                        return (translateResultToGroup(arg3, str1))
                    end)

                    local var14 = sortGroups(not data2 and {} or getVisibleGroups(var13, data2))

                    if #var14 == 0 then
                        var2({ isLoading = false, loadFailure = false, groupsList = {}, canCreateGroup = deriveCanCreateGroup(data) })

                        return
                    end

                    local groupsList = movePrimaryGroupToFront(var14)

                    var2({ isLoading = false, loadFailure = false, groupsList = groupsList, canCreateGroup = deriveCanCreateGroup(data) })
                end)))
            end)))
        end,
        reset = function()
            cleanup()
            var2(tbl1)
        end
    }
end
return createGroupsListStore
