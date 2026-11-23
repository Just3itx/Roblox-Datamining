-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)

local BuildMaturityBanner = require(BuildExperience.Components.GameConfigurations.BuildMaturityBanner.BuildMaturityBanner)
local GameConfigurationList = require(BuildExperience.Components.GameConfigurations.GameConfigurationList.GameConfigurationList)

local View = Foundation.View

local IconName = Foundation.Enums.IconName

local function PublishConfigurationContentView(tbl1)
    local testId = tbl1.testId or "game-configuration-content"
    local var1 = useLocalization({
        contentBody = LocalizationStrings.PUBLISH_CONTENT_BODY,
        contentMaturity = LocalizationStrings.PUBLISH_CONTENT_MATURITY,
        contentTitle = LocalizationStrings.PUBLISH_CONTENT_TITLE,
        gameDetails = LocalizationStrings.GAME_CONFIGURATION_GAME_DETAILS,
        gameDetailsBody = LocalizationStrings.GAME_CONFIGURATION_GAME_DETAILS_BODY,
        iconAndThumbnails = LocalizationStrings.GAME_CONFIGURATION_ICON_AND_THUMBNAILS,
        titleAndDescription = LocalizationStrings.GAME_CONFIGURATION_TITLE_AND_DESCRIPTION,
        versionInformationBody = LocalizationStrings.PUBLISH_VERSION_INFORMATION_BODY,
        versionInformationTitle = LocalizationStrings.PUBLISH_VERSION_INFORMATION_TITLE,
        versionHistory = LocalizationStrings.VERSION_HISTORY_TITLE,
        versionTitleDescription = LocalizationStrings.PUBLISH_VERSION_TITLE_DESCRIPTION
    })
    local contentBody = var1.contentBody
    local contentMaturity = var1.contentMaturity
    local contentTitle = var1.contentTitle
    local gameDetails = var1.gameDetails
    local gameDetailsBody = var1.gameDetailsBody
    local iconAndThumbnails = var1.iconAndThumbnails
    local titleAndDescription = var1.titleAndDescription
    local versionInformationBody = var1.versionInformationBody
    local versionInformationTitle = var1.versionInformationTitle
    local versionHistory = var1.versionHistory
    local versionTitleDescription = var1.versionTitleDescription
    local isEditDisabled = FFlagBuildCheckGamePermissions and tbl1.isEditDisabled
    local isIconAndThumbnailsDisabled = FFlagBuildCheckGamePermissions and tbl1.isIconAndThumbnailsDisabled
    local rows = {
        {
            id = "icon-thumbnails",
            title = iconAndThumbnails,
            onActivated = tbl1.onOpenIconAndThumbnails,
            isDisabled = isEditDisabled or isIconAndThumbnailsDisabled
        },
        {
            id = "title-description",
            title = titleAndDescription,
            onActivated = tbl1.onOpenTitleDescriptionPage,
            isDisabled = isEditDisabled
        }
    }

    local tbl2 = {{
        id = "content-rating",
        title = contentMaturity,
        description = tbl1.contentMaturityText,
        trailingIcon = IconName.ArrowUpRightFromSquare,
        onActivated = tbl1.onOpenContentMaturity,
        isDisabled = isEditDisabled
    }}

    local tbl3 = {}
    table.insert(tbl3, {
        id = "version-title-description",
        title = versionTitleDescription,
        onActivated = tbl1.onOpenVersionTitleDescriptionPage
    })
    table.insert(
        tbl3,
        {
            id = "version-history",
            title = versionHistory,
            onActivated = tbl1.onOpenVersionHistory,
            isDisabled = isEditDisabled
        }
    )
    local createElement = React.createElement
    local var2 = View
    local tbl5 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-large size-full-0 auto-y",
        testId = testId
    }
    local tbl6 = {
        VersionInformation = React.createElement(GameConfigurationList, {
            layoutOrder = 1,
            title = versionInformationTitle,
            body = versionInformationBody,
            rows = tbl3,
            onRowActivated = tbl1.onRowActivated,
            testId = `{testId}-version-information`
        }),
        GameDetails = React.createElement(GameConfigurationList, {
            layoutOrder = 2,
            title = gameDetails,
            body = gameDetailsBody,
            rows = rows,
            onRowActivated = tbl1.onRowActivated,
            testId = `{testId}-game-details`
        }),
        Content = React.createElement(
            View,
            {
                LayoutOrder = 3,
                tag = "col gap-medium size-full-0 auto-y",
                testId = `{testId}-content-section`
            },
            {
                Configuration = React.createElement(GameConfigurationList, {
                    layoutOrder = 1,
                    title = contentTitle,
                    body = contentBody,
                    rows = tbl2,
                    onRowActivated = tbl1.onRowActivated,
                    testId = `{testId}-content`
                }),
                BuildMaturityBanner = if tbl1.buildMaturityBannerText == nil then nil else React.createElement(BuildMaturityBanner, { text = tbl1.buildMaturityBannerText })
            }
        )
    }
    return createElement(var2, tbl5, tbl6)
end

return PublishConfigurationContentView
