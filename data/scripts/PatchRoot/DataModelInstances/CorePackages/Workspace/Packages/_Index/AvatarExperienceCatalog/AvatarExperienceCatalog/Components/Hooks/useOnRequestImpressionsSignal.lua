-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local Signal = require(AvatarExperienceCatalogParent.AppCommonLib).Signal

local function useOnRequestImpressionsSignal()
    local var1 = React.useRef(nil)
    if var1.current == nil then
        var1.current = Signal.new()
    end
    local current = var1.current

    React.useEffect(function()
        current:fire()

        local bool1 = false
        local var2 = nil
        local function scheduleNext() -- Luacid: Inlined by compiler; 1 call site recovered
            if bool1 then
                return
            end
            var2 = task.delay(1, function()
                if bool1 then
                    return
                end
                current:fire()
                scheduleNext()
            end)
        end

        scheduleNext()

        return function()
            bool1 = true
            if var2 then
                task.cancel(var2)
                var2 = nil
            end
        end
    end, {})

    return current
end

return useOnRequestImpressionsSignal
