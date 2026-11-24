-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)
local React = require(GenericAbuseReportingParent.React)

local AbuseReportAnalyticsContext = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext)
local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local _AbuseSheetFlowTypes = require(script.Parent.AbuseSheetFlowTypes)
local CommentNode = require(GenericAbuseReporting.BeduiV2.Components.Nodes.CommentNode)
local ConfirmationNode = require(GenericAbuseReporting.BeduiV2.Components.Nodes.ConfirmationNode)
local ListNodeV2 = require(GenericAbuseReporting.BeduiV2.Components.Nodes.ListNodeV2)
local ParagraphNode = require(GenericAbuseReporting.BeduiV2.Components.Nodes.ParagraphNode)
local ReviewNode = require(GenericAbuseReporting.BeduiV2.Components.Nodes.ReviewNode)

local TelemetryEventType = analyticsService.TelemetryEventType
local useAbuseReportAnalytics = AbuseReportAnalyticsContext.useAbuseReportAnalytics

local FFlagSupportSubmissionOnAllReportNodes = require(GenericAbuseReportingParent.SharedFlags).FFlagSupportSubmissionOnAllReportNodes
local FFlagAbuseReportInExpPlayerListV3 = require(GenericAbuseReportingParent.SharedFlags).FFlagAbuseReportInExpPlayerListV3
local FFlagAbuseReportImproveErrorEvents = require(GenericAbuseReporting.Flags.FFlagAbuseReportImproveErrorEvents)

