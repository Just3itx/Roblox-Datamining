-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PioneerUtils = script:FindFirstAncestor("PioneerUtils")
local PioneerUtilsParent = PioneerUtils.Parent

local ExperienceService = require(PioneerUtilsParent.ExperienceService).ExperienceService
local _PioneerLeaveReason = require(PioneerUtils.PioneerLeaveReason)

local function leaveExperience(arg1)
    ExperienceService:LeaveExperienceWithReason(arg1)
end

return leaveExperience
