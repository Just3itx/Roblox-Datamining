-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)

local Analytics = require(scriptParentParent.Analytics)

local getFIntUGCValidationPartMaxMass = require(scriptParentParent.flags.getFIntUGCValidationPartMaxMass)

local function resetPhysicsData(tbl1, arg1)
    local now = tick()

    if not game:GetEngineFeature("EngineResetCollisionFidelity") then
        return false, "EngineResetCollisionFidelity is not enabled"
    end

    local skipPhysicsDataReset = if arg1.bypassFlags then arg1.bypassFlags.skipPhysicsDataReset else false

    for _, value in tbl1 do
        local descendants = value:GetDescendants()
        table.insert(descendants, 1, value)
        for _, descendant in descendants do
            if not descendant:IsA("MeshPart") or skipPhysicsDataReset then
                continue
            end

            if not pcall(function()
                UGCValidationService:ResetCollisionFidelity(descendant, descendant.CollisionFidelity)
            end) then
                if arg1.isServer then
                    error("Failed to load mesh data")
                end
                Analytics.reportFailure(Analytics.ErrorType.resetPhysicsData_FailedToLoadMesh, nil, arg1)

                return false, "Failed to load mesh data"
            end

            if descendant:GetMass() > getFIntUGCValidationPartMaxMass() then
                Analytics.reportFailure(Analytics.ErrorType.resetPhysicsData_LargeMass, nil, arg1)
                return false, string.format(
                    "%s has a mass of %d while the limit is %d.",
                    descendant.Name,
                    descendant:GetMass(),
                    getFIntUGCValidationPartMaxMass()
                )
            end
        end
    end

    Analytics.recordScriptTime(script.Name, now, arg1)
    return true
end

return resetPhysicsData
