-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayabilityRoduxParent = script:FindFirstAncestor("PlayabilityRodux").Parent
local PlayabilityStatusEnum = require(PlayabilityRoduxParent.DiscoveryTypes).PlayabilityStatusEnum
local FFlagLuaAppPlayableUxTreatment = require(PlayabilityRoduxParent.SharedFlags).FFlagLuaAppPlayableUxTreatment
local FFlagLuaAppPlayButtonPrivatePT = require(PlayabilityRoduxParent.SharedFlags).FFlagLuaAppPlayButtonPrivatePT

local Result = require(PlayabilityRoduxParent.Result)

local module = {}

function module.new()
    return {}
end

function module.mock()
    local module2 = module.new()
    module2.universeId = "149757"
    module2.isPlayable = true
    module2.playabilityStatus = PlayabilityStatusEnum.Playable

    return module2
end

function module.fromJsonData(arg1)
    if type(arg1.universeId) ~= "number" and type(arg1.universeId) ~= "string" then
        return Result.error("PlayabilityStatus.fromJsonData expects universeId to be a number or a string")
    end
    if type(arg1.isPlayable) ~= "boolean" then
        return Result.error("PlayabilityStatus.fromJsonData expects isPlayable to be a boolean")
    end
    if type(arg1.playabilityStatus) ~= "string" then
        return Result.error("PlayabilityStatus.fromJsonData expects playabilityStatus to be a string")
    end

    local module2 = module.new()
    module2.universeId = tostring(arg1.universeId)
    module2.isPlayable = arg1.isPlayable
    module2.playabilityStatus = arg1.playabilityStatus
    module2.unplayableDisplayText = arg1.unplayableDisplayText

    if type(arg1.demoModeAvailable) == "boolean" then
        module2.demoModeAvailable = arg1.demoModeAvailable
    end

    if FFlagLuaAppPlayButtonPrivatePT then
        local privatePlaytestInfo = arg1.privatePlaytestInfo
        if type(privatePlaytestInfo) == "table" and type(privatePlaytestInfo.isPlayable) == "boolean" then
            module2.privatePlaytestInfo = {
                isPlayable = privatePlaytestInfo.isPlayable,
                playabilityStatus = privatePlaytestInfo.playabilityStatus
            }
        end
    end

    if FFlagLuaAppPlayableUxTreatment then
        local playableUxTreatment = arg1.playableUxTreatment
        if playableUxTreatment and type(playableUxTreatment) == "table" and type(playableUxTreatment.treatment) == "string" then
            module2.playableUxTreatment = {
                treatment = playableUxTreatment.treatment,
                data = playableUxTreatment.data
            }
        end
    end

    return Result.success(module2)
end

return module
