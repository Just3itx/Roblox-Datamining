-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local _FunnelEventNames = require(MomentsCommon.Analytics.FunnelEventNames)

local tbl1 = ({})

return {
    startSession = function(arg1)
        local str1 = HttpService:GenerateGUID()
        tbl1[arg1] = str1
        return str1
    end,
    getSessionId = function(arg1)
        return tbl1[arg1]
    end,
    endSession = function(arg1): boolean
        if not tbl1[arg1] then
            return false
        end

        tbl1[arg1] = nil
        return true
    end
}
