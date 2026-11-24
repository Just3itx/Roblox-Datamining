-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceCloudPlay = script:FindFirstAncestor("InExperienceCloudPlay")
local InExperienceCloudPlayParent = InExperienceCloudPlay.Parent

local React = require(InExperienceCloudPlayParent.React)
local TransientUIOverlay = require(InExperienceCloudPlayParent.TransientUIOverlay)
local getCloudClientService = require(InExperienceCloudPlay.getCloudClientService)
local useSecondsLeft = require(InExperienceCloudPlay.Hooks.useSecondsLeft)
local useServiceProperty = require(InExperienceCloudPlay.Hooks.useServiceProperty)

local function RestyleTimeLimitSnackbar()
    local var1 = React.useMemo(getCloudClientService, {})
    local bool1 = useServiceProperty(var1, "IsRobloxRealityEnvironment") == true
    local var2 = useServiceProperty(var1, "SessionTimeLimit")
    local var3 = useSecondsLeft
    if not bool1 then
        var1 = nil
    end

    if typeof(var2) ~= "number" then
        var2 = nil
    end

    local var4 = var3(var1, var2)

    local var5 = React.useRef(false)
    local bool2 = not (var4 == nil or not (var4 > 0)) and var4 <= 60

    React.useEffect(function()
        if not bool2 or var5.current then
            return
        end

        var5.current = true
        TransientUIOverlay.displaySnackbar(
            { kind = "snackbar", title = "Restyle ends in 1 minute, and you’ll leave the game." },
            7
        )
    end, { bool2 })

    return nil
end

return RestyleTimeLimitSnackbar
