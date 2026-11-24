-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local Foundation = require(InExperienceSideSheetParent.Foundation)
local React = require(InExperienceSideSheetParent.React)

local getUniverseId = require(InExperienceSideSheet.Utils.getUniverseId)

local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailType = Foundation.Enums.ThumbnailType
local ThumbnailSize = Foundation.Enums.ThumbnailSize

local function useExperienceIcon()
    local universeId = getUniverseId()

    return React.useMemo(function()
        if not universeId then
            return nil
        end
        return getRbxThumb(ThumbnailType.GameIcon, universeId, ThumbnailSize.Small)
    end, { universeId })
end

return useExperienceIcon
