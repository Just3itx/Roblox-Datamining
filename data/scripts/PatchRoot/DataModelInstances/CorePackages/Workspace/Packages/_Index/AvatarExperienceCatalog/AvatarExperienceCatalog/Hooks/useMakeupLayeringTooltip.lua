-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)

local useMakeupFtux = require(script.Parent.useMakeupFtux)

local num1 = game:DefineFastInt("AXMakeupLayeringTooltipShowDelayMS", 500)
local num2 = game:DefineFastInt("AXMakeupLayeringTooltipDismissTimeoutSeconds", 5)

local function useMakeupLayeringTooltip(bool1: boolean)
    local var1 = useMakeupFtux()
    local showTooltip, var3 = React.useState(false)

    React.useEffect(function()
        if not (bool1 and var1.shouldShowMakeupLayeringTooltip()) then
            var3(false)
            return
        end

        local var4 = task.delay(num1 / 1000, function()
            var3(true)
            var1.markMakeupLayeringTooltipSeen()
        end)

        return function()
            if var4 then
                task.cancel(var4)
            end
        end
    end, { bool1 })

    React.useEffect(function()
        if not showTooltip then
            return
        end

        local var4 = task.delay(num2, function()
            var3(false)
        end)

        return function()
            if var4 then
                task.cancel(var4)
            end
        end
    end, { showTooltip })

    return {
        showTooltip = showTooltip,
        dismissTooltip = React.useCallback(function()
            var3(false)
        end, {})
    }
end

return useMakeupLayeringTooltip
