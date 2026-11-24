-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local ExpChatShared = require(ExpChatParent.ExpChatShared)

local EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint = require(ExpChatParent.SharedFlags).EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint

local ExpChatOpenExpressionTrayExperimentation = require(ExpChatParent.SocialExperiments).ExpChatOpenExpressionTrayExperimentation
local Constants = require(ExpChat.PresetChat.Constants)
local _createPresetChatStore = require(ExpChat.Stores.GetPresetChatStore.createPresetChatStore)

local FFlagExpChatOpenExpressionTrayExposure = require(ExpChat.Flags.FFlagExpChatOpenExpressionTrayExposure)
local FFlagExpChatPresetTrayDismissAnalytics = require(ExpChat.Flags.FFlagExpChatPresetTrayDismissAnalytics)
local emojiUnicodeToId = require(ExpChat.PresetChat.emojiUnicodeToId)

local function buildPresetTrayItems(categoryGroups, presetClickCounts, viewedGroupIds)
    local presetTrayItems = {}
    for _, categoryGroup in categoryGroups do
        if FFlagExpChatPresetTrayDismissAnalytics and not viewedGroupIds[categoryGroup.categoryGroupId] then
            continue
        end

        for _, value in categoryGroup.categories do
            local category = value.name or value.categoryId

            for value2, value3 in if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then value.contents else value.messages do
                if FFlagExpChatPresetTrayDismissAnalytics then
                    local presetId = if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint and value3.kind == "Emoji" then emojiUnicodeToId(value3.unicode) else value3.presetId
                    table.insert(presetTrayItems, {
                        category = category,
                        tab = categoryGroup.name or categoryGroup.categoryGroupId,
                        preset_id = presetId,
                        index = value2 - 1,
                        click = math.min(presetClickCounts[presetId] or 0, 1)
                    })
                elseif EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint and value3.kind == "Emoji" then
                    table.insert(
                        presetTrayItems,
                        {
                            category = category,
                            emote_id = value3.emoteId,
                            index = value2 - 1,
                            click = presetClickCounts[value3.emoteId] or 0
                        }
                    )
                else
                    table.insert(presetTrayItems, {
                        category = category,
                        preset_id = value3.presetId,
                        index = value2 - 1,
                        click = presetClickCounts[value3.presetId] or 0
                    })
                end
            end
        end
    end

    return presetTrayItems
end

local function setIsPresetTrayOpen(arg1, bool1: boolean)
    if bool1 == arg1.getIsTrayOpen(false) then
        return
    end

    if FFlagExpChatPresetTrayDismissAnalytics and bool1 then
        arg1.setPresetClickCounts({})
        arg1.setViewedGroupIds({})
    end

    arg1.setIsTrayOpen(bool1)

    if FFlagExpChatOpenExpressionTrayExposure and bool1 then
        ExpChatOpenExpressionTrayExperimentation.logExposure()
    end

    if bool1 then
        ExpChatShared.Analytics:TelemetryLogEvent(
            ExpChatShared.Analytics.ExpChatPresetActionConfig,
            {
                event_type = Constants.Analytics.EventTypes.Show,
                component = Constants.Analytics.Components.PresetTray
            },
            ExpChatShared.Analytics.DefaultStandardizedFields
        )
        return
    end
    ExpChatShared.Analytics:TelemetryLogEvent(
        ExpChatShared.Analytics.ExpChatPresetActionConfig,
        {
            event_type = Constants.Analytics.EventTypes.Dismiss,
            component = Constants.Analytics.Components.PresetTray,
            preset_items = HttpService:JSONEncode(
                (buildPresetTrayItems(arg1.getCategoryGroups(false), arg1.getPresetClickCounts(false), arg1.getViewedGroupIds(false)))
            )
        },
        ExpChatShared.Analytics.DefaultStandardizedFields
    )
end

return setIsPresetTrayOpen
