-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PioneerUtils = script:FindFirstAncestor("PioneerUtils")
local PioneerUtilsParent = PioneerUtils.Parent

local Fetch = require(PioneerUtilsParent.Fetch)
local fetch = Fetch.fetch
local Response = Fetch.Response
local Promise = require(PioneerUtilsParent.Promise)
local Url = require(PioneerUtilsParent.Http).Url
local PioneerLeaveReason = require(PioneerUtils.PioneerLeaveReason)
local isPioneerLaunch = require(PioneerUtils.isPioneerLaunch)
local leaveExperience = require(PioneerUtils.leaveExperience)

local str1 = string.format("%s/users/authenticated/app-launch-info", Url.USERS_URL)

local function fetchIsConfirmedThirteenPlus() -- Luacid: Inlined by compiler; 1 call site recovered
    return Promise.new(function(callback)
        local var1 = fetch(str1, { method = "GET" }):catch(function()
            return Response.error()
        end):expect()

        if not var1.ok then
            callback(false)
            return
        end

        local var2 = var1:json():catch(function()
            return nil
        end):expect()

        callback(typeof(var2) == "table" and typeof(var2.ageBracket) == "number" and var2.ageBracket ~= 1)
    end)
end

local function maybeLeavePioneerOnFaeDownAge(bool1: boolean, callback: ((...any) -> (...any))?)
    local function stay() -- Luacid: Inlined by compiler; 3 call sites recovered
        if callback then
            callback()
        end
    end

    if not isPioneerLaunch() then
        stay()
        return
    end

    if not bool1 then
        stay()
        return
    end

    return fetchIsConfirmedThirteenPlus():andThen(function(arg1): boolean
        if arg1 then
            stay()
        else
            leaveExperience(PioneerLeaveReason.AccountUnder13)
        end
        return not arg1
    end)
end

return maybeLeavePioneerOnFaeDownAge
