-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServer = script:FindFirstAncestor("GraphQLServer")

local AmpUpsellConnector = require(GraphQLServer.graphql.connectors.AmpUpsellConnector)

return {
    default = {
        UpsellFeatureAccessResponse = {
            featureAccess = function(arg1)
                return {
                    featureName = arg1.featureName,
                    access = arg1.access,
                    recourse = arg1.recourse,
                    recourses = arg1.recourses
                }
            end
        },
        Query = {
            getFeatureAccess = function(_, arg1, arg2)
                return AmpUpsellConnector.getFeatureAccessFromFeatureNamesList(arg1.featureNames, arg2.fetchImpl)
            end,
            getUpsellFeatureAccess = function(_, arg1, arg2)
                return AmpUpsellConnector.getUpsellFeatureAccessFromFeatureName(
                    arg1.featureName,
                    arg1.successfulActions,
                    arg2.fetchImpl,
                    arg1.nameSpace,
                    arg1.extraParameters
                )
            end
        }
    }
}
