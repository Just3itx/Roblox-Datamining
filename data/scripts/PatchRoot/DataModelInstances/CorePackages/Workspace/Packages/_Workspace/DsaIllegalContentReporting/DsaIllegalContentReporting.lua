-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:06:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local isSelectedDataDSAIllegalContent = require(script.Utility.isSelectedDataDSAIllegalContent)
return {
    isShowEUDSAIllegalContentReportingLink = require(script.Utility.isShowEUDSAIllegalContentReportingLink),
    isSelectedDataDSAIllegalContent = isSelectedDataDSAIllegalContent,
    isInDSAFeaturesOverrideList = require(script.Utility.isInDSAFeaturesOverrideList),
    DSAReportLink = require(script.Components.DSAReportLink),
    Constants = require(script.Utility.Constants),
    OSAReportLink = require(script.Components.OSAReportLink),
    isShowUKOSAIllegalContentReportingLink = require(script.Utility.isShowUKOSAIllegalContentReportingLink),
    GenericReportLink = require(script.Components.GenericReportLink),
    isShowGenericIllegalContentReportingLink = require(script.Utility.isShowGenericIllegalContentReportingLink),
    TakeItDownReportLink = require(script.Components.TakeItDownReportLink),
    getTakeItDownReportLinkVisibility = require(script.Utility.getTakeItDownReportLinkVisibility),
    ["jest.config"] = script["jest.config"]
}
