-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)
local Signals = require(MomentsCommonParent.Signals)

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)

local function useHasPresentedFrame(bool1: boolean?, bool2: boolean?)
    local var1, var2 = React.useState(false)
    React.useEffect(function()
        if not bool2 or bool1 == nil then
            return
        end

        var2(false)
        local bool3 = false
        local effect = nil
        effect = Signals.createEffect(function(arg1)
            if not (bool1.getPosition(arg1) > 0) or bool3 then
                return
            end

            bool3 = true
            var2(true)

            task.defer(function()
                if effect ~= nil then
                    effect()
                end
            end)
        end)

        return function()
            bool3 = true
            if effect ~= nil then
                effect()
            end
        end
    end, { bool1, bool2 })
    return var1
end

return useHasPresentedFrame
