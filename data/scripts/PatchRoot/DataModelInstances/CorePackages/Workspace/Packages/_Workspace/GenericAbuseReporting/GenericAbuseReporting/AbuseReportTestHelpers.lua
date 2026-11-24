-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)
local RoactNetworking = require(GenericAbuseReportingParent.RoactServiceTags).RoactNetworking
local RoactServices = require(GenericAbuseReportingParent.RoactServices).RoactServices

local LoaderContext = require(GenericAbuseReporting.BeduiV2.Loaders.LoaderContext)
local MockProviders = require(GenericAbuseReporting.MockProviders)

local LoaderProvider = LoaderContext.LoaderProvider

local function findEventsBySubType(arg1, subEventType: string, func1: ((...any) -> (...any))?)
    local eventsBySubType = {}
    for _, call in arg1.mock.calls do
        local var1 = call[2]
        if var1 and var1.sub_event_type == subEventType and (func1 == nil or func1(var1)) then
            table.insert(eventsBySubType, call)
        end
    end

    return eventsBySubType
end

return {
    wrapInAbuseReportProviders = function(child, tbl1)
        local tbl2 = tbl1 or {}
        return React.createElement(
            RoactServices.ServiceProvider,
            {
                services = {
                    [RoactNetworking] = tbl2.networkImpl or {}
                }
            },
            {
                Providers = React.createElement(MockProviders, nil, {
                    LoaderCtx = React.createElement(
                        LoaderProvider,
                        {
                            loaders = tbl2.loaders or {},
                            open = tbl2.loaderOpen == nil or tbl2.loaderOpen
                        },
                        { Child = child }
                    )
                })
            }
        )
    end,
    makeMinimalCloseConfig = function()
        return {
            version = 1,
            resources = {},
            attributes = {},
            display = { closeButtonLabel = "Close" },
            nodes = {
                root = {
                    type = "paragraph",
                    title = "Root",
                    paragraph = "Root paragraph",
                    nextButtonText = "Continue",
                    next = { type = "close" }
                }
            },
            translations = {}
        }
    end,
    makeListParagraphConfig = function()
        return {
            name = "test_list_paragraph",
            version = 1,
            resources = {},
            attributes = {},
            submission = {
                endpoint = "test",
                data = {
                    abuseVector = "test",
                    targetIdStr = "test",
                    category = "test",
                    comment = "test",
                    targetType = "user"
                }
            },
            display = { closeButtonLabel = "Close" },
            nodes = {
                root = {
                    type = "list",
                    eyebrow = "Report",
                    title = "Select an option",
                    items = {{ id = "test", label = "TestItem1" }},
                    nextButtonText = "Continue",
                    next = { type = "close" }
                }
            },
            translations = {}
        }
    end,
    makeMomentCommentConfig = function()
        return {
            name = "moment_comment",
            version = 5,
            attributeSchema = {
                abuseVector = { type = "string", required = true },
                entryPoint = { type = "string" },
                targetId = { type = "string", required = true, source = "caller" },
                channelId = { type = "string", required = true, source = "caller" },
                reportedUserId = { type = "string", required = true, source = "caller" }
            },
            attributes = {
                abuseVector = "moment_comment",
                entryPoint = "ua",
                targetId = "storybook-comment-id",
                channelId = "storybook-channel-id",
                reportedUserId = "1234567890"
            },
            resources = {
                abuseTypes = {
                    type = "listItem",
                    value = {
                        {
                            id = "ABUSE_CATEGORY_DATING_OR_SEXUAL_CONTENT",
                            label = { ["$translate"] = "Label.AbuseRomanceSex" }
                        },
                        {
                            id = "ABUSE_CATEGORY_OFFSITE_LINKS",
                            label = { ["$translate"] = "Label.AbuseOffPlatformLinks" }
                        },
                        {
                            id = "ABUSE_CATEGORY_PERSONAL_QUESTION",
                            label = { ["$translate"] = "Label.AbusePersonalInformation" }
                        },
                        {
                            id = "ABUSE_CATEGORY_VIOLENCE_OR_TERRORISM",
                            label = { ["$translate"] = "Label.AbuseViolence" }
                        },
                        {
                            id = "ABUSE_CATEGORY_SWEARING",
                            label = { ["$translate"] = "Label.AbuseSwearing" }
                        },
                        {
                            id = "ABUSE_CATEGORY_DISCRIMINATION",
                            label = { ["$translate"] = "Label.AbuseDiscrimination" }
                        },
                        {
                            id = "ABUSE_CATEGORY_BULLYING",
                            label = { ["$translate"] = "Label.AbuseBullying" }
                        },
                        {
                            id = "ABUSE_CATEGORY_SCAMMING",
                            label = { ["$translate"] = "Label.AbuseScamming" }
                        }
                    }
                }
            },
            display = {
                closeButtonLabel = { ["$translate"] = "Action.Close" },
                titleDisclosure = {
                    tooltipTitle = { ["$translate"] = "Title.HowReportsWork" },
                    tooltipText = { ["$translate"] = "Description.HowReportsWork" },
                    closeButtonLabel = { ["$translate"] = "Action.Close" }
                }
            },
            nodes = {
                root = {
                    type = "list",
                    title = { ["$translate"] = "Title.WhatIssue" },
                    items = { ["$resource"] = "abuseTypes" },
                    required = true,
                    storeAs = "selectedAbuseType",
                    nextButtonText = { ["$translate"] = "Action.Continue" },
                    errorText = { ["$translate"] = "Label.GeneralError" },
                    retryButtonText = { ["$translate"] = "Action.Retry" },
                    next = "summary"
                },
                summary = {
                    type = "comment",
                    title = { ["$translate"] = "Title.TellUsMore" },
                    storeAs = "comment",
                    textAreaLabel = { ["$translate"] = "Label.TellUsMoreLabel" },
                    placeholder = { ["$translate"] = "Label.TellUsMorePlaceholder" },
                    maxLength = 1000,
                    helperText = { ["$translate"] = "Label.CharacterCountWithLimit" },
                    nextButtonText = { ["$translate"] = "Action.Report" },
                    next = {
                        type = "submitForm",
                        onSuccess = "confirmation",
                        onFailure = "generalError"
                    }
                },
                confirmation = {
                    type = "confirmation",
                    title = { ["$translate"] = "Title.ReportSent" },
                    message = { ["$translate"] = "Description.ReportSent" },
                    nextButtonText = { ["$translate"] = "Action.Ok" },
                    next = { type = "close" }
                },
                generalError = {
                    type = "paragraph",
                    title = { ["$translate"] = "Title.SomethingWentWrong" },
                    paragraph = { ["$translate"] = "Description.SomethingWentWrong" },
                    nextButtonText = { ["$translate"] = "Action.Close" },
                    next = { type = "close" }
                }
            },
            submission = {
                target = { type = "default" },
                data = {
                    abuseVector = { ["$attribute"] = "abuseVector" },
                    targetIdStr = { ["$attribute"] = "targetId" },
                    category = { ["$store"] = "selectedAbuseType.id" },
                    comment = { ["$store"] = "comment" },
                    custom = {
                        ENTRY_POINT = { ["$attribute"] = "entryPoint" },
                        COMMUNICATION_CHANNEL_ID = { ["$attribute"] = "channelId" },
                        COMMUNICATION_MESSAGE_ID = { ["$attribute"] = "targetId" },
                        REPORT_TARGET_USER_ID = { ["$attribute"] = "reportedUserId" }
                    },
                    targetType = "asset"
                }
            },
            translations = {
                ["Action.Close"] = "Close",
                ["Action.Continue"] = "Continue",
                ["Action.Ok"] = "OK",
                ["Action.Report"] = "Report",
                ["Action.Retry"] = "Retry",
                ["Description.HowReportsWork"] = "We'll review your report and take appropriate action.",
                ["Description.ReportSent"] = "Thanks for helping keep Roblox safe.",
                ["Description.SomethingWentWrong"] = "We weren't able to submit your report. Please try again later.",
                ["Label.AbuseBullying"] = "Bullying",
                ["Label.AbuseDiscrimination"] = "Discrimination",
                ["Label.AbuseOffPlatformLinks"] = "Outside links and trading",
                ["Label.AbusePersonalInformation"] = "Sharing personal information",
                ["Label.AbuseRomanceSex"] = "Romance or sex",
                ["Label.AbuseScamming"] = "Scams",
                ["Label.AbuseSwearing"] = "Swearing",
                ["Label.AbuseViolence"] = "Extreme violence",
                ["Label.CharacterCountWithLimit"] = "{count}/{limit} characters",
                ["Label.GeneralError"] = "Something went wrong. Please try again later.",
                ["Label.TellUsMoreLabel"] = "Additional details",
                ["Label.TellUsMorePlaceholder"] = "Describe what happened",
                ["Title.HowReportsWork"] = "How reports work",
                ["Title.ReportSent"] = "Report sent",
                ["Title.SomethingWentWrong"] = "Something went wrong",
                ["Title.TellUsMore"] = "Tell us more",
                ["Title.WhatIssue"] = "What was the issue?"
            }
        }
    end,
    makeMalformedConfig = function()
        return {
            version = 1,
            resources = {},
            attributes = {},
            display = { closeButtonLabel = "Close" },
            nodes = {},
            translations = {}
        }
    end,
    findEventsBySubType = findEventsBySubType,
    findRenderErrorEvents = function(arg1)
        return (findEventsBySubType(arg1, "Error", function(arg2): boolean
            local errorMessage = arg2.error_detail and arg2.error_detail.error_message
            return type(errorMessage) == "string" and errorMessage:sub(1, 13) == "Render error:"
        end))
    end,
    findFetchErrorEvents = function(arg1)
        return (findEventsBySubType(arg1, "Error", function(arg2): boolean
            local errorMessage = arg2.error_detail and arg2.error_detail.error_message
            return type(errorMessage) == "string" and errorMessage:sub(1, 22) == "Failed to fetch config"
        end))
    end
}
