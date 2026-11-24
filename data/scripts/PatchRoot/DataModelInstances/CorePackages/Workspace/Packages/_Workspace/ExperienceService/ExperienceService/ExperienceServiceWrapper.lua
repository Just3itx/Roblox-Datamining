-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceService = game:GetService("ExperienceService")

local module = {}
function module.LaunchExperience(_, tbl1, source: string?, callback: ((...any) -> (...any))?)
    if source ~= nil then
        if callback ~= nil then
            ExperienceService:LaunchExperienceFromSourceWithCallback(tbl1, source, callback)
            return
        end
        ExperienceService:LaunchExperienceFromSource(tbl1, source)
    elseif callback ~= nil then
        ExperienceService:LaunchExperienceFromSourceWithCallback(tbl1, "", callback)
    else
        ExperienceService:LaunchExperience(tbl1)
    end
end

function module.RegisterForExperienceJoin(_, callback): RBXScriptConnection
    return (ExperienceService:RegisterForExperienceJoin(callback))
end

function module.RegisterForExperienceLeave(_, callback): RBXScriptConnection
    return (ExperienceService:RegisterForExperienceLeave(callback))
end

function module.LeaveExperienceWithReason(_, reason: string)
    if game:GetEngineFeature("ExperienceLeaveReasonEnabled") then
        ExperienceService:LeaveExperienceWithReason(reason)
    end
end

function module.ConsumePendingExperienceLeaveWithReason(_)
    if not game:GetEngineFeature("ExperienceLeaveReasonEnabled") then
        return nil
    end
    return ExperienceService:ConsumePendingExperienceLeaveWithReason()
end

function module.GetPendingJoinAttempt(_)
    return ExperienceService:GetPendingJoinAttempt()
end

function module.OnNewJoinAttempt(_): RBXScriptSignal
    return ExperienceService.OnNewJoinAttempt
end
return module
