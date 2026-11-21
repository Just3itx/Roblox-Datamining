-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local AuthCommonParent = AuthCommon.Parent
local GetUserAppLaunchInfo = require(AuthCommon.Http.Requests.GetUserAppLaunchInfo)
local Promise = require(AuthCommonParent.Promise)
local AppStorageService = game:GetService("AppStorageService")

return function(arg1)
    local _, var1 = Promise.new(function(callback)
        GetUserAppLaunchInfo(arg1):andThen(function(arg2)
            if arg2 and arg2.responseBody then
                local name = arg2.responseBody.name
                local str1 = tostring(arg2.responseBody.id)
                AppStorageUtilities.setIncompleteSignupUserId(str1)
                AppStorageUtilities.setIncompleteSignupUsername(name)
                AppStorageService:Flush()
            end
            callback(true)
        end):catch(function(_)
            callback(false)
        end)
    end):await()
    return var1
end
