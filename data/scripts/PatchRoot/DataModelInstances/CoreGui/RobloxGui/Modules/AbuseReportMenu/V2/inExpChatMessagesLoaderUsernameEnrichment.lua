-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Promise = require(CorePackages.Packages.Promise)
local UserProfileStore = require(CorePackages.Workspace.Packages.UserProfiles).Stores.UserProfileStore

local function collectUserIdsMissingUsername(arg1)
    local tbl1 = ({})
    local result = {}

    for _, value in arg1 do
        for _, item in value.items do
            local meta = item.meta
            local userId = meta and meta.userId
            local username = meta and meta.username
            if userId and userId ~= "0" and (not username or username == "") and not tbl1[userId] then
                tbl1[userId] = true
                table.insert(result, userId)
            end
        end
    end

    return result
end

local function enrichGroupsWithProfileUsernames(arg1, arg2)
    local tbl1 = {}

    for _, value in arg2 do
        local username = value.names.getUsername(false)
        if username and #username > 0 then
            tbl1[value.userId] = username
        end
    end

    for _, value in arg1 do
        for _, item in value.items do
            local meta = item.meta
            if not meta or meta.username and meta.username ~= "" then
                continue
            end

            local username = tbl1[meta.userId]
            if username then
                meta.username = username
            end
        end
    end
end

return {
    collectUserIdsMissingUsername = collectUserIdsMissingUsername,
    enrichGroupsWithProfileUsernames = enrichGroupsWithProfileUsernames,
    enrichMissingUsernames = function(arg1)
        local tbl1 = collectUserIdsMissingUsername(arg1)
        if #tbl1 == 0 then
            return Promise.resolve(arg1)
        end

        return Promise.new(function(callback)
            UserProfileStore.get().fetchNamesByUserIds(tbl1, function(arg2)
                if arg2.status == "success" and arg2.data then
                    enrichGroupsWithProfileUsernames(arg1, arg2.data)
                    callback(arg1)
                elseif arg2.status == "failed" then
                    callback(arg1)
                end
            end)
        end)
    end
}
