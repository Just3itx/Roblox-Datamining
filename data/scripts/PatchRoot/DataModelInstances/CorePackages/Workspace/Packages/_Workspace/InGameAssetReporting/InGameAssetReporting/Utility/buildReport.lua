-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReporting = script:FindFirstAncestor("InGameAssetReporting")
local InGameAssetReportingParent = InGameAssetReporting.Parent

local _SceneAnalysis = require(InGameAssetReporting.Analysis.SceneAnalysis)
local getHumanoidDescription = require(InGameAssetReportingParent.GetHumanoidDescription).getHumanoidDescription
local FFlagDropUnroutableMultiReportOptions = require(InGameAssetReportingParent.SharedFlags).FFlagDropUnroutableMultiReportOptions

local HttpService = game:GetService("HttpService")

local tbl1 = {
    Variant = { IGARv1 = "IGARv1", IGARv3 = "IGARv3" }
}

function transformTargetPlayers(extractedPlayers, num1: number)
    local result = {}
    num1 = if num1 == 0 then 1 else num1

    for _, extractedPlayer in ipairs(extractedPlayers) do
        local player = extractedPlayer.player
        local count = extractedPlayer.count
        local humanoidDescription, humanoidDescriptionStatus = getHumanoidDescription(player.UserId)
        table.insert(result, {
            userId = player.UserId,
            hitCount = count,
            hitPercentage = count / num1,
            humanoidDescription = humanoidDescription,
            humanoidDescriptionStatus = humanoidDescriptionStatus
        })
    end
    return result
end

function serializeTargetPlayersIntoTagValues(tbl2)
    local result = {}
    for _, value in ipairs(tbl2) do
        table.insert(result, { data = HttpService:JSONEncode(value) })
    end

    return result
end

local function func1(tbl2)
    local result = {}
    for _, value in ipairs(tbl2) do
        result[#result + 1] = { value.X, value.Y }
    end
    return result
end

local function func2(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local extractedAssets = arg1.extractedAssets
    return #extractedAssets.Image > 0
        or #extractedAssets.Mesh > 0
        or #extractedAssets.Model > 0
        or #extractedAssets.Package > 0
        or #extractedAssets.Text > 0
end

function buildReport(num1: number, str1: string, arg1, str2: string, str3: string, str4: string, tbl2, arg2, str5: string?)
    local input = { tags = 0 }
    local tags = {
        ENTRY_POINT = {
            valueList = {{ data = "in-experience" }}
        },
        SUBMITTER_USER_ID = {
            valueList = {{
                data = tostring(num1)
            }}
        },
        REPORTED_ABUSE_CATEGORY = {
            valueList = {{ data = str2 }}
        },
        REPORTED_ABUSE_SURFACE = {
            valueList = {{ data = str3 }}
        },
        PLACE_ID = 0,
        REPORTER_COMMENT = 0,
        REPORTED_ABUSE_VECTOR = 0,
        VARIANT = 0,
        IGAR_REPORT_TARGET_ASSETS = 0,
        IGAR_EXTRACTION_STATS = 0,
        IGAR_ANNOTATION_COORDINATES = 0
    }

    local placeId = {
        valueList = {{
            data = tostring(game.PlaceId)
        }}
    }
    tags.PLACE_ID = placeId

    tags.REPORTER_COMMENT = {
        valueList = {{ data = str4 }}
    }

    tags.REPORTED_ABUSE_VECTOR = {
        valueList = {{
            data = if not FFlagDropUnroutableMultiReportOptions and str3 == "username" then "user_profile" elseif str3 == "text" and game:GetEngineFeature("ExperienceStateCaptureExperienceChatSupport") then "in-experience-text" else "multi"
        }}
    }

    tags.VARIANT = {
        valueList = {{
            data = tbl1.Variant.IGARv1
        }}
    }

    tags.IGAR_REPORT_TARGET_ASSETS = {
        valueList = {{
            data = HttpService:JSONEncode(arg1.extractedAssets)
        }}
    }

    tags.IGAR_EXTRACTION_STATS = {
        valueList = {{
            data = HttpService:JSONEncode(arg1.stats)
        }}
    }

    tags.IGAR_ANNOTATION_COORDINATES = {
        valueList = {{
            data = HttpService:JSONEncode((func1(tbl2)))
        }}
    }
    input.tags = tags

    if game:GetEngineFeature("ExperienceStateCaptureExperienceChatSupport") and #arg1.extractedAssets.Text > 0 then
        input.tags.IGAR_REPORT_TARGET_IN_EXPERIENCE_TEXT = {
            valueList = {{
                data = HttpService:JSONEncode(arg1.extractedAssets.Text)
            }}
        }
    end

    if game:GetEngineFeature("DeltaFactoryCloneJobId") then
        input.tags.IGAR_REPORT_JOBID = {
            valueList = {{
                data = HttpService:JSONEncode(game.JobId)
            }}
        }
    end

    if arg2 and func2(arg2) then
        input.tags.IGAR_REPORT_TARGET_GUI_ASSETS = {
            valueList = {{
                data = HttpService:JSONEncode(arg2.extractedAssets)
            }}
        }

        if game:GetEngineFeature("ExperienceStateCaptureExperienceChatSupport") then
            input.tags.IGAR_REPORT_TARGET_GUI_IN_EXPERIENCE_TEXT = {
                valueList = {{
                    data = HttpService:JSONEncode(arg2.extractedAssets.Text)
                }}
            }
        end

        input.tags.IGAR_GUI_EXTRACTION_STATS = {
            valueList = {{
                data = HttpService:JSONEncode(arg2.stats)
            }}
        }
    end

    if #arg1.extractedPlayers > 0 then
        local var1 = transformTargetPlayers(arg1.extractedPlayers, arg1.stats.raycastCompletedCount)
        local valueList = serializeTargetPlayersIntoTagValues(var1)
        input.tags.IGAR_REPORT_TARGET_PLAYERS = { valueList = valueList }

        if not FFlagDropUnroutableMultiReportOptions and str3 == "username" then
            local tags = input.tags
            local reportTargetUserId = {
                valueList = {{
                    data = tostring(var1[1].userId)
                }}
            }
            tags.REPORT_TARGET_USER_ID = reportTargetUserId
        end
    end

    if str1 then
        input.tags.SCREENSHOT_ID = {
            valueList = {{ data = str1 }}
        }
    end

    if str5 then
        input.tags.VARIANT.valueList[1].data = tbl1.Variant.IGARv3 .. "-" .. str5
    end

    if not FFlagDropUnroutableMultiReportOptions and str3 == "username" and #arg1.extractedPlayers == 0 then
        return nil
    end

    return HttpService:JSONEncode(input)
end

return buildReport
