-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceModelParent = script:FindFirstAncestor("AvatarExperienceModel").Parent

local Signals = require(AvatarExperienceModelParent.Signals)
local SignalsExperimental = require(AvatarExperienceModelParent.SignalsExperimental)

local function createDefaultScalesRules()
    return {
        height = { min = 0.9, max = 1.05, increment = 0.01 },
        width = { min = 0.7, max = 1, increment = 0.01 },
        head = { min = 0.95, max = 1, increment = 0.01 },
        proportion = { min = 0, max = 1, increment = 0.01 },
        bodyType = { min = 0, max = 1, increment = 0.01 }
    }
end

local function createDefaultAccessoryRefinementTypes() -- Luacid: Inlined by compiler; 2 call sites recovered
    return { Enum.AssetType.Hat.Value, Enum.AssetType.FaceAccessory.Value }
end

local function createDefaultAdjustmentLimitRule(num1: number, num2: number, num3: number)
    return {
        position = { xPosition = num1, yPosition = num1, zPosition = num1 },
        rotation = { xRotation = num2, yRotation = num2, zRotation = num2 },
        scale = { xScale = num3, yScale = num3, zScale = num3 }
    }
end

local function createDefaultAccessoryRefinementLowerBounds() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        hat = createDefaultAdjustmentLimitRule(-0.25, -30, 0.8),
        faceAccessory = createDefaultAdjustmentLimitRule(-0.25, -30, 0.8)
    }
end

local function createDefaultAccessoryRefinementUpperBounds() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        hat = createDefaultAdjustmentLimitRule(0.25, 30, 1.2),
        faceAccessory = createDefaultAdjustmentLimitRule(0.25, 30, 1.2)
    }
end

local function createAvatarSettingsStore()
    local getObtainedAvatarRules, var2 = Signals.createSignal(false)
    local getMinDeltaBodyColorDifference, var4 = Signals.createSignal(0)
    local getScalesRules, var6 = Signals.createSignal((createDefaultScalesRules()))

    local getAccessoryRefinementTypes, var8 = Signals.createSignal((createDefaultAccessoryRefinementTypes()))

    local getAccessoryRefinementLowerBounds, var10 = Signals.createSignal((createDefaultAccessoryRefinementLowerBounds()))

    local getAccessoryRefinementUpperBounds, var12 = Signals.createSignal((createDefaultAccessoryRefinementUpperBounds()))

    return {
        getObtainedAvatarRules = getObtainedAvatarRules,
        getMinDeltaBodyColorDifference = getMinDeltaBodyColorDifference,
        getScalesRules = getScalesRules,
        getAccessoryRefinementTypes = getAccessoryRefinementTypes,
        getAccessoryRefinementLowerBounds = getAccessoryRefinementLowerBounds,
        getAccessoryRefinementUpperBounds = getAccessoryRefinementUpperBounds,
        setAvatarSettings = function(num1: number?, tbl1, tbl2, tbl3, tbl4)
            SignalsExperimental.batch(function()
                var2(true)
                var4(num1)
                var6(tbl1)
                var8(tbl2)
                var10(tbl3)
                var12(tbl4)
            end)
        end,
        reset = function()
            SignalsExperimental.batch(function()
                var2(false)
                var4(0)
                var6((createDefaultScalesRules()))
                var8((createDefaultAccessoryRefinementTypes()))
                var10((createDefaultAccessoryRefinementLowerBounds()))
                var12((createDefaultAccessoryRefinementUpperBounds()))
            end)
        end
    }
end

return createAvatarSettingsStore
