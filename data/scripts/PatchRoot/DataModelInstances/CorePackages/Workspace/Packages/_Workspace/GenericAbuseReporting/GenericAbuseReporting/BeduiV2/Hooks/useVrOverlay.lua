-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
local CoreGui = game:GetService("CoreGui")

local React = require(GenericAbuseReportingParent.React)
local useIsSpatial = require(GenericAbuseReportingParent.Responsive).useIsSpatial

local function getSyncVrOverlayOrNil()
    local vrCentralOverlay = CoreGui:FindFirstChild("VRCentralOverlay")
    if not vrCentralOverlay then
        return nil
    end
    return vrCentralOverlay:FindFirstChildWhichIsA("SurfaceGui")
end

local function useVrOverlay()
    local var1 = useIsSpatial()
    local var2, var3 = React.useState(getSyncVrOverlayOrNil)

    React.useEffect(function()
        if not var1 then
            return function() end
        end

        if var2 then
            return function() end
        end

        local var4 = task.spawn(function()
            local vrCentralOverlay = CoreGui:WaitForChild("VRCentralOverlay", 5)
            if not vrCentralOverlay then
                return
            end
            local centralOverlaySurfaceGui = vrCentralOverlay:WaitForChild("CentralOverlay_SurfaceGui", 5)
            if centralOverlaySurfaceGui then
                var3(centralOverlaySurfaceGui)
            end
        end)

        return function()
            task.cancel(var4)
        end
    end, { var1, var2 })

    if not var1 then
        return nil, false
    end

    return var2, true
end

return useVrOverlay
