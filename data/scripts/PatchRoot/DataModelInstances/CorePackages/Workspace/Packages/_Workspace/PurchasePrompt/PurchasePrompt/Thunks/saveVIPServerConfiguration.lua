-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local Network = require(PurchasePrompt.Services.Network)
local VIPServerRenamed = require(PurchasePrompt.Actions.VIPServerRenamed)
local Thunk = require(PurchasePrompt.Thunk)
local _types = require(PurchasePrompt.types)
local updateVIPServerConfiguration = require(PurchasePrompt.Network.updateVIPServerConfiguration)

local tbl1 = { Network }

local function saveVIPServerConfiguration(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local vipServerId = arg2:getState().promptRequest.vipServerId
        return updateVIPServerConfiguration(arg3[Network], vipServerId, arg1):andThen(function(str1: string?)
            if str1 ~= nil then
                arg2:dispatch(VIPServerRenamed(str1))
            end
        end)
    end)
end

return saveVIPServerConfiguration
