-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local React = require(AvatarExperienceCommonParent.React)
local ReactOtter = require(AvatarExperienceCommonParent.ReactOtter)
local Otter = require(AvatarExperienceCommonParent.Otter)
local useAnimatedBinding = ReactOtter.useAnimatedBinding

local tbl1 = { frequency = 10, dampingRatio = 1 }

local function usePulseAnimationBinding(bool1: boolean?)
    local var1 = React.useRef(nil)

    local var2 = React.useCallback(function(tbl2)
        if not var1.current or not bool1 then
            return
        end
        if tbl2.thickness == 10 then
            var1.current({ thickness = Otter.instant(1), transparency = Otter.instant(0) })
            return
        end
        if tbl2.thickness == 1 then
            var1.current({ thickness = Otter.ease(10, tbl1), transparency = Otter.ease(1, tbl1) })
        end
    end, { bool1 })

    local var3, current = useAnimatedBinding({ thickness = 0, transparency = 0 }, var2)

    React.useEffect(function()
        if bool1 then
            if not var1.current then
                var1.current = current
            end
            current({ thickness = Otter.ease(10, tbl1), transparency = Otter.ease(1, tbl1) })
        end

        return function()
            current({ thickness = Otter.instant(0), transparency = Otter.instant(0) })
        end
    end, { bool1 })

    return var3
end

return usePulseAnimationBinding
