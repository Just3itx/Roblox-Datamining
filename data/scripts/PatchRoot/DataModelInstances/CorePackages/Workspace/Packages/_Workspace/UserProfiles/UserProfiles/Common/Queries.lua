-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserProfilesParent = script:FindFirstAncestor("UserProfiles").Parent
local queries = require(UserProfilesParent.ApolloLocalState).queries

return {
    userProfilesCombinedNameByUserIds = queries.userProfilesCombinedNameByUserIds,
    userProfilesCombinedNameAndAliasByUserIds = queries.userProfilesCombinedNameAndAliasByUserIds,
    userProfilesCombinedNameAndUsernameByUserIds = queries.userProfilesCombinedNameAndUsernameByUserIds,
    userProfilesBasicNamesByUserIds = queries.userProfilesBasicNamesByUserIds,
    userProfilesAllNamesByUserIds = queries.userProfilesAllNamesByUserIds,
    userProfilesDisplayNameAndUsernameByUserIds = queries.userProfilesDisplayNameAndUsernameByUserIds,
    userProfilesDisplayUserPlatformNamesByUserIds = queries.userProfilesDisplayUserPlatformNamesByUserIds,
    userProfilesInExperienceNamesByUserIds = queries.userProfilesInExperienceNamesByUserIds,
    userProfilesCombinedAndPlatformByUserIds = queries.userProfilesCombinedAndPlatformByUserIds,
    userProfilesPlatformNamesByUserIds = queries.userProfilesPlatformNamesByUserIds,
    userProfilesPlatformProfileIdsByUserIds = queries.userProfilesPlatformProfileIdsByUserIds,
    userProfilesCombinedNameUsernameAndIsVerifiedByUserIds = queries.userProfilesCombinedNameUsernameAndIsVerifiedByUserIds,
    userProfilesFriendsLandingQueryByUserIds = queries.userProfilesFriendsLandingQueryByUserIds
}