return React.memo(function(tbl1) -- name: ContentNode
    local sendEvent = useAbuseReportAnalytics().sendEvent

    if tbl1.node.type == "list" then
        local var1 = if tbl1.store then tbl1.store[tbl1.node.storeAs] else nil
        local id = if type(var1) == "table" then var1.id else nil

        return React.createElement(
            ListNodeV2,
            Dash.join(tbl1.node, {
                initialValue = id,
                isSubmitting = tbl1.isSubmitting,
                onNext = function(_: string, arg1)
                    if not tbl1.onNext then
                        return
                    end

                    local onNext2 = tbl1.onNext
                    local tbl2 = {
                        store = if tbl1.node.storeAs then {
                            [tbl1.node.storeAs] = arg1
                        } else {}
                    }
                    onNext2(tbl2)
                end
            })
        )
    elseif tbl1.node.type == "comment" then
        local initialValue = if tbl1.store then tbl1.store[tbl1.node.storeAs] else nil

        return React.createElement(
            CommentNode,
            Dash.join(tbl1.node, {
                initialValue = initialValue,
                isSubmitting = tbl1.isSubmitting,
                onNext = function(str1: string)
                    if not tbl1.onNext then
                        return
                    end

                    local onNext2 = tbl1.onNext
                    local tbl2 = {
                        store = if tbl1.node.storeAs then {
                            [tbl1.node.storeAs] = str1
                        } else {}
                    }
                    onNext2(tbl2)
                end
            })
        )
    elseif tbl1.node.type == "confirmation" then
        local createElement = React.createElement
        local var1 = ConfirmationNode

        return createElement(
            var1,
            Dash.join(tbl1.node, {
                isSubmitting = if FFlagSupportSubmissionOnAllReportNodes then tbl1.isSubmitting else nil,
                onNext = if tbl1.onNext then function()
                    tbl1.onNext({})
                end or nil else nil
            })
        )
    elseif tbl1.node.type == "paragraph" then
        local createElement = React.createElement
        local var1 = ParagraphNode

        return createElement(
            var1,
            Dash.join(tbl1.node, {
                isSubmitting = if FFlagSupportSubmissionOnAllReportNodes then tbl1.isSubmitting else nil,
                onNext = if tbl1.onNext then function()
                    tbl1.onNext({})
                end or nil else nil
            })
        )
    elseif tbl1.node.type == "review" then
        local createElement = React.createElement
        local var1 = ReviewNode

        return createElement(
            var1,
            Dash.join(tbl1.node, {
                isSubmitting = if FFlagSupportSubmissionOnAllReportNodes then tbl1.isSubmitting else nil,
                onNext = if tbl1.onNext then function()
                    tbl1.onNext({})
                end or nil else nil
            })
        )
    else
        if tbl1.node.type == "inExpChatSelection" then
            local inExpChatSelectionNode = require(GenericAbuseReporting.BeduiV2.Components.Nodes.InExpChatSelectionNode)
            local var1 = if tbl1.store then tbl1.store[tbl1.node.storeAs] else nil
            local id = if type(var1) == "table" then var1.id else nil

            return React.createElement(
                inExpChatSelectionNode,
                Dash.join(tbl1.node, {
                    initialValue = id,
                    isSubmitting = tbl1.isSubmitting,
                    goBack = tbl1.goBack,
                    onNext = function(_: string?, arg1)
                        if not tbl1.onNext then
                            return
                        end

                        local onNext2 = tbl1.onNext
                        local tbl2 = {
                            store = if tbl1.node.storeAs then {
                                [tbl1.node.storeAs] = arg1
                            } else {}
                        }
                        onNext2(tbl2)
                    end
                })
            )
        end

        if tbl1.node.type ~= "inExpConfirmation" then
            if tbl1.node.type == "inExpSceneSelection" then
                local inExpSceneSelectionNode = require(GenericAbuseReporting.BeduiV2.Components.Nodes.InExpSceneSelectionNode)
                return React.createElement(
                    inExpSceneSelectionNode,
                    Dash.join(tbl1.node, {
                        onNext = tbl1.onNext and function()
                            tbl1.onNext({})
                        end or nil,
                        onFailure = tbl1.onFailure,
                        goBack = tbl1.goBack,
                        onExternalSubmit = tbl1.onExternalSubmit
                    })
                )
            end

            if FFlagAbuseReportInExpPlayerListV3 and tbl1.node.type == "inExpUserSelection" then
                local inExpUserSelectionNode = require(GenericAbuseReporting.BeduiV2.Components.Nodes.InExpUserSelectionNode)
                local var1 = if tbl1.store then tbl1.store[tbl1.node.storeAs] else nil
                local id = if type(var1) == "table" then var1.id else nil

                return React.createElement(
                    inExpUserSelectionNode,
                    Dash.join(tbl1.node, {
                        initialValue = id,
                        isSubmitting = tbl1.isSubmitting,
                        onNext = tbl1.onNext and function(_: string?, arg1)
                            if not tbl1.onNext then
                                return
                            end

                            local onNext = tbl1.onNext
                            local tbl2 = {
                                store = if tbl1.node.storeAs then {
                                    [tbl1.node.storeAs] = arg1
                                } else {}
                            }
                            onNext(tbl2)
                        end or nil,
                        goBack = tbl1.goBack
                    })
                )
            end
            local tbl2 = {
                sub_event_type = TelemetryEventType.Error,
                error_detail = 0
            }
            local tbl3

            if FFlagAbuseReportImproveErrorEvents then
                tbl3 = {
                    error_message = "Unknown node type",
                    error_metadata = {
                        node_type = tostring(tbl1.node.type)
                    }
                }
            else
                tbl3 = {
                    error_message = `Unknown node type: {tbl1.node.type}`
                }
            end

            tbl2.error_detail = tbl3
            sendEvent(tbl2)

            return React.createElement(React.Fragment)
        end

        local inExpConfirmationNode = require(GenericAbuseReporting.BeduiV2.Components.Nodes.InExpConfirmationNode)
        local createElement = React.createElement

        return createElement(
            inExpConfirmationNode,
            Dash.join(tbl1.node, {
                isSubmitting = tbl1.isSubmitting,
                onNext = if tbl1.onNext then function(tbl2)
                    local onNext = tbl1.onNext
                    local tbl3 = {
                        store = if tbl1.node.storeAs then {
                            [tbl1.node.storeAs.didBlockUser] = tbl2.didBlockUser,
                            [tbl1.node.storeAs.didMuteUser] = tbl2.didMuteUser
                        } else {}
                    }
                    onNext(tbl3)
                end or nil else nil
            })
        )
    end
end)
