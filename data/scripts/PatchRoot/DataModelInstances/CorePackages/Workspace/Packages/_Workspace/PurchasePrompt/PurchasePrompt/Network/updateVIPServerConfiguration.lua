-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local Promise = require(PurchasePrompt.Promise)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local _types = require(PurchasePrompt.types)

local function expectField(str1: string, str2: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return function(arg1)
        if type(arg1) ~= "table" or type(arg1[str1]) ~= str2 then
            return Promise.reject(PurchaseError.UnknownFailure)
        end
        return arg1
    end
end

local function updateVIPServerConfiguration(arg1, num1: number, arg2)
    local tbl1 = {
        friendsAllowed = arg2.friendsAllowed
    }

    if #arg2.usersToAdd > 0 then
        local usersToAdd = {}
        for _, value in arg2.usersToAdd do
            table.insert(usersToAdd, tostring(value))
        end
        tbl1.usersToAdd = usersToAdd
    end

    local str1 = "friendsAllowed"
    local str2 = "boolean"

    local tbl2 = { arg1.updateVIPServerPermissions(num1, tbl1):andThen(expectField(str1, str2)) }

    local name = nil
    if arg2.name ~= nil then
        local var1 = arg1.updateVIPServer(num1, { name = arg2.name }):andThen((expectField("name", "string")))

        table.insert(tbl2, var1:andThen(function(arg3)
            name = arg3.name
        end))
    end

    return Promise.all(tbl2):andThen(function()
        return name
    end)
end

return updateVIPServerConfiguration
