-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local _Types = require(MomentsCommon.Types)

local Constants = require(MomentsCommon.Constants)

local function getTagsForMoment(arg1)
    local tagsForMoment = {}

    if arg1.captureType == Enum.CaptureType.Screenshot then
        table.insert(tagsForMoment, "screenshot")
    elseif arg1.captureType == Enum.CaptureType.Video then
        table.insert(tagsForMoment, "video")
    end

    if arg1.universeId then
        table.insert(tagsForMoment, Constants.TagPrefix.Universe .. tostring(arg1.universeId))
    end

    if arg1.edits then
        if arg1.edits.trim then
            table.insert(tagsForMoment, "trim")
        end
        if arg1.edits.music then
            table.insert(tagsForMoment, "music")
            if arg1.edits.music.assetId then
                table.insert(tagsForMoment, Constants.TagPrefix.Music .. tostring(arg1.edits.music.assetId))
            end
        end
        if arg1.edits.textOverlays then
            table.insert(tagsForMoment, "text_overlay")
        end
    end

    return tagsForMoment
end

return getTagsForMoment
