-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReporting = script:FindFirstAncestor("InGameAssetReporting")
local InGameAssetReportingParent = InGameAssetReporting.Parent

local Localization = require(InGameAssetReportingParent.Localization)
local React = require(InGameAssetReportingParent.React)
local View = require(InGameAssetReportingParent.Foundation).View
local DsaIllegalContentReporting = require(InGameAssetReportingParent.DsaIllegalContentReporting)
local isShowUKOSAIllegalContentReportingLink = DsaIllegalContentReporting.isShowUKOSAIllegalContentReportingLink
local OSAReportLink = DsaIllegalContentReporting.OSAReportLink

local useLocalization = Localization.Hooks.useLocalization

local DefaultDualDropdownDialog = require(InGameAssetReportingParent.GenericAbuseReporting.DefaultDualDropdownDialog)
local DefaultDualDropdownDialogV2 = require(InGameAssetReportingParent.GenericAbuseReporting.DefaultDualDropdownDialogV2)

local Constants = require(InGameAssetReporting.InGameAssetReportUI.Resources.Constants)
local getPreselectedSurfaceValue = require(InGameAssetReporting.Utility.getPreselectedSurfaceValue)
local _SceneAnalysis = require(InGameAssetReporting.Analysis.SceneAnalysis)

local FFlagPrefillPreciseSelectionChoices = require(InGameAssetReportingParent.SharedFlags).FFlagPrefillPreciseSelectionChoices

local FFlagGenericAbuseReportingGranularExports = require(InGameAssetReportingParent.SharedFlags).FFlagGenericAbuseReportingGranularExports
local FFlagDropUnroutableMultiReportOptions = require(InGameAssetReportingParent.SharedFlags).FFlagDropUnroutableMultiReportOptions

