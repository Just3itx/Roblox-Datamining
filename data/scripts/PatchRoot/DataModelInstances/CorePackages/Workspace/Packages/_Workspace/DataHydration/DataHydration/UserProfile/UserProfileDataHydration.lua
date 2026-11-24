-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local createDataCache = require(DataHydration.createDataCache)
local DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local Signals = require(DataHydrationParent.Signals)
local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId
local observeLocalPlayerUserId = require(DataHydration.DataHydrationUtils).observeLocalPlayerUserId

local num1 = game:DefineFastInt("UserProfileNamesRetryCount", 3)

local dataCache = createDataCache()

local tbl1 = ({})

local localPlayerUserId = getLocalPlayerUserId()
Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
    local localPlayerUserId2 = getLocalPlayerUserId()
    if localPlayerUserId2 ~= localPlayerUserId then
        localPlayerUserId = localPlayerUserId2
        table.clear(tbl1)
    end
end)

local var1 = nil
local tbl2 = ({})
local tbl3 = ({})

local num2 = 0

local function getNamesStatusCache()
    if var1 == nil then
        local dataCache2 = createDataCache(nil, nil, { observeLocalUser = false })
        var1 = dataCache2
        observeLocalPlayerUserId(function()
            num2 += 1
            table.clear(tbl2)
            table.clear(tbl3)
            dataCache2.clear()
        end)
    end
    return var1
end

local var2 = nil
local function getUserProfileStore() -- Luacid: Inlined by compiler; 7 call sites recovered
    var2 = var2 or require(DataHydrationParent.UserProfiles.Stores).UserProfileStore

    return var2
end

local function getProfileModel(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    return (getUserProfileStore().get().getProfileByUserId(str1))
end

local function getStatusAndFetch(str1: string)
    local var3, var4 = dataCache.getItem(str1)
    if var4 then
        getUserProfileStore().get().fetchNamesByUserIds({ str1 }, function(arg1)
            if arg1.status == "success" then
                dataCache.replaceItem(str1, true)
            elseif arg1.status == "failed" then
                dataCache.markItemsAsFailed({ str1 })
            end
        end)
    end
    return var3, var4
end

local function resolveUserProfileField(tbl4, str1: string, arg1)
    if str1 == "userId" then
        return tonumber(tbl4.userId)
    elseif str1 == "username" then
        return tbl4.names.getUsername(arg1)
    elseif str1 == "displayName" then
        return tbl4.names.getDisplayName(arg1)
    elseif str1 == "isVerified" then
        if tbl4.getIsVerified ~= nil then
            return (tbl4.getIsVerified(arg1))
        end

        return nil
    else
        return nil
    end
end

local function fetchNamesWithRetries(str1: string, num3: number, num4: number)
    if num4 ~= num2 then
        return
    end
    tbl3[str1] = true
    getUserProfileStore().get().fetchNamesByUserIds({ str1 }, function(arg1)
        if num4 ~= num2 then
            return
        end

        if arg1.status == "success" then
            tbl3[str1] = nil
            getNamesStatusCache().replaceItem(str1, true)
            return
        end

        if arg1.status ~= "failed" then
            return
        end

        if num3 < num1 then
            task.delay(2 ^ num3 + math.random(), fetchNamesWithRetries, str1, num3 + 1, num4)
            return
        end
        tbl3[str1] = nil
        getNamesStatusCache().markItemsAsFailed({ str1 })
    end)
end

local function getAndFetchUserNames(arg1)
    local str1 = tostring(arg1)
    local var3 = tbl2[str1]
    if var3 ~= nil then
        return var3
    end

    local status = Signals.createComputed(function(arg2)
        local var4, var5 = getNamesStatusCache().getItem(str1)
        if var5 and not tbl3[str1] then
            fetchNamesWithRetries(str1, 0, num2)
        end
        return var4.status(arg2)
    end)

    local tbl4 = {
        names = Signals.createComputed(function(arg2)
            if status(arg2) ~= DataHydrationTypes.DataStatus.Ready then
                return nil
            end

            local var4 = getProfileModel(str1)

            if var4 == nil then
                return nil
            end

            return {
                combinedName = var4.names.getCombinedName(arg2),
                username = var4.names.getUsername(arg2)
            }
        end),
        status = status
    }

    tbl2[str1] = tbl4
    return tbl4
end

local function nonEmpty(str1: string?): string? -- Luacid: Inlined by compiler; 2 call sites recovered
    return if str1 == "" then nil else str1
end

return {
    resolveField = function(_: string, tbl4, str1: string, arg1, _: boolean?)
        if #tbl4 < 2 then
            return nil, nil
        end

        local str2 = tostring(str1)
        local var3 = getStatusAndFetch(str2).status(arg1)

        if var3 ~= DataHydrationTypes.DataStatus.Ready then
            return nil, var3
        end

        local var4 = getProfileModel(str2)

        if not var4 then
            return nil, var3
        end

        local var5 = tbl4[2]
        return resolveUserProfileField(var4, var5, arg1), var3
    end,
    updateFromHydration = function(tbl4)
        getUserProfileStore().get().updateFromHydration(tbl4)

        local tbl5 = ({})
        for value, value2 in tbl4 do
            if value2.userId ~= nil then
                value = tostring(value2.userId)
            end

            tbl5[value] = true
        end
        dataCache.replaceItems(tbl5)
    end,
    getAndFetchUserInfo = function(arg1)
        local str1 = tostring(arg1)
        local var3 = tbl1[str1]
        if var3 ~= nil then
            return var3
        end

        local status = Signals.createComputed(function(arg2)
            return getStatusAndFetch(str1).status(arg2)
        end)

        local tbl4 = {
            info = Signals.createComputed(function(arg2): {displayName: any, hasVerifiedBadge: number, userId: number?, username: any}?
                if status(arg2) ~= DataHydrationTypes.DataStatus.Ready then
                    return nil
                end

                local var4 = getProfileModel(str1)

                if var4 == nil then
                    return nil
                end
                return {
                    userId = tonumber(str1),
                    displayName = var4.names.getDisplayName(arg2),
                    username = var4.names.getUsername(arg2),
                    hasVerifiedBadge = not (var4.getIsVerified == nil) and var4.getIsVerified(arg2)
                }
            end),
            status = status
        }

        tbl1[str1] = tbl4
        return tbl4
    end,
    getAndFetchUserNames = getAndFetchUserNames,
    getAndFetchUserNamesByUserIds = function(tbl4)
        local tbl5 = ({})
        for _, value in tbl4 do
            if tonumber(value) ~= nil then
                tbl5[value] = getAndFetchUserNames(value)
            end
        end

        return Signals.createComputed(function(arg1)
            local ready = DataHydrationTypes.DataStatus.Ready
            local namesByUserId = ({})
            for value, value2 in tbl5 do
                local var3 = value2.status(arg1)
                if var3 == DataHydrationTypes.DataStatus.NotReady then
                    ready = DataHydrationTypes.DataStatus.NotReady
                elseif var3 == DataHydrationTypes.DataStatus.Failed and ready == DataHydrationTypes.DataStatus.Ready then
                    ready = DataHydrationTypes.DataStatus.Failed
                end

                local var4 = value2.names(arg1)
                if not var4 then
                    continue
                end

                local tbl7 = {
                    combinedName = nonEmpty(var4.combinedName),
                    username = nonEmpty(var4.username)
                }
                namesByUserId[value] = tbl7
            end

            return { status = ready, namesByUserId = namesByUserId }
        end)
    end
}
