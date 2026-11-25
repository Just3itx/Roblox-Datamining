-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local React = require(scriptParentParent.React)
local ExperienceService = require(scriptParentParent.ExperienceService)
local ToastNotificationWrapper = require(scriptParent.ToastNotificationWrapper)

local ExperienceService2 = ExperienceService.ExperienceService

return function(tbl1)
    local var1, var2 = React.useState(false)
    React.useEffect(function()
        ExperienceService2:RegisterForExperienceJoin(function()
            var2(true)
        end)
        ExperienceService2:RegisterForExperienceLeave(function()
            var2(false)
        end)
    end, {})

    return not var1
        and React.createElement(ToastNotificationWrapper, { displayOrder = tbl1.displayOrder, renderLocation = "universalApp" })
end