local function InGameAssetReportSubmitDialog(tbl1)
    local var1 = nil
    if FFlagPrefillPreciseSelectionChoices then
        var1 = useLocalization({
            title = "Feature.ReportAbuse.Title.SelectInSceneFinishYourReport",
            problemBullying = "Feature.ReportAbuse.Problem.Bullying",
            problemBullyingDesc = "Feature.ReportAbuse.ProblemDescription.Bullying",
            problemCheating = "Feature.ReportAbuse.Problem.Cheating",
            problemCheatingDesc = "Feature.ReportAbuse.ProblemDescription.Cheating",
            problemDating = "Feature.ReportAbuse.Problem.Dating",
            problemDatingDesc = "Feature.ReportAbuse.ProblemDescription.Dating",
            problemHate = "Feature.ReportAbuse.Problem.Hate",
            problemHateDesc = "Feature.ReportAbuse.ProblemDescription.Hate",
            problemLinks = "Feature.ReportAbuse.Problem.Links",
            problemLinksDesc = "Feature.ReportAbuse.ProblemDescription.Links",
            problemPersonal = "Feature.ReportAbuse.Problem.Personal",
            problemPersonalDesc = "Feature.ReportAbuse.ProblemDescription.Personal",
            problemScamming = "Feature.ReportAbuse.Problem.Scamming",
            problemScammingDesc = "Feature.ReportAbuse.ProblemDescription.Scamming",
            problemSwearing = "Feature.ReportAbuse.Problem.Swearing",
            problemSwearingDesc = "Feature.ReportAbuse.ProblemDescription.Swearing",
            problemViolence = "Feature.ReportAbuse.Problem.Violence",
            problemViolenceDesc = "Feature.ReportAbuse.ProblemDescription.Violence",
            surfaceAvatar = "Feature.ReportAbuse.ProblemSurface.Avatar",
            surfaceDrawing = "Feature.ReportAbuse.ProblemSurface.DrawingOrCreation",
            surfaceExperience = "Feature.ReportAbuse.ProblemSurface.Experience",
            surfaceItem = "Feature.ReportAbuse.ProblemSurface.ItemOrAsset",
            surfaceMovement = "Feature.ReportAbuse.ProblemSurface.Movement",
            surfaceMusic = "Feature.ReportAbuse.ProblemSurface.MusicOrSoundEffect",
            surfaceTextChat = "Feature.ReportAbuse.ProblemSurface.TextChat",
            surfaceUsername = "Feature.ReportAbuse.ProblemSurface.Username",
            problemIPInfringement = "Feature.ReportAbuse.Problem.IpInfringement",
            problemIPInfringementDesc = "Feature.ReportAbuse.ProblemDescription.IpInfringement"
        })
    end

    if not FFlagPrefillPreciseSelectionChoices then
        local reportProblems = FFlagDropUnroutableMultiReportOptions
            and {
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Bullying",
                    value = "bullying",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Bullying"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Dating",
                    value = "dating",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Dating"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Hate",
                    value = "hate",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Hate"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Links",
                    value = "offsite links",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Links"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Personal",
                    value = "personal question",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Personal"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Swearing",
                    value = "swearing",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Swearing"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Violence",
                    value = "violence",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Violence"
                }
            }
            or {
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Bullying",
                    value = "bullying",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Bullying"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Cheating",
                    value = "exploiting",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Cheating"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Dating",
                    value = "dating",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Dating"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Hate",
                    value = "hate",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Hate"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Links",
                    value = "offsite links",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Links"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Personal",
                    value = "personal question",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Personal"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Scamming",
                    value = "scamming",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Scamming"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Swearing",
                    value = "swearing",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Swearing"
                },
                {
                    localizationKey = "Feature.ReportAbuse.Problem.Violence",
                    value = "violence",
                    descriptionLocalizationKey = "Feature.ReportAbuse.ProblemDescription.Violence"
                }
            }

        local reportSurfaces = FFlagDropUnroutableMultiReportOptions
            and {
                { localizationKey = "Feature.ReportAbuse.ProblemSurface.Avatar", value = "avatar" },
                {
                    localizationKey = "Feature.ReportAbuse.ProblemSurface.DrawingOrCreation",
                    value = "drawing"
                },
                {
                    localizationKey = "Feature.ReportAbuse.ProblemSurface.Experience",
                    value = "experience"
                },
                {
                    localizationKey = "Feature.ReportAbuse.ProblemSurface.ItemOrAsset",
                    value = "item"
                },
                { localizationKey = "Feature.ReportAbuse.ProblemSurface.TextChat", value = "text" }
            }
            or {
                { localizationKey = "Feature.ReportAbuse.ProblemSurface.Avatar", value = "avatar" },
                {
                    localizationKey = "Feature.ReportAbuse.ProblemSurface.DrawingOrCreation",
                    value = "drawing"
                },
                {
                    localizationKey = "Feature.ReportAbuse.ProblemSurface.Experience",
                    value = "experience"
                },
                {
                    localizationKey = "Feature.ReportAbuse.ProblemSurface.ItemOrAsset",
                    value = "item"
                },
                {
                    localizationKey = "Feature.ReportAbuse.ProblemSurface.Movement",
                    value = "movement"
                },
                {
                    localizationKey = "Feature.ReportAbuse.ProblemSurface.MusicOrSoundEffect",
                    value = "music"
                },
                { localizationKey = "Feature.ReportAbuse.ProblemSurface.TextChat", value = "text" },
                {
                    localizationKey = "Feature.ReportAbuse.ProblemSurface.Username",
                    value = "username"
                }
            }

        return React.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            ZIndex = 10
        }, {
            SubmitReportDialog = React.createElement(DefaultDualDropdownDialog, {
                analyticsContext = "Test",
                localizationKeys = {
                    formTitle = "Feature.ReportAbuse.Title.SelectInSceneFinishYourReport",
                    formSubmit = "Feature.ReportAbuse.Label.Report"
                },
                onSubmitProps = {
                    hasNextSteps = true,
                    onProceedToNextStep = FFlagGenericAbuseReportingGranularExports and function(str1: string, str2: string, str3: string): boolean
                        tbl1.onSubmit(str1, str2, str3)
                        return true
                    end or tbl1.onSubmit
                },
                onCloseProps = {
                    hasPreviousSteps = false,
                    onAbandon = tbl1.onBack
                },
                footerContent = function()
                    if not isShowUKOSAIllegalContentReportingLink() then
                        return nil
                    end

                    return React.createElement(View, { tag = "size-full-0 auto-y" }, { OSALink = React.createElement(OSAReportLink) })
                end,
                reportProblems = reportProblems,
                reportSurfaces = reportSurfaces
            })
        })
    end

    local preselectedSurfaceValue = getPreselectedSurfaceValue(tbl1.extractionResult)
    local prefilledSurfaceSelection = if preselectedSurfaceValue == "avatar" then var1.surfaceAvatar elseif preselectedSurfaceValue == "item" then var1.surfaceItem elseif preselectedSurfaceValue == "text" then var1.surfaceTextChat else nil

    React.useEffect(function()
        if prefilledSurfaceSelection then
            tbl1.analyticsDispatch({
                type = Constants.AnalyticsActions.SetPrefilledSurfaceSelection,
                prefilled_surface_selection = prefilledSurfaceSelection
            })
        end
    end, { prefilledSurfaceSelection })

    local problems = React.useMemo(function()
        if FFlagDropUnroutableMultiReportOptions then
            return {
                {
                    value = "bullying",
                    label = var1.problemBullying,
                    description = var1.problemBullyingDesc
                },
                {
                    value = "dating",
                    label = var1.problemDating,
                    description = var1.problemDatingDesc
                },
                {
                    value = "hate",
                    label = var1.problemHate,
                    description = var1.problemHateDesc
                },
                {
                    value = "offsite links",
                    label = var1.problemLinks,
                    description = var1.problemLinksDesc
                },
                {
                    value = "personal question",
                    label = var1.problemPersonal,
                    description = var1.problemPersonalDesc
                },
                {
                    value = "swearing",
                    label = var1.problemSwearing,
                    description = var1.problemSwearingDesc
                },
                {
                    value = "violence",
                    label = var1.problemViolence,
                    description = var1.problemViolenceDesc
                },
                {
                    value = "ip infringement",
                    label = var1.problemIPInfringement,
                    description = var1.problemIPInfringementDesc
                }
            }
        end

        return {
            {
                value = "bullying",
                label = var1.problemBullying,
                description = var1.problemBullyingDesc
            },
            {
                value = "exploiting",
                label = var1.problemCheating,
                description = var1.problemCheatingDesc
            },
            {
                value = "dating",
                label = var1.problemDating,
                description = var1.problemDatingDesc
            },
            {
                value = "hate",
                label = var1.problemHate,
                description = var1.problemHateDesc
            },
            {
                value = "offsite links",
                label = var1.problemLinks,
                description = var1.problemLinksDesc
            },
            {
                value = "personal question",
                label = var1.problemPersonal,
                description = var1.problemPersonalDesc
            },
            {
                value = "scamming",
                label = var1.problemScamming,
                description = var1.problemScammingDesc
            },
            {
                value = "swearing",
                label = var1.problemSwearing,
                description = var1.problemSwearingDesc
            },
            {
                value = "violence",
                label = var1.problemViolence,
                description = var1.problemViolenceDesc
            },
            {
                value = "ip infringement",
                label = var1.problemIPInfringement,
                description = var1.problemIPInfringementDesc
            }
        }
    end, {
        var1.problemBullying,
        var1.problemBullyingDesc,
        var1.problemCheating,
        var1.problemCheatingDesc,
        var1.problemDating,
        var1.problemDatingDesc,
        var1.problemHate,
        var1.problemHateDesc,
        var1.problemLinks,
        var1.problemLinksDesc,
        var1.problemPersonal,
        var1.problemPersonalDesc,
        var1.problemScamming,
        var1.problemScammingDesc,
        var1.problemSwearing,
        var1.problemSwearingDesc,
        var1.problemViolence,
        var1.problemViolenceDesc,
        var1.problemIPInfringement,
        var1.problemIPInfringementDesc
    })

    local surfaces = React.useMemo(function()
        if FFlagDropUnroutableMultiReportOptions then
            return {
                {
                    value = "avatar",
                    label = var1.surfaceAvatar
                },
                {
                    value = "drawing",
                    label = var1.surfaceDrawing
                },
                {
                    value = "experience",
                    label = var1.surfaceExperience
                },
                {
                    value = "item",
                    label = var1.surfaceItem
                },
                {
                    value = "text",
                    label = var1.surfaceTextChat
                }
            }
        end

        return {
            {
                value = "avatar",
                label = var1.surfaceAvatar
            },
            {
                value = "drawing",
                label = var1.surfaceDrawing
            },
            {
                value = "experience",
                label = var1.surfaceExperience
            },
            {
                value = "item",
                label = var1.surfaceItem
            },
            {
                value = "movement",
                label = var1.surfaceMovement
            },
            {
                value = "music",
                label = var1.surfaceMusic
            },
            {
                value = "text",
                label = var1.surfaceTextChat
            },
            {
                value = "username",
                label = var1.surfaceUsername
            }
        }
    end, {
        var1.surfaceAvatar,
        var1.surfaceDrawing,
        var1.surfaceExperience,
        var1.surfaceItem,
        var1.surfaceMovement,
        var1.surfaceMusic,
        var1.surfaceTextChat,
        var1.surfaceUsername
    })

    local preselected = React.useMemo(function()
        local var5 = nil
        if preselectedSurfaceValue ~= nil and surfaces ~= nil then
            for i = 1, #surfaces do
                local var6 = surfaces[i]
                if var6 and var6.value == preselectedSurfaceValue then
                    var5 = var6
                    break
                end
            end
        end

        return { surface = var5 }
    end, { preselectedSurfaceValue, surfaces })

    return React.createElement(DefaultDualDropdownDialogV2, {
        title = var1.title,
        problems = problems,
        surfaces = surfaces,
        preselected = preselected,
        onClose = tbl1.onBack,
        onSubmit = tbl1.onSubmit
    })
end

return InGameAssetReportSubmitDialog
