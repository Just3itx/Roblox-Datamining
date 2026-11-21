-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    OpenGameDetails = require(script.OpenGameDetails),
    PeekView = require(script.PeekView),
    ExperienceDetailsPeekView = require(script.ExperienceDetailsPage.ExperienceDetailsPeekView),
    ExperienceDetailsBottomSheet = require(script.ExperienceDetailsPage.ExperienceDetailsBottomSheet),
    ExperienceDetailsFullPage = require(script.ExperienceDetailsPage.ExperienceDetailsFullPage),
    ExperienceDetailsPageUtils = require(script.ExperienceDetailsPage.ExperienceDetailsPageUtils),
    createExperienceDetailsPageTimer = require(script.ExperienceDetailsPage.createExperienceDetailsPageTimer),
    fetchExperienceDetailsPage = require(script.ExperienceDetailsPage.fetchExperienceDetailsPage),
    getExperienceDetailsPageKey = require(script.ExperienceDetailsPage.getExperienceDetailsPageKey),
    useExperienceBannerImage = require(script.ExperienceDetailsPage.useExperienceBannerImage),
    AgeCheckUpsellDismissedData = require(script.Signals.AgeCheckUpsellDismissedData),
    AgeCheckUpsellRenderedData = require(script.Signals.AgeCheckUpsellRenderedData),
    ["jest.config"] = script["jest.config"]
}
