-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRoduxParent = script:FindFirstAncestor("GameDetailRodux").Parent

local Dash = require(GameDetailRoduxParent.Dash)
local t = require(GameDetailRoduxParent.t)
local Result = require(GameDetailRoduxParent.Result)

local module = {}

function module.new()
    return {}
end

module.validateModel = t.interface({
    summary = t.interface({
        ageRecommendation = t.optional(
            t.interface({
                displayName = t.optional(t.string),
                displayNameWithHeaderShort = t.optional(t.string),
                minimumAge = t.number,
                minimumAgeDisplay = t.optional(t.string),
                contentMaturity = t.optional(t.string),
                igrsRating = t.optional(t.string),
                igrsRatingDisplayMessage = t.optional(t.string)
            })
        )
    }),
    descriptorUsages = t.optional(
        t.array(
            t.interface({
                name = t.optional(t.string),
                followsComplianceApi = t.optional(t.boolean),
                descriptor = t.interface({
                    name = t.string,
                    displayName = t.string,
                    complianceApiSupported = t.boolean,
                    iconUrl = t.optional(t.string),
                    localeCode = t.optional(t.string)
                }),
                descriptorDimensionUsages = t.optional(t.array(t.interface({ dimensionName = t.optional(t.string), dimensionValue = t.optional(t.string) })))
            })
        )
    )
})
function module.mock(arg1)
    local module2 = module.new()

    module2.summary = {
        ageRecommendation = { displayName = "13+", minimumAge = 13 }
    }

    module2.descriptorUsages = {
        {
            descriptor = {
                complianceApiSupported = false,
                displayName = "Blood",
                iconUrl = "https://images.rbxcdn.com/blood-icon.svg",
                name = "blood"
            },
            descriptorDimensionUsages = {
                { dimensionName = "realism", dimensionValue = "unrealistic" },
                { dimensionName = "blood-level", dimensionValue = "heavy" }
            },
            name = "blood"
        },
        {
            descriptor = {
                complianceApiSupported = false,
                displayName = "Violence",
                iconUrl = "https://images.rbxcdn.com/violence-icon.svg",
                name = "violence"
            },
            descriptorDimensionUsages = {
                { dimensionName = "intensity", dimensionValue = "mild" },
                { dimensionName = "frequency", dimensionValue = "infrequent" }
            },
            name = "violence"
        }
    }
    local var1 = Dash.joinDeep(module2, arg1 or {})

    if not module.validateModel(var1) then
        return error("AgeRecommendationDetails mockData is invalid")
    end

    return var1
end

function module.fromJsonData(arg1)
    if not module.validateModel(arg1) then
        return Result.error("AgeRecommendationDetails.fromJsonData expects a valid moderation JSON response")
    end
    local module2 = module.new()
    local var1 = Dash.joinDeep(module2, arg1)

    return Result.success(var1)
end

return module
