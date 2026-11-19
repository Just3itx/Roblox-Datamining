-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")

local TnSAvatarIdentification = require(CorePackages.Workspace.Packages.TnSAvatarIdentification)
local TnSAdIdentification = require(CorePackages.Workspace.Packages.TnSAdIdentification)

local HttpService = game:GetService("HttpService")

local getAvatarsForPoint = TnSAvatarIdentification.AvatarIdentification.getAvatarsForPoint
local getAvatarsForRegion = TnSAvatarIdentification.AvatarIdentification.getAvatarsForRegion

local getAdsForPoint = TnSAdIdentification.AdIdentification.getAdsForPoint

local GetFFlagReportAnythingEnableAdReport = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagReportAnythingEnableAdReport

local GetFFlagGetHumanoidDescription = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagGetHumanoidDescription
local GetFFlagRAEnableCircleRegion = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagRAEnableCircleRegion

local GetFFlagGetHumanoidDescriptionUpdatesV2E = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagGetHumanoidDescriptionUpdatesV2E

local getHumanoidDescription = require(AbuseReportMenu.ReportAnything.Utility.GetHumanoidDescription).getHumanoidDescription
local _Types = require(AbuseReportMenu.Components.Types)
local _ReportAnythingAnalytics = require(AbuseReportMenu.ReportAnything.Utility.ReportAnythingAnalytics)

local Constants = {
    Variant = {
        CS = "ra/cs",
        Sampling = "ra/sampling",
        E1 = "ra/e1",
        E2 = "ra/e2",
        E3 = "ra/e3",
        NM = "ra/nm",
        Unknown = "ra/unknown"
    }
}

