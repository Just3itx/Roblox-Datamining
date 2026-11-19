-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local _Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)
local UpdateChatSettings = require(script.Parent.Parent.Actions.UpdateChatSettings)
local ChatSettings = require(script.Parent.Parent.ChatSettings)

local function deepCopy(arg1)
    if type(arg1) ~= "table" then
        return arg1
    end

    local result = ({})
    for k, value in pairs(arg1) do
        result[k] = deepCopy(value)
    end
    return result
end

local function mergeInto(arg1, arg2)
    for k, value in pairs(arg2) do
        if type(value) ~= "table" then
            arg1[k] = value
        elseif arg1[k] then
            mergeInto(arg1[k], value)
        end
    end
end

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[UpdateChatSettings.name] = function(_, arg1)
    local var1 = deepCopy(ChatSettings)
    mergeInto(var1, arg1.settings)

    local userSpecificSettings = arg1.settings.UserSpecificSettings
    if userSpecificSettings then
        for k, userSpecificSetting in pairs(userSpecificSettings) do
            local var2 = deepCopy(ChatSettings)
            var2.UserSpecificSettings = nil
            mergeInto(var2, userSpecificSetting)
            var1.UserSpecificSettings[k] = var2
        end
    end

    return var1
end

return (createReducer(ChatSettings, tbl1))
