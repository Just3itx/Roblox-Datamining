-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)

local useScreenSize = require(script.Parent.useScreenSize)
local FormFactor = require(MomentsCommon.Enums.FormFactor)

local function useFormFactor()
    local var1 = useScreenSize()

    return (React.useMemo(function()
        if var1.X < 600 then
            return FormFactor.MobilePortrait
        end

        if var1.Y < 480 then
            return FormFactor.MobileLandscape
        end

        return FormFactor.Wide
    end, { var1 }))
end

return useFormFactor