local function func1(tbl2)
    local result = {}
    for _, value in ipairs(tbl2) do
        result[#result + 1] = { value.X, value.Y }
    end
    return result
end

local function func2(arg1)
    local result = ({})
    for _, value in pairs(arg1) do
        local num1 = #result + 1
        result[num1] = {
            assetId = value.assetId,
            distance = value.distance,
            boundingBox = {
                minX = value.boundingBox.min.X,
                minY = value.boundingBox.min.Y,
                maxX = value.boundingBox.max.X,
                maxY = value.boundingBox.max.Y
            },
            adUnitName = value.adUnitName,
            encryptedAdTrackingData = value.encryptedAdTrackingData,
            encryptionMetadata = value.encryptionMetadata
        }
    end

    return result
end

local function func3(identifiedAvatars)
    local result = ({})

    for k, identifiedAvatar in pairs(identifiedAvatars) do
        local num1 = #result + 1
        result[num1] = {
            userId = tostring(k),
            distance = identifiedAvatar.distance,
            boundingBox = {
                minX = identifiedAvatar.boundingBox.min.X,
                minY = identifiedAvatar.boundingBox.min.Y,
                maxX = identifiedAvatar.boundingBox.max.X,
                maxY = identifiedAvatar.boundingBox.max.Y
            },
            hitRate = identifiedAvatar.hitRate,
            convexHull = func1(identifiedAvatar.convexHull)
        }

        if identifiedAvatar.pointProcessingStats == nil then
            continue
        end

        result[#result].pointProcessingStats = {
            if identifiedAvatar.pointProcessingStats.wasSkipped then 1 else 0,
            identifiedAvatar.pointProcessingStats.total,
            identifiedAvatar.pointProcessingStats.offScreenDiscardCount,
            identifiedAvatar.pointProcessingStats.tooCloseDiscardCount
        }
    end

    return result
end

local function func4(num1: number, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if not GetFFlagGetHumanoidDescriptionUpdatesV2E() then
        local var1, var2 = getHumanoidDescription(num1)

        return var1, var2
    end

    local identifiedAvatar = arg1.identificationResults.identifiedAvatars[num1]
    if identifiedAvatar and identifiedAvatar.humanoidDescription and identifiedAvatar.humanoidDescriptionStatus == "OK" then
        return identifiedAvatar.humanoidDescription, identifiedAvatar.humanoidDescriptionStatus
    end
    local var1, var2 = getHumanoidDescription(num1)
    return var1, var2
end

local function interpretAnnotations(arg1)
    local tbl2 = ({})
    local tbl3 = ({})

    local tbl4 = {}
    local tbl5 = {}
    for _, annotationPoint in ipairs(arg1.annotationPoints) do
        local huge = math.huge
        local var1 = nil
        local var2 = if GetFFlagRAEnableCircleRegion() then getAvatarsForRegion(
            arg1.identificationResults.identifiedAvatars,
            annotationPoint,
            arg1.annotationCircleRadius,
            arg1.annotationAreaWidth,
            arg1.annotationAreaHeight
        ) else getAvatarsForPoint(arg1.identificationResults.identifiedAvatars, annotationPoint)

        for k, _ in pairs(var2) do
            local distance = arg1.identificationResults.identifiedAvatars[k].distance
            if distance < huge then
                var1 = k
                huge = distance
            end
        end

        local var3 = nil

        if GetFFlagReportAnythingEnableAdReport() then
            local adsForPoint = getAdsForPoint(arg1.identificationResults.identifiedAds, annotationPoint)
            local huge2 = math.huge
            for k, _ in pairs(adsForPoint) do
                local distance = arg1.identificationResults.identifiedAds[k].distance
                if distance < huge2 then
                    var3 = k
                    huge2 = distance
                end
            end
        end

        if var1 ~= nil and not tbl2[var1] then
            tbl2[var1] = true
            tbl4[#tbl4 + 1] = arg1.identificationResults.identifiedAvatars[var1].player
        elseif GetFFlagReportAnythingEnableAdReport() and var3 ~= nil and not tbl3[var3] then
            tbl3[var3] = true
            tbl5[#tbl5 + 1] = arg1.identificationResults.identifiedAds[var3]
        end
    end

    return tbl4, tbl5
end

local function func6(arg1, _, tbl2)
    local bool1 = false
    local bool2 = false

    for k, identifiedAvatar in pairs(arg1.identificationResults.identifiedAvatars) do
        local _, _ = k, identifiedAvatar
        bool2 = true
        break
    end

    if bool2 then
        bool1 = true
    end

    local bool3 = false

    if GetFFlagReportAnythingEnableAdReport() then
        local bool4 = false

        for k, identifiedAd in pairs(arg1.identificationResults.identifiedAds) do
            local _, _ = k, identifiedAd
            bool4 = true
            break
        end

        if bool4 then
            bool3 = true
        end
    end

    if bool1 then
        tbl2.tags.IDENTIFIED_AVATARS = {
            valueList = {{
                data = HttpService:JSONEncode((func3(arg1.identificationResults.identifiedAvatars)))
            }}
        }
    end

    if arg1.identificationResults.avatarIDStats then
        tbl2.tags.AVATAR_ID_STATS = {
            valueList = {{
                data = HttpService:JSONEncode(arg1.identificationResults.avatarIDStats)
            }}
        }
    end

    if bool3 and GetFFlagReportAnythingEnableAdReport() then
        tbl2.tags.IDENTIFIED_ADS = {
            valueList = {{
                data = HttpService:JSONEncode((func2(arg1.identificationResults.identifiedAds)))
            }}
        }
    end

    if arg1.identificationResults.adIDStats and GetFFlagReportAnythingEnableAdReport() then
        tbl2.tags.AD_ID_STATS = {
            valueList = {{
                data = HttpService:JSONEncode(arg1.identificationResults.adIDStats)
            }}
        }
    end

    if #arg1.screenshotId > 0 then
        tbl2.tags.SCREENSHOT_ID = {
            valueList = {{
                data = arg1.screenshotId
            }}
        }
    end

    if #arg1.annotationPoints > 0 then
        tbl2.tags.RA_ANNOTATION_POINTS = {
            valueList = {{
                data = HttpService:JSONEncode((func1(arg1.annotationPoints)))
            }}
        }
    end

    local tags = tbl2.tags
    local raAnnotationOptionSeen = {
        valueList = {{
            data = tostring(arg1.annotationOptionSeen)
        }}
    }
    tags.RA_ANNOTATION_OPTION_SEEN = raAnnotationOptionSeen

    local tags2 = tbl2.tags
    local raAnnotationPageSeen = {
        valueList = {{
            data = tostring(arg1.annotationPageSeen)
        }}
    }
    tags2.RA_ANNOTATION_PAGE_SEEN = raAnnotationPageSeen
end

return {
    buildExperienceReportRequest = function(tbl2, arg1, arg2): string
        local input = { tags = 0 }
        local tags = {
            ENTRY_POINT = {
                valueList = {{ data = "in-experience" }}
            },
            SUBMITTER_USER_ID = 0,
            REPORTED_ABUSE_CATEGORY = 0,
            PLACE_ID = 0,
            REPORTER_COMMENT = 0,
            REPORTED_ABUSE_VECTOR = 0,
            IN_EXP_MENU_ENTRY_POINT = 0,
            VARIANT = 0
        }

        local submitterUserId = {
            valueList = {{
                data = tostring(tbl2.localUserId)
            }}
        }
        tags.SUBMITTER_USER_ID = submitterUserId

        tags.REPORTED_ABUSE_CATEGORY = {
            valueList = {{
                data = tbl2.abuseReason
            }}
        }

        local placeId = {
            valueList = {{
                data = tostring(tbl2.placeId)
            }}
        }
        tags.PLACE_ID = placeId

        tags.REPORTER_COMMENT = {
            valueList = {{
                data = tbl2.abuseComment
            }}
        }

        tags.REPORTED_ABUSE_VECTOR = {
            valueList = {{ data = "place" }}
        }

        tags.IN_EXP_MENU_ENTRY_POINT = {
            valueList = {{
                data = tbl2.menuEntryPoint
            }}
        }

        tags.VARIANT = {
            valueList = {{
                data = tbl2.variant or Constants.Variant.CS
            }}
        }
        input.tags = tags

        local _, tbl6 = interpretAnnotations(arg1)
        func6(arg1, arg2, input)

        if #tbl6 > 0 and GetFFlagReportAnythingEnableAdReport() then
            input.tags.REPORT_TARGET_ADS = {
                valueList = {{
                    data = HttpService:JSONEncode((func2(tbl6)))
                }}
            }
        end

        return HttpService:JSONEncode(input)
    end,
    buildOtherReportRequest = function(tbl2, arg1, arg2)
        local input = { tags = 0 }
        local tags = {
            ENTRY_POINT = {
                valueList = {{ data = "in-experience" }}
            },
            SUBMITTER_USER_ID = 0,
            REPORTED_ABUSE_CATEGORY = 0,
            REPORTER_COMMENT = 0,
            REPORTED_ABUSE_VECTOR = 0,
            IN_EXP_MENU_ENTRY_POINT = 0,
            VARIANT = 0
        }

        local submitterUserId = {
            valueList = {{
                data = tostring(tbl2.localUserId)
            }}
        }
        tags.SUBMITTER_USER_ID = submitterUserId

        tags.REPORTED_ABUSE_CATEGORY = {
            valueList = {{
                data = tbl2.abuseReason
            }}
        }

        tags.REPORTER_COMMENT = {
            valueList = {{
                data = tbl2.abuseComment
            }}
        }

        tags.REPORTED_ABUSE_VECTOR = {
            valueList = {{ data = "avatar" }}
        }

        tags.IN_EXP_MENU_ENTRY_POINT = {
            valueList = {{
                data = tbl2.menuEntryPoint
            }}
        }

        tags.VARIANT = {
            valueList = {{
                data = tbl2.variant or Constants.Variant.Unknown
            }}
        }
        input.tags = tags

        local tbl5, _ = interpretAnnotations(arg1)
        func6(arg1, arg2, input)

        if #tbl5 > 0 then
            local str1 = tostring(tbl5[1].UserId)
            local input2 = ({})
            for _, value in ipairs(tbl5) do
                local num1 = #input2 + 1
                input2[num1] = tostring(value.UserId)
            end

            if GetFFlagGetHumanoidDescription() then
                local input3, var1 = func4(tbl5[1].UserId, arg1)

                input.tags.REPORT_TARGET_HUMANOID_DESCRIPTION = {
                    valueList = {{
                        data = HttpService:JSONEncode(input3)
                    }}
                }

                input.tags.REPORT_TARGET_HUMANOID_DESCRIPTION_STATUS = {
                    valueList = {{ data = var1 }}
                }

                local input4 = {}
                for _, value in ipairs(tbl5) do
                    local humanoidDescription, outputMessage = func4(value.UserId, arg1)

                    input4[#input4 + 1] = {
                        humanoidDescription = humanoidDescription,
                        outputMessage = outputMessage
                    }
                end

                input.tags.RA_ALL_ANNOTATED_HUMANOID_DESCRIPTIONS = {
                    valueList = {{
                        data = HttpService:JSONEncode(input4)
                    }}
                }
            end

            input.tags.REPORT_TARGET_USER_ID = {
                valueList = {{
                    data = tostring(str1)
                }}
            }

            input.tags.RA_ALL_ANNOTATED_USER_IDS = {
                valueList = {{
                    data = HttpService:JSONEncode(input2)
                }}
            }
        elseif tbl2.formSelectedAbuserUserId then
            if GetFFlagGetHumanoidDescription() then
                local input2, var1 = func4(tbl2.formSelectedAbuserUserId, arg1)

                input.tags.REPORT_TARGET_HUMANOID_DESCRIPTION = {
                    valueList = {{
                        data = HttpService:JSONEncode(input2)
                    }}
                }

                input.tags.REPORT_TARGET_HUMANOID_DESCRIPTION_STATUS = {
                    valueList = {{ data = var1 }}
                }
            end

            local tags = input.tags
            local reportTargetUserId = {
                valueList = {{
                    data = tostring(tbl2.formSelectedAbuserUserId)
                }}
            }
            tags.REPORT_TARGET_USER_ID = reportTargetUserId
        end

        if game:GetEngineFeature("WHAM2165") then
            return input
        end
        return HttpService:JSONEncode(input)
    end,
    interpretAnnotations = interpretAnnotations,
    Constants = Constants
}
