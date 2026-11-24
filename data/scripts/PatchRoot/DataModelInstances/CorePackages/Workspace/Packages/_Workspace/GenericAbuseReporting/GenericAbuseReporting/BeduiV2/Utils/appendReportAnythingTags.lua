-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
local HttpService = game:GetService("HttpService")

local GetFFlagReportAnythingEnableAdReport = require(GenericAbuseReportingParent.SharedFlags).GetFFlagReportAnythingEnableAdReport

local function transformVectorArray(convexHull)
    local result = {}
    for _, value in ipairs(convexHull) do
        result[#result + 1] = { value.X, value.Y }
    end
    return result
end

local function transformIdentifiedAds(identifiedAds)
    local result = ({})
    for _, identifiedAd in pairs(identifiedAds) do
        local num1 = #result + 1
        result[num1] = {
            assetId = identifiedAd.assetId,
            distance = identifiedAd.distance,
            boundingBox = {
                minX = identifiedAd.boundingBox.min.X,
                minY = identifiedAd.boundingBox.min.Y,
                maxX = identifiedAd.boundingBox.max.X,
                maxY = identifiedAd.boundingBox.max.Y
            },
            adUnitName = identifiedAd.adUnitName,
            encryptedAdTrackingData = identifiedAd.encryptedAdTrackingData,
            encryptionMetadata = identifiedAd.encryptionMetadata
        }
    end
    return result
end

local function transformIdentifiedAvatars(identifiedAvatars)
    local result = {}

    for k, identifiedAvatar in pairs(identifiedAvatars) do
        local tbl1 = {
            userId = tostring(k),
            distance = identifiedAvatar.distance,
            boundingBox = {
                minX = identifiedAvatar.boundingBox.min.X,
                minY = identifiedAvatar.boundingBox.min.Y,
                maxX = identifiedAvatar.boundingBox.max.X,
                maxY = identifiedAvatar.boundingBox.max.Y
            },
            hitRate = identifiedAvatar.hitRate,
            convexHull = transformVectorArray(identifiedAvatar.convexHull)
        }

        if identifiedAvatar.pointProcessingStats ~= nil then
            tbl1.pointProcessingStats = {
                if identifiedAvatar.pointProcessingStats.wasSkipped then 1 else 0,
                identifiedAvatar.pointProcessingStats.total,
                identifiedAvatar.pointProcessingStats.offScreenDiscardCount,
                identifiedAvatar.pointProcessingStats.tooCloseDiscardCount
            }
        end

        result[#result + 1] = tbl1
    end

    return result
end

local function hasIdentifiedAvatars(identificationResults) -- Luacid: Inlined by compiler; 1 call site recovered
    for _ in pairs(identificationResults.identifiedAvatars) do
        return true
    end
    return false
end

local function hasIdentifiedAds(identificationResults) -- Luacid: Inlined by compiler; 1 call site recovered
    for _ in pairs(identificationResults.identifiedAds) do
        return true
    end
    return false
end

return {
    appendReportAnythingTags = function(tbl1, tbl2)
        if not tbl2 then
            return tbl1
        end

        local identificationResults = tbl2.identificationResults

        if hasIdentifiedAvatars(identificationResults) then
            tbl1.IDENTIFIED_AVATARS = {
                valueList = {{
                    data = HttpService:JSONEncode((transformIdentifiedAvatars(identificationResults.identifiedAvatars)))
                }}
            }
        end

        if identificationResults.avatarIDStats then
            tbl1.AVATAR_ID_STATS = {
                valueList = {{
                    data = HttpService:JSONEncode(identificationResults.avatarIDStats)
                }}
            }
        end

        if GetFFlagReportAnythingEnableAdReport() then
            if hasIdentifiedAds(identificationResults) then
                tbl1.IDENTIFIED_ADS = {
                    valueList = {{
                        data = HttpService:JSONEncode((transformIdentifiedAds(identificationResults.identifiedAds)))
                    }}
                }
            end

            if identificationResults.adIDStats then
                tbl1.AD_ID_STATS = {
                    valueList = {{
                        data = HttpService:JSONEncode(identificationResults.adIDStats)
                    }}
                }
            end
        end

        if #tbl2.screenshotId > 0 then
            tbl1.SCREENSHOT_ID = {
                valueList = {{
                    data = tbl2.screenshotId
                }}
            }
        end

        return tbl1
    end
}
