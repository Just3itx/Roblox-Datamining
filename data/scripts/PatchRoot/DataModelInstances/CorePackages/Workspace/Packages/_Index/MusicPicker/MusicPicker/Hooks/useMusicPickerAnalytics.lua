-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MusicPicker = script:FindFirstAncestor("MusicPicker")
local MusicPickerParent = MusicPicker.Parent

local React = require(MusicPickerParent.React)

local Songbird = require(MusicPickerParent.Songbird)
local sendAudioPlayerAnalytics = Songbird.Analytics.sendAudioPlayerAnalytics
local AnalyticActions = Songbird.Analytics.AnalyticActions

local _MusicPickerTypes = require(MusicPicker.Types.MusicPickerTypes)

local function thumbnailIdFor(itemsById, num1: number): string -- Luacid: Inlined by compiler; 4 call sites recovered
    local var1 = itemsById[num1]
    if var1 == nil then
        return "-1"
    end

    return tostring(var1.thumbnailAssetId)
end

local function useMusicPickerAnalytics(tbl1)
    local source = tbl1.source
    local previewingId = tbl1.previewingId
    local savedIds = tbl1.savedIds
    local itemsById = tbl1.itemsById

    local var1 = React.useRef(nil)
    React.useEffect(function()
        local current = var1.current
        local songId = if current == nil then nil else current.songId
        local var2 = if previewingId == nil then nil else tostring(previewingId)

        if songId == var2 then
            return
        end

        if current ~= nil then
            sendAudioPlayerAnalytics(
                {
                    action = AnalyticActions.AudioStopped,
                    songId = current.songId,
                    thumbnailId = current.thumbnailId,
                    source = source
                }
            )
        end
        if previewingId == nil then
            var1.current = nil

            return
        end

        local thumbnailId = thumbnailIdFor(itemsById, previewingId)
        sendAudioPlayerAnalytics(
            {
                action = AnalyticActions.AudioPlay,
                songId = var2,
                thumbnailId = thumbnailId,
                source = source
            }
        )
        var1.current = { songId = var2, thumbnailId = thumbnailId }
    end, { previewingId, source, itemsById })

    local var2 = React.useRef(source)
    var2.current = source
    React.useEffect(function()
        return function()
            local current = var1.current
            if current == nil then
                return
            end

            sendAudioPlayerAnalytics({
                action = AnalyticActions.AudioStopped,
                songId = current.songId,
                thumbnailId = current.thumbnailId,
                source = var2.current
            })
            var1.current = nil
        end
    end, {})

    local var3 = React.useRef(nil)
    React.useEffect(function()
        local current = var3.current
        var3.current = savedIds

        if current == nil then
            return
        end

        for k, savedId in savedIds do
            if not savedId or current[k] then
                continue
            end

            sendAudioPlayerAnalytics(
                {
                    action = AnalyticActions.Like,
                    songId = tostring(k),
                    thumbnailId = thumbnailIdFor(itemsById, k),
                    source = source
                }
            )
        end
        for value, value2 in current do
            if not value2 or savedIds[value] then
                continue
            end

            sendAudioPlayerAnalytics({
                action = AnalyticActions.Unlike,
                songId = tostring(value),
                thumbnailId = thumbnailIdFor(itemsById, value),
                source = source
            })
        end
    end, { savedIds, source, itemsById })

    return React.useCallback(function(num1: number)
        sendAudioPlayerAnalytics({
            action = AnalyticActions.AudioPause,
            songId = tostring(num1),
            thumbnailId = thumbnailIdFor(itemsById, num1),
            source = source
        })
    end, { source, itemsById })
end

return useMusicPickerAnalytics
