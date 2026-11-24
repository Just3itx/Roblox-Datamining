-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceDetailsPrompt = script:FindFirstAncestor("InExperienceDetailsPrompt")
local InExperienceDetailsPromptParent = InExperienceDetailsPrompt.Parent
local React = require(InExperienceDetailsPromptParent.React)

local Foundation = require(InExperienceDetailsPromptParent.Foundation)
local Sheet = Foundation.Sheet
local useScaledValue = Foundation.Hooks.useScaledValue

local _DataHydration = require(InExperienceDetailsPromptParent.DataHydration)

local InExperienceDetailsPromptErrorContent = require(InExperienceDetailsPrompt.Features.InExperienceDetailsPromptErrorContent)
local InExperienceDetailsPromptHeader = require(InExperienceDetailsPrompt.Features.InExperienceDetailsPromptHeader)
local InExperienceDetailsPromptContent = require(InExperienceDetailsPrompt.Features.InExperienceDetailsPromptContent)
local InExperienceDetailsPromptActions = require(InExperienceDetailsPrompt.Features.InExperienceDetailsPromptActions)

local FFlagLuaAppIedpOverlayAndNavigationFix = require(InExperienceDetailsPromptParent.SharedFlags).FFlagLuaAppIedpOverlayAndNavigationFix
local FFlagLuaAppIedpFixPlayButton = require(InExperienceDetailsPromptParent.SharedFlags).FFlagLuaAppIedpFixPlayButton

local function sheetChildren(tbl1)
    if tbl1.errorType then
        return {
            Content = React.createElement(
                Sheet.Content,
                nil,
                {
                    ErrorContent = React.createElement(InExperienceDetailsPromptErrorContent, { errorType = tbl1.errorType })
                }
            )
        }
    end

    local tbl2 = {
        Header = React.createElement(
            InExperienceDetailsPromptHeader,
            {
                name = tbl1.name,
                imageUri = tbl1.imageUri,
                creator = tbl1.creator
            }
        ),
        Content = React.createElement(Sheet.Content, nil, {
            MainContent = React.createElement(
                InExperienceDetailsPromptContent,
                {
                    ageRecommendation = tbl1.ageRecommendation,
                    rating = tbl1.rating
                }
            )
        }),
        Actions = React.createElement(InExperienceDetailsPromptActions, {
            playability = tbl1.playability,
            onJoin = tbl1.onJoin,
            rootPlaceId = if FFlagLuaAppIedpFixPlayButton then tbl1.rootPlaceId else nil,
            playabilityRetrievalStatus = tbl1.playabilityRetrievalStatus
        })
    }
    return tbl2
end

local function InExperienceDetailsPrompt2(tbl1)
    local var1 = useScaledValue(260)

    return React.createElement(Sheet.Root, {
        ref = tbl1.focusRootRef,
        sheetRef = if FFlagLuaAppIedpOverlayAndNavigationFix then tbl1.sheetRef else nil,
        preferCenterSheet = true,
        snapPoints = { var1 },
        onClose = tbl1.onClose
    }, (sheetChildren(tbl1)))
end

return InExperienceDetailsPrompt2
